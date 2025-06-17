import 'package:flutter/material.dart';
import 'package:np_vending_machine_app/models/drink.dart';

class DrinkBox extends StatelessWidget {
  final Drink drink;
  final bool isEnabled;
  final bool isSelected;
  final VoidCallback onTap;

  const DrinkBox({
    super.key,
    required this.drink,
    required this.isEnabled,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.4,
        child: Container(
          width: 150,
          height: 80,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2, 2),
                blurRadius: 4,
              ),
            ],
            border: isSelected
                ? Border.all(color: Colors.blueAccent, width: 2)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                drink.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pretendard',
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${drink.price}원',
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Pretendard',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
