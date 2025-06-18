import 'package:flutter/material.dart';

class ChangeStatusBox extends StatelessWidget {
  final Map<int, int> status; // ex: {10: 8, 50: 9, 100: 10, 1000: 7}

  const ChangeStatusBox({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '💰 거스름돈 현황',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'Pretendard',
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 20,
            runSpacing: 8,
            children: status.entries.map((e) {
              return Text(
                '${e.key}원: ${e.value}개',
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
