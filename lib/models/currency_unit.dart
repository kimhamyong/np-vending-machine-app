class CurrencyUnit {
  final int amount; // 10, 50, 100, 500, 1000
  int count; // 현재 보유 개수 (SharedPreferences와 연동)

  CurrencyUnit({
    required this.amount,
    required this.count,
  });
}
