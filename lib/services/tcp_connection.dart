import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class TcpConnectionManager {
  Socket? _socket;
  final String host;
  final int port;

  final void Function(String) onMessageReceived;
  final void Function()? onDisconnected;

  TcpConnectionManager({
    required this.host,
    required this.port,
    required this.onMessageReceived,
    this.onDisconnected,
  });

  Future<void> connect() async {
    try {
      _socket = await Socket.connect(host, port);
      _socket!.listen(
        (data) => onMessageReceived(utf8.decode(data)),
        onDone: _handleDisconnection,
        onError: (_) => _handleDisconnection(),
      );
      debugPrint('[TCP] 연결 성공');
    } catch (e) {
      debugPrint('[TCP] 연결 실패: \$e');
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

  void close() {
    _socket?.destroy();
    _socket = null;
  }
}
