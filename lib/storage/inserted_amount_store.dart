import 'package:shared_preferences/shared_preferences.dart';

class InsertedAmountStore {
  static SharedPreferences? _prefs;
  static const _amountKey = 'inserted_amount';
  static const _moneyListKey = 'inserted_money_list';

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static int get totalAmount => _prefs?.getInt(_amountKey) ?? 0;

  static List<int> get insertedMoney {
    final list = _prefs?.getStringList(_moneyListKey) ?? [];
    return list.map(int.parse).toList();
  }

  static Future<void> saveState({
    required int total,
    required List<int> moneyList,
  }) async {
    await _prefs?.setInt(_amountKey, total);
    await _prefs?.setStringList(
        _moneyListKey, moneyList.map((e) => e.toString()).toList());
  }

  static Future<void> reset() async {
    await _prefs?.remove(_amountKey);
    await _prefs?.remove(_moneyListKey);
  }
}
