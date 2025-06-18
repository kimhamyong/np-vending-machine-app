class Drink {
  String name;
  int price;
  int stock;
  bool requested;
  int? pendingStock;

  Drink({
    required this.name,
    required this.price,
    required this.stock,
    this.requested = false,
    this.pendingStock,
  });

  bool get canSelect => stock > 0;
}
