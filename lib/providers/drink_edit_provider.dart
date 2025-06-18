import 'package:flutter/material.dart';
import 'package:np_vending_machine_app/models/drink.dart';

class DrinkEditProvider extends ChangeNotifier {
  final Drink drink;
  int stock;
  bool requested;

  DrinkEditProvider(this.drink)
      : stock = drink.pendingStock ?? drink.stock,
        requested = drink.requested;

  void increaseStock() {
    stock++;
    drink.pendingStock = stock;
    notifyListeners();
  }

  void decreaseStock() {
    if (stock > 0) {
      stock--;
      drink.pendingStock = stock;
      notifyListeners();
    }
  }

  void updateName(String name) {
    drink.name = name;
    notifyListeners();
  }

  void updatePrice(String price) {
    final parsed = int.tryParse(price);
    if (parsed != null) {
      drink.price = parsed;
      notifyListeners();
    }
  }

  bool get isStockChanged => stock != drink.stock;
  bool get canRequest => isStockChanged && !requested;
  bool get canConfirm => requested;

  Future<void> requestFill() async {
    // TODO: 실제 요청 API 호출
    await Future.delayed(const Duration(milliseconds: 300));
    requested = true;
    drink.requested = true;
    notifyListeners();
  }

  void confirmFill() {
    drink.stock = stock;
    drink.pendingStock = null;
    requested = false;
    drink.requested = false;
    notifyListeners();
  }
}
