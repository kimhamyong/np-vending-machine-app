import 'package:np_vending_machine_app/vending/coin_store.dart';
import 'package:np_vending_machine_app/vending/structures/bst.dart';
import 'package:np_vending_machine_app/vending/structures/sort.dart';
import 'package:np_vending_machine_app/vending/structures/queue.dart';

class ChangeCalculator {
  final BST coinInventory;

  ChangeCalculator(this.coinInventory);

  Future<CustomQueue<int>> calculateChange(int amount) async {
    final units = <int>[];
    coinInventory.inOrder((key, value) {
      units.add(key);
    });

    final sorted = Sort.descending(units);
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
      return CustomQueue<int>();
    }

    // BST, SharedPreferences 반영
    for (final entry in used.entries) {
      final current = coinInventory.getValue(entry.key)!;
      final updated = current - entry.value;
      coinInventory.insert(entry.key, updated);
      await CoinStore.setCoin(entry.key, updated);
    }

    return result;
  }
}
