import 'package:flutter/material.dart';
import 'package:np_vending_machine_app/screens/onboarding/delete_screen.dart';
import 'package:np_vending_machine_app/screens/onboarding/initial_screen.dart';
import 'package:np_vending_machine_app/screens/onboarding/login_screen.dart';
import 'package:np_vending_machine_app/screens/onboarding/signup_screen.dart';
import 'package:np_vending_machine_app/screens/onboarding/change_password_screen.dart';
import 'package:np_vending_machine_app/screens/vending/vending_screen.dart';
import 'package:np_vending_machine_app/screens/admin/admin_screen.dart';
import 'package:np_vending_machine_app/screens/admin/sales_screen.dart';
import 'package:np_vending_machine_app/services/dio_service.dart';
import 'package:np_vending_machine_app/storage/coin_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CoinStore.initializeIfNeeded();
  await DioService.init();
  runApp(VendingMachineApp());
}

class VendingMachineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vending Machine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          surfaceTint: Colors.transparent,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => InitialScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/change-password': (context) => ChangePasswordScreen(),
        '/vending': (context) => VendingScreen(),
        '/admin': (context) => AdminScreen(),
        '/sales': (context) => SalesScreen(),
        '/sales': (context) => SalesScreen(),
        '/delete-account': (context) => DeleteAccountScreen(),
      },
    );
  }
}
