import 'package:flutter/material.dart';

class AdminBottomNavBar extends StatelessWidget {
  const AdminBottomNavBar({super.key});

  final List<_NavItem> _navItems = const [
    _NavItem(icon: Icons.admin_panel_settings, label: '관리자', route: '/admin'),
    _NavItem(icon: Icons.local_drink, label: '자판기', route: '/vending'),
    _NavItem(icon: Icons.bar_chart, label: '매출', route: '/sales'),
  ];

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return BottomAppBar(
      color: Colors.white,
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _navItems.map((item) {
            final bool isSelected = currentRoute == item.route;
            return InkWell(
              onTap: () {
                if (!isSelected) {
                  Navigator.pushReplacementNamed(context, item.route);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    color: isSelected ? Colors.black : Colors.grey,
                    size: 30,
                  ),
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
