import 'drink.dart';

class Sales {
  final Drink drink;
  final int sold;
  final DateTime date;

  Sales({
    required this.drink,
    required this.sold,
    required this.date,
  });

  int get total => drink.price * sold;
}
