import 'package:flutter/material.dart';

class AdminAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: 비밀번호 입력 UI
    return Scaffold(
      appBar: AppBar(title: Text('관리자 인증')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('비밀번호를 입력하세요'),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/admin'),
              child: Text('관리자 모드로 이동'),
            ),
          ],
        ),
      ),
    );
  }
}
