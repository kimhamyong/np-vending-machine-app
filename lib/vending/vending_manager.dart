import 'package:np_vending_machine_app/vending/structures/bst.dart';
import 'package:np_vending_machine_app/vending/structures/stack.dart';
import 'package:np_vending_machine_app/vending/structures/queue.dart';
import 'package:np_vending_machine_app/vending/change_calculator.dart';
import 'package:np_vending_machine_app/storage/coin_store.dart';
import 'package:np_vending_machine_app/storage/inserted_amount_store.dart';

class VendingManager {
  List<int> insertedMoney = [];
  final stack = Stack<int>();
  late final ChangeCalculator calculator;
  int totalAmount = 0;
  final BST coinInventory = BST();

  VendingManager() {
    calculator = ChangeCalculator(coinInventory);
    _loadInitialInventory();
    _loadInsertedState(); // <-- 추가됨
  }

  Future<void> _loadInitialInventory() async {
    final coins = await CoinStore.loadCoins();
    for (final entry in coins.entries) {
      coinInventory.insert(entry.key, entry.value);
    }
  }

  Future<void> _loadInsertedState() async {
    await InsertedAmountStore.init();
    insertedMoney = InsertedAmountStore.insertedMoney;
    totalAmount = InsertedAmountStore.totalAmount;
    for (final unit in insertedMoney) {
      stack.push(unit);
    }
  }

  /// 금액 입력 처리
  void insert(int unit) {
    final currentBills =
        insertedMoney.where((e) => e >= 1000).fold(0, (sum, val) => sum + val);

    if ((unit >= 1000) && (currentBills + unit > 5000)) {
      throw Exception("지폐는 5,000원까지 입력 가능합니다.");
    }

    if (totalAmount + unit > 7000) {
      throw Exception("입력 가능 최대 금액은 7,000원입니다.");
    }

    insertedMoney.add(unit);
    stack.push(unit);
    totalAmount += unit;

    // 동전 입력 시 즉시 저장 (중간 꺼짐 방지)
    InsertedAmountStore.saveState(
      total: totalAmount,
      moneyList: insertedMoney,
    );

    persistInsertedState();
  }

  Future<void> persistInsertedState() async {
    await InsertedAmountStore.saveState(
      total: totalAmount,
      moneyList: insertedMoney,
    );
  }

  /// 반환 처리
  CustomQueue<int> refund() {
    final refundQueue = CustomQueue<int>();
    while (!stack.isEmpty) {
      final unit = stack.pop();
      if (unit != null) {
        refundQueue.enqueue(unit);
      }
    }
    clearInserted();
    return refundQueue;
  }

  /// 음료 구매 및 거스름돈 계산
  Future<CustomQueue<int>> purchase(int price) async {
    if (totalAmount < price) {
      throw Exception("금액이 부족합니다.");
    }

    final changeAmount = totalAmount - price;

    // 1. 입력 금액 자판기에 반영
    for (final unit in insertedMoney) {
      final current = coinInventory.getValue(unit) ?? 0;
      coinInventory.insert(unit, current + 1);
      await CoinStore.setCoin(unit, current + 1);
    }

    // 2. 거스름돈 계산
    CustomQueue<int> change = CustomQueue<int>();
    if (changeAmount > 0) {
      change = await calculator.calculateChange(changeAmount);
      if (change.isEmpty) {
        throw Exception("거스름돈이 부족합니다. 관리자에게 문의해주세요.");
      }
    }

    clearInserted();
    return change;
  }

  void clearInserted() {
    insertedMoney.clear();
    totalAmount = 0;
    stack.clear();
    InsertedAmountStore.reset();
  }

  Future<Map<int, int>> getInventoryStatus() async {
    return await CoinStore.loadCoins();
  }
}
