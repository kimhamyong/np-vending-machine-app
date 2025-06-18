import 'package:flutter/material.dart';
import 'package:np_vending_machine_app/models/drink.dart';
import 'package:np_vending_machine_app/screens/vending/widgets/drink_box.dart';

class DrinkGridSection extends StatelessWidget {
  final List<Drink> drinks;
  final Drink? selectedDrink;
  final void Function(Drink) onSelect;

  const DrinkGridSection({
    super.key,
    required this.drinks,
    required this.selectedDrink,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2FF),
        border: Border.all(color: Colors.white, width: 5),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: drinks.map<Widget>((drink) {
          return DrinkBox(
            drink: drink,
            isEnabled: drink.stock > 0,
            isSelected: selectedDrink == drink,
            onTap: () => onSelect(drink),
          );
        }).toList(),
      ),
    );
  }
}
