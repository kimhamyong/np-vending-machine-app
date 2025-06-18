import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  final String buttonText;

  const ErrorDialog({
    Key? key,
    required this.message,
    this.buttonText = '확인',
  }) : super(key: key);

  /// 간편 호출용 static method
  static void show(BuildContext context, String message,
      {String buttonText = '확인'}) {
    showDialog(
      context: context,
      builder: (_) => ErrorDialog(message: message, buttonText: buttonText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      backgroundColor: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.black26, width: 0.5),
              ),
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
