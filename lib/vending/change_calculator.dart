import 'package:np_vending_machine_app/storage/coin_store.dart';
import 'package:np_vending_machine_app/vending/structures/bst.dart';
import 'package:np_vending_machine_app/vending/structures/sort.dart';
import 'package:np_vending_machine_app/vending/structures/queue.dart';

class ChangeCalculator {
  final BST coinInventory;

  ChangeCalculator(this.coinInventory);

  Future<CustomQueue<int>> calculateChange(int amount) async {
    // 최신 SharedPreferences로 coinInventory(BST) 업데이트
    final coinsFromStorage = await CoinStore.loadCoins();
    for (final entry in coinsFromStorage.entries) {
      coinInventory.insert(entry.key, entry.value);
    }

    final units = <int>[];
    coinInventory.inOrder((key, value) {
      units.add(key);
    });

    final sorted = Sort.descending(units); // 큰 단위부터
    final result = CustomQueue<int>();
    final Map<int, int> used = {};

    for (final unit in sorted) {
      int count = coinInventory.getValue(unit) ?? 0;
      while (amount >= unit && count > 0) {
        result.enqueue(unit);
        amount -= unit;
        count--;
        used[unit] = (used[unit] ?? 0) + 1;
      }
    }

    if (amount > 0) {
      return CustomQueue<int>(); // 실패 시 빈 큐
    }

    // 성공 → BST + SharedPreferences에 반영
    for (final entry in used.entries) {
      final updated = (coinInventory.getValue(entry.key) ?? 0) - entry.value;
      coinInventory.insert(entry.key, updated);
      await CoinStore.setCoin(entry.key, updated);
    }

    return result;
  }
}
