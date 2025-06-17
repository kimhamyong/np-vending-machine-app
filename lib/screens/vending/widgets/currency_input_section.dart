import 'package:flutter/material.dart';

class CurrencyInputSection extends StatelessWidget {
  final void Function(int) onInsertMoney;
  final VoidCallback onRefund;
  final int insertedAmount;

  const CurrencyInputSection({
    super.key,
    required this.onInsertMoney,
    required this.onRefund,
    required this.insertedAmount,
  });

  @override
  Widget build(BuildContext context) {
    final List<int> currencyUnits = [10, 50, 100, 500, 1000];

    return Column(
      children: [
        // 현재 금액 표시 박스
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$insertedAmount',
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 36,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),

        // 동전/지폐 이미지들
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: currencyUnits.map((unit) {
            return GestureDetector(
              onTap: () => onInsertMoney(unit),
              child: Image.asset(
                'assets/images/$unit.png',
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey[300],
                    child: Center(
                      child: Text('$unit'),
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 12),

        // 반환 버튼
        TextButton(
          onPressed: onRefund,
          style: TextButton.styleFrom(
            backgroundColor: Colors.redAccent,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            '반환',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
