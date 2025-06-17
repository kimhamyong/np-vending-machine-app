import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  static const routeName = '/admin';

  final List<_NavItem> _navItems = const [
    _NavItem(icon: Icons.admin_panel_settings, label: '관리자', route: '/admin'),
    _NavItem(icon: Icons.local_drink, label: '자판기', route: '/vending'),
    _NavItem(icon: Icons.bar_chart, label: '매출', route: '/sales'),
  ];

  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          '관리자',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(
            '관리자 메인 페이지',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pretendard',
              color: Colors.white,
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          _BottomNavBar(currentRoute: routeName, navItems: _navItems),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String route;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

class _BottomNavBar extends StatelessWidget {
  final String currentRoute;
  final List<_NavItem> navItems;

  const _BottomNavBar({required this.currentRoute, required this.navItems});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: navItems.map((item) {
            final bool isSelected =
                ModalRoute.of(context)?.settings.name == item.route;
            return InkWell(
              onTap: () {
                if (!isSelected) {
                  Navigator.pushReplacementNamed(context, item.route);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.icon,
                      color: isSelected ? Colors.black : Colors.grey, size: 30),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      color: isSelected ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
