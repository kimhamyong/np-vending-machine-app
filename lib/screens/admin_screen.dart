import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: 재고 보충, 가격 변경, 매출 확인, 수금 등
    return Scaffold(
      appBar: AppBar(title: Text('관리자 모드')),
      body: Center(
        child: Text('여기에 관리자 기능 UI 들어갑니다'),
      ),
    );
  }
}
