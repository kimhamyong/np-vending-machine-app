import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('관리자 메인 페이지')),
    Center(child: Text('자판기 페이지')),
    Center(child: Text('매출 관리 페이지')),
  ];

  final List<String> _titles = ['관리자', '자판기', '매출'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_currentIndex])),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings), label: '관리자'),
          BottomNavigationBarItem(icon: Icon(Icons.local_drink), label: '자판기'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '매출'),
        ],
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
