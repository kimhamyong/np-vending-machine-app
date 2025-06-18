import 'package:flutter/material.dart';
import 'package:np_vending_machine_app/models/drink.dart';

class DrinkEditProvider extends ChangeNotifier {
  final Drink drink;

  int stock;
  bool requested;

  String _name;
  String _priceStr;

  DrinkEditProvider(this.drink)
      : stock = drink.pendingStock ?? drink.stock,
        requested = drink.requested,
        _name = drink.name,
        _priceStr = drink.price.toString();

  void increaseStock() {
    stock++;
    notifyListeners();
  }

  void decreaseStock() {
    if (stock > 0) {
      stock--;
      notifyListeners();
    }
  }

  void updateName(String name) {
    _name = name;
    notifyListeners();
  }

  void updatePrice(String price) {
    _priceStr = price;
    notifyListeners();
  }

  bool get isStockChanged => stock != drink.stock;
  bool get canRequest => isStockChanged && !requested;
  bool get canConfirm => requested;

  Future<void> requestFill() async {
    // 재고 요청은 서버에 반영되지만, 실제 반영은 confirmFill에서 수행
    await Future.delayed(const Duration(milliseconds: 300));
    requested = true;
    drink.requested = true;
    drink.pendingStock = stock; // 변경된 재고는 pendingStock에만 반영
    notifyListeners();
  }

  void confirmFill() {
    // 재고 확정
    drink.stock = stock;
    drink.pendingStock = null;
    requested = false;
    drink.requested = false;
    notifyListeners();
  }

  void confirmEdit() {
    drink.name = _name;
    final parsed = int.tryParse(_priceStr);
    if (parsed != null) {
      drink.price = parsed;
    }
    notifyListeners();
  }

  // Getter for UI
  String get name => _name;
  String get priceStr => _priceStr;
}
