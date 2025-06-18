// lib/services/network_service.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:np_vending_machine_app/services/tcp_connection.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

bool get isMobilePlatform => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

class NetworkService {
  static final Dio _dio = Dio();

  /// TCP + HTTP 동시에 보내기
  static Future<void> sendAndPost({
    required String apiPath,
    required Map<String, dynamic> payload,
  }) async {
    // TCP 전송 (모바일에서만)
    if (isMobilePlatform) {
      TcpConnectionManager.instance.send(jsonEncode(payload));
    }

    // HTTP POST 전송
    await _dio.post(apiPath, data: payload);
  }

  /// TCP만 보내기
  static void sendOnlyTcp(Map<String, dynamic> payload) {
    if (isMobilePlatform) {
      TcpConnectionManager.instance.send(jsonEncode(payload));
    }
  }
}
