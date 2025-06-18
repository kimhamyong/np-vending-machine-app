import 'package:flutter/material.dart';
import 'package:np_vending_machine_app/providers/drink_edit_provider.dart';
import 'package:provider/provider.dart';
import 'package:np_vending_machine_app/models/drink.dart';

class DrinkEditBottomSheet extends StatelessWidget {
  final Drink drink;
  final Function(Drink) onConfirm;

  const DrinkEditBottomSheet({
    super.key,
    required this.drink,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DrinkEditProvider>(
      create: (_) => DrinkEditProvider(drink),
      builder: (context, _) {
        return DrinkEditContent(onConfirm: onConfirm);
      },
    );
  }
}

class DrinkEditContent extends StatelessWidget {
  final Function(Drink) onConfirm;

  const DrinkEditContent({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DrinkEditProvider>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 이름 입력
          TextFormField(
            initialValue: provider.drink.name,
            onChanged: provider.updateName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pretendard',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 4),
          // 가격 입력
          TextFormField(
            initialValue: provider.drink.price.toString(),
            onChanged: provider.updatePrice,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pretendard',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintText: '가격 입력',
            ),
          ),
          const SizedBox(height: 20),
          // 수량 조정
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: provider.canConfirm ? null : provider.decreaseStock,
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor:
                      provider.canConfirm ? Colors.grey[400]! : Colors.red,
                  child: Icon(Icons.remove,
                      color:
                          provider.canConfirm ? Colors.white60 : Colors.white),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 80,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFf2f0e8),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: Text(
                  '${provider.stock}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pretendard',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: provider.canConfirm ? null : provider.increaseStock,
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: provider.canConfirm
                      ? Colors.grey[400]!
                      : Colors.green[300],
                  child: Icon(Icons.add,
                      color:
                          provider.canConfirm ? Colors.white60 : Colors.white),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          Column(
            children: [
              // 채우기
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: provider.canConfirm
                      ? () {
                          provider.confirmFill();
                          onConfirm(provider.drink);
                          Navigator.pop(context, true);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: provider.canConfirm
                        ? Colors.grey[800]
                        : Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    '채우기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                      color: provider.canConfirm
                          ? Colors.white
                          : Color(0xFF666666),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 재고 변경
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: provider.canRequest ? provider.requestFill : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    '재고 변경',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                      color: provider.canRequest
                          ? Colors.white
                          : Color(0xFF666666),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 확인
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    provider.confirmEdit();
                    onConfirm(provider.drink);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    '확인',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
