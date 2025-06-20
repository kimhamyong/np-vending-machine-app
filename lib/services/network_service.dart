// lib/services/network_service.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:np_vending_machine_app/services/tcp_connection.dart';

bool get isMobilePlatform => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

class NetworkService {
  static final Dio _dio = Dio();

  // 회원가입 전송 (모바일에서는 TCP, 웹에서는 HTTP)
  static Future<Map<String, dynamic>> sendAndPost({
    required String apiPath,
    required Map<String, dynamic> payload,
  }) async {
    if (isMobilePlatform) {
      // 모바일에서는 TCP로 전송
      TcpConnectionManager.instance.send(jsonEncode(payload));
      return {}; // 빈 맵 반환 (모바일에서 TCP를 사용하는 경우)
    } else {
      // 웹에서는 HTTP로 POST 요청
      try {
        final response = await _dio.post(apiPath, data: payload);
        return response.data != null ? response.data : {}; // 응답 데이터 반환
      } catch (e) {
        print('웹 요청 실패: $e');
        rethrow; // 오류 발생 시 예외를 던짐
      }
    }
  }
}
