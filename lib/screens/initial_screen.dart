import 'package:flutter/material.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: 자판기 선택 + 비밀번호 설정
    return Scaffold(
      appBar: AppBar(title: Text('자판기 선택')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('자판기 번호를 선택하세요 (1~4)'),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/vending'),
              child: Text('1번 자판기 시작'),
            ),
          ],
        ),
      ),
    );
  }
}
