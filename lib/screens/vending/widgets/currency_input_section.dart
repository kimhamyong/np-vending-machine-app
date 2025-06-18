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
        // 왼쪽: 동전 + 지폐
        Column(
          children: [
            Row(
              children: [
                _buildMoneyButton(10),
                const SizedBox(width: 16),
                _buildMoneyButton(50),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildMoneyButton(100),
                const SizedBox(width: 16),
                _buildMoneyButton(500),
              ],
            ),
            _buildMoneyButton(1000),
          ],
        ),
        const SizedBox(width: 25),

        // 오른쪽: 금액, 반환, 구매 버튼, 관리자 모드 버튼
        Column(
          children: [
            // 관리자 모드 버튼
            SizedBox(
              width: 190,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login', arguments: {
                    'isAdmin': true,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 132, 132, 132),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '관리자 모드',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // 현재 금액 박스
            Container(
              width: 190,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '₩ $insertedAmount',
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 23),
            // 반환 + 구매 버튼
            Row(
              children: [
                _buildActionButton('반환', onRefund, Colors.redAccent),
                const SizedBox(width: 12),
                _buildActionButton('구매', onPurchase, Colors.green),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _buildMoneyButton(int unit) {
    final isThousand = unit == 1000;
    final width = isThousand ? 140.0 : 70.0;
    final height = isThousand ? 120.0 : 70.0;

    return GestureDetector(
      onTap: () => onInsertMoney(unit),
      child: Image.asset(
        'assets/images/$unit.png',
        width: width,
        height: height,
        errorBuilder: (_, __, ___) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text('$unit'),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed, Color color) {
    return SizedBox(
      width: 90,
      height: 90,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
