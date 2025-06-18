import 'dart:convert';
import 'package:np_vending_machine_app/services/tcp_connection.dart';

class TcpService {
  static final TcpService _instance = TcpService._internal();
  factory TcpService() => _instance;
  TcpService._internal();

  TcpConnectionManager? _tcp;

  void init(TcpConnectionManager manager) {
    _tcp = manager;
  }

  void send(Map<String, dynamic> data) {
    final json = jsonEncode(data);
    _tcp?.send(json);
  }
}
