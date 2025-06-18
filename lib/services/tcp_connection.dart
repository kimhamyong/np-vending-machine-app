import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';

class TcpConnectionManager {
  static final TcpConnectionManager instance = TcpConnectionManager._internal();

  factory TcpConnectionManager() => instance;

  TcpConnectionManager._internal();

  late String host;
  late int port;
  void Function(String message)? onMessageReceived;
  void Function()? onDisconnected;

  Socket? _socket;

  void initialize({
    required String host,
    required int port,
    void Function(String)? onMessageReceived,
    void Function()? onDisconnected,
  }) {
    this.host = host;
    this.port = port;
    this.onMessageReceived = onMessageReceived;
    this.onDisconnected = onDisconnected;
  }

  Future<void> connect() async {
    try {
      _socket = await Socket.connect(host, port);
      _socket!.listen(
        (data) => onMessageReceived?.call(utf8.decode(data)),
        onDone: _handleDisconnection,
        onError: (_) => _handleDisconnection(),
      );
      debugPrint('[TCP] 연결 성공');
    } catch (e) {
      debugPrint('[TCP] 연결 실패: $e');
      _scheduleReconnect();
    }
  }

  void _handleDisconnection() {
    debugPrint('[TCP] 연결 끊김');
    _socket?.destroy();
    _socket = null;
    onDisconnected?.call();
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    Future.delayed(const Duration(seconds: 3), connect);
  }

  void send(String message) {
    _socket?.write(message);
  }

  void close() {
    _socket?.destroy();
    _socket = null;
  }
}
