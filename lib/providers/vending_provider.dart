import 'package:np_vending_machine_app/models/drink.dart';

class VendingManager {
  static const int maxInputAmount = 7000;

  int _insertedAmount = 0;
  final Map<int, int> _insertedUnits = {}; // 화폐 단위 → 수량
  final Map<int, int> _changeUnits = {
    10: 10,
    50: 10,
    100: 10,
    500: 10,
    1000: 5,
  };

  final List<Drink> drinks = [
    Drink(name: '믹스커피', price: 200, stock: 5),
    Drink(name: '고급믹스커피', price: 300, stock: 3),
    Drink(name: '물', price: 450, stock: 4),
    Drink(name: '캔커피', price: 500, stock: 2),
    Drink(name: '이온음료', price: 550, stock: 2),
    Drink(name: '고급캔커피', price: 700, stock: 2),
    Drink(name: '탄산음료', price: 750, stock: 1),
    Drink(name: '특화음료', price: 800, stock: 0),
  ];

  int get insertedAmount => _insertedAmount;
  Map<int, int> get insertedUnits => Map.unmodifiable(_insertedUnits);
  Map<int, int> get changeUnits => Map.unmodifiable(_changeUnits);

  void insertMoney(int unit) {
    if (_insertedAmount + unit > maxInputAmount) return;

    _insertedUnits[unit] = (_insertedUnits[unit] ?? 0) + 1;
    _insertedAmount += unit;
  }

  bool canBuy(Drink drink) {
    return _insertedAmount >= drink.price && drink.stock > 0;
  }

  bool buyDrink(Drink drink) {
    if (!canBuy(drink)) return false;

    _insertedAmount -= drink.price;
    drink.stock -= 1;

    // 거스름돈 계산은 나중에 로직 추가
    return true;
  }

  void refund() {
    // 거스름돈 반환 처리 (단순 초기화)
    _insertedAmount = 0;
    _insertedUnits.clear();
  }

  void resetAll() {
    _insertedAmount = 0;
    _insertedUnits.clear();
    // changeUnits도 서버에서 관리할 경우 나중에 처리
  }
}
