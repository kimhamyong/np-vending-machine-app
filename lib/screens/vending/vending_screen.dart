import 'package:flutter/material.dart';

class VendingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('자판기 화면')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Vending Screen')),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            child: Text('관리자 페이지로 이동 → 로그인 먼저'),
          ),
        ],
      ),
    );
  }
}
