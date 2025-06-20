// lib/services/tcp_connection.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // rootBundle 사용을 위한 import

class TcpConnectionManager {
  static final TcpConnectionManager instance = TcpConnectionManager._internal();

  factory TcpConnectionManager() => instance;

  TcpConnectionManager._internal();

  // host와 port 값을 초기화할 수 있도록
  String host = ''; // 초기값은 비어있음
  int port = 0; // 초기값은 0

  void Function(String message)? onMessageReceived;
  void Function()? onDisconnected;

  Socket? _socket;
  bool _isConnected = false;

  // TCP 연결을 초기화하고 연결을 시도하는 함수
  Future<void> connect() async {
    // host와 port 값이 제대로 설정되었는지 확인
    if (host.isEmpty || port == 0) {
      debugPrint('[TCP] 연결 실패: host와 port가 설정되지 않았습니다.');
      throw Exception('host와 port가 설정되지 않았습니다.');
    }

    try {
      if (_socket == null || !_isConnected) {
        _socket = await Socket.connect(host, port);
        _isConnected = true;

        // 서버에서 데이터를 받을 때마다 호출되는 콜백
        _socket!.listen(
          (data) {
            final responseMessage = utf8.decode(data);
            print('[TCP] 서버 응답: $responseMessage'); // 서버 응답 로그
            if (onMessageReceived != null) {
              onMessageReceived!(responseMessage);
            }
          },
          onDone: _handleDisconnection,
          onError: (_) => _handleDisconnection(),
        );
        debugPrint('[TCP] 연결 성공');
      } else {
        debugPrint('[TCP] 이미 연결되어 있습니다.');
      }
    } catch (e) {
      debugPrint('[TCP] 연결 실패: $e');
      _isConnected = false;
      _scheduleReconnect();
      throw Exception('TCP 연결 실패');
    }
  }

  // 연결 끊어졌을 때 호출되는 함수
  void _handleDisconnection() {
    debugPrint('[TCP] 연결 끊김');
    _isConnected = false;
    _socket?.destroy();
    _socket = null;
    onDisconnected?.call();
    _scheduleReconnect();
  }

  // 일정 시간 후 재연결을 시도하는 함수
  void _scheduleReconnect() {
    Future.delayed(const Duration(seconds: 3), connect);
  }

  // 데이터를 TCP로 전송하는 함수
  Future<void> send(String message) async {
    if (_isConnected && _socket != null) {
      print('[TCP] 전송 데이터: $message');
      _socket!.write(message);
    } else {
      debugPrint('[TCP] 소켓이 연결되지 않음.');
    }
  }

  // 연결을 종료하는 함수
  void close() {
    _socket?.destroy();
    _socket = null;
    _isConnected = false;
  }

  bool get isConnected => _isConnected;
  Socket? get socket => _socket;

  // 앱이 처음 실행될 때 TCP 연결을 자동으로 시도
  Future<void> initializeConnection(String initHost, int initPort) async {
    host = initHost;
    port = initPort;

    // 초기화 후 바로 연결 시도
    await connect();
  }

  // config.json을 읽어서 host와 port를 설정하는 함수
  Future<void> loadConfigAndConnect() async {
    final configString = await rootBundle.loadString('assets/config.json');
    final config = json.decode(configString);
    host = config['host'];
    port = config['port'];

    if (host == null || port == null) {
      throw Exception("config.json에 'host'와 'port'가 정의되어야 합니다.");
    }

    // 연결 설정 후 TCP 연결을 시도
    await connect();
  }
}
