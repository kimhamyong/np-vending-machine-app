class Drink {
  final String name;
  final int price;
  int stock; // 재고 (변할 수 있으므로 가변)

  Drink({
    required this.name,
    required this.price,
    required this.stock,
  });

  bool get canSelect => stock > 0;
}
