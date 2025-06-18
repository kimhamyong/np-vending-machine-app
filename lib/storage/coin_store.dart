import 'package:shared_preferences/shared_preferences.dart';

class CoinStore {
  static const List<int> coinUnits = [10, 50, 100, 500, 1000];

  /// 최초 실행 시 호출 – 단위별 10개로 초기화
  static Future<void> initializeIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    for (final unit in coinUnits) {
      if (!prefs.containsKey('coin_$unit')) {
        await prefs.setInt('coin_$unit', 10);
      }
    }
  }

  /// 현재 거스름돈 상태 조회
  static Future<Map<int, int>> loadCoins() async {
    final prefs = await SharedPreferences.getInstance();
    final result = <int, int>{};
    for (final unit in coinUnits) {
      result[unit] = prefs.getInt('coin_$unit') ?? 0;
    }
    return result;
  }

  /// 특정 단위의 개수 저장
  static Future<void> setCoin(int unit, int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('coin_$unit', count.clamp(0, 999));
  }

  /// 특정 단위의 개수 차감
  static Future<void> reduceCoin(int unit, int count) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt('coin_$unit') ?? 0;
    await prefs.setInt('coin_$unit', (current - count).clamp(0, 999));
  }

  /// 모든 단위 리셋 (예: 수금 시)
  static Future<void> resetAll({int to = 10}) async {
    final prefs = await SharedPreferences.getInstance();
    for (final unit in coinUnits) {
      await prefs.setInt('coin_$unit', to);
    }
  }
}
