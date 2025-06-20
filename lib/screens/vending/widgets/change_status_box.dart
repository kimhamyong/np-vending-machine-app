import 'package:flutter/material.dart';

class ChangeStatusBox extends StatelessWidget {
  final Map<int, int> status;
  const ChangeStatusBox({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(155, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '거스름돈 개수',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'Pretendard',
              color: Color.fromARGB(255, 57, 57, 57),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 5,
            runSpacing: 10,
            children: status.entries.map((e) {
              return ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 90), // 너비 제한
                child: Text(
                  '${e.key}원: ${e.value}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Pretendard',
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
