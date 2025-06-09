import 'package:flutter/material.dart';

class VendingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: 음료 버튼, 금액 입력, 관리자 모드 전환 버튼
    return Scaffold(
      appBar: AppBar(title: Text('자판기')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/admin-auth'),
              child: Text('관리자 모드 진입'),
            ),
          ],
        ),
      ),
    );
  }
}
