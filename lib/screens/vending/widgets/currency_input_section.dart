import 'package:flutter/material.dart';

class CurrencyInputSection extends StatelessWidget {
  final void Function(int) onInsertMoney;
  final VoidCallback onRefund;
  final VoidCallback onPurchase;
  final int insertedAmount;

  const CurrencyInputSection({
    super.key,
    required this.onInsertMoney,
    required this.onRefund,
    required this.onPurchase,
    required this.insertedAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 왼쪽: 동전 + 천원 지폐
        Column(
          children: [
            Row(
              children: [
                _buildMoneyButton(10),
                const SizedBox(width: 12),
                _buildMoneyButton(50),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildMoneyButton(100),
                const SizedBox(width: 12),
                _buildMoneyButton(500),
              ],
            ),
            const SizedBox(height: 12),
            _buildMoneyButton(1000),
          ],
        ),
        const SizedBox(width: 24),

        // 오른쪽: 현재 금액 + 버튼들
        Column(
          children: [
            // 현재 금액 표시
            Container(
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                '$insertedAmount',
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // 반환 버튼
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: onRefund,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                ),
                child: const Text(
                  '반환',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // 구매 버튼
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: onPurchase,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                ),
                child: const Text(
                  '구매',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildMoneyButton(int unit) {
    return GestureDetector(
      onTap: () => onInsertMoney(unit),
      child: Image.asset(
        'assets/images/$unit.png',
        width: 50,
        height: 50,
        errorBuilder: (_, __, ___) => Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text('$unit'),
          ),
        ),
      ),
    );
  }
}
