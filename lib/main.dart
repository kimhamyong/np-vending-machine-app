import 'package:flutter/material.dart';
import 'screens/initial_screen.dart';
import 'screens/vending_screen.dart';
import 'screens/admin_auth_screen.dart';
import 'screens/admin_screen.dart';

void main() {
  runApp(VendingMachineApp());
}

class VendingMachineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vending Machine',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => InitialScreen(),
        '/vending': (context) => VendingScreen(),
        '/admin-auth': (context) => AdminAuthScreen(),
        '/admin': (context) => AdminScreen(),
      },
    );
  }
}
