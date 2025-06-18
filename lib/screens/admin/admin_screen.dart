import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:np_vending_machine_app/screens/admin/widgets/admin_body.dart';
import 'package:np_vending_machine_app/screens/admin/widgets/admin_bottom_nav_bar.dart';
import 'package:np_vending_machine_app/services/tcp_connection.dart';
import 'package:np_vending_machine_app/screens/utils/error_dialog.dart';

class AdminScreen extends StatefulWidget {
  static const routeName = '/admin';

  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late TcpConnectionManager _tcpManager;
  String _host = '127.0.0.1';
  int _port = 9000;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    final configString = await rootBundle.loadString('assets/config.json');
    final config = json.decode(configString);
    setState(() {
      _host = config['host'] ?? '127.0.0.1';
      _port = config['port'] ?? 9000;
    });

    _tcpManager = TcpConnectionManager(
      host: _host,
      port: _port,
      onMessageReceived: _handleServerMessage,
      onDisconnected: () {
        ErrorDialog.show(context, '서버 연결이 끊어졌습니다. 자동 재시도 중입니다.');
      },
    );
    _tcpManager.connect();
  }

  void _handleServerMessage(String message) {
    if (message.contains('soldout')) {
      ErrorDialog.show(context, '해당 음료가 품절되었습니다.');
    }
  }

  @override
  void dispose() {
    _tcpManager.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: null,
      body: AdminBody(),
      bottomNavigationBar: AdminBottomNavBar(),
    );
  }
}
