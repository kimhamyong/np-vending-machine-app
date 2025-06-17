import 'package:flutter/material.dart';
import 'screens/onboarding/initial_screen.dart';
import 'screens/onboarding/login_screen.dart';
import 'screens/onboarding/signup_screen.dart';
import 'screens/onboarding/change_password_screen.dart';
import 'screens/vending/vending_screen.dart';
import 'screens/admin/admin_screen.dart';
import 'screens/admin/sales_screen.dart';

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
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/change-password': (context) => ChangePasswordScreen(),
        '/vending': (context) => VendingScreen(),
        '/admin': (context) => AdminScreen(),
        '/sales': (context) => SalesScreen(),
      },
    );
  }
}
