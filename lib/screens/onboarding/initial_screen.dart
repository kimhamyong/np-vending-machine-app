import 'package:flutter/material.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('초기 화면')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Initial Screen')),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: Text('로그인')),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              child: Text('회원가입')),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/change-password'),
              child: Text('비밀번호 변경')),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/vending'),
              child: Text('자판기 페이지')),
        ],
      ),
    );
  }
}
