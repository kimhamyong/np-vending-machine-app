import 'package:flutter/material.dart';
import 'package:np_vending_machine_app/models/drink.dart';

class DrinkBox extends StatelessWidget {
  final Drink drink;
  final bool isEnabled;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isAdmin; // ← 추가됨

  const DrinkBox({
    super.key,
    required this.drink,
    required this.isEnabled,
    required this.isSelected,
    required this.onTap,
    this.isAdmin = false, // ← 기본값 false
  });

  @override
  Widget build(BuildContext context) {
    final canTap = isEnabled || isAdmin;

    return GestureDetector(
      onTap: canTap ? onTap : null,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.4,
        child: Container(
          width: 150,
          height: 70,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color.fromARGB(255, 255, 214, 214)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                drink.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pretendard',
                  color: Color.fromARGB(255, 136, 136, 136),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${drink.price}원',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pretendard',
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
