import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;

class DioService {
  static Dio? _dio;
  static String? _baseUrl;

  static Future<void> init() async {
    final configString = await rootBundle.loadString('assets/config.json');
    final config = json.decode(configString);

    final host = config['host'];
    final port = config['http_port'];
    if (host == null || port == null) {
      throw Exception("host와 http_port는 config.json에 반드시 정의되어야 합니다.");
    }

    _baseUrl = 'http://$host:$port';
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl!,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      contentType: 'application/json',
    ));
  }

  /// POST 요청
  static Future<Response> post(String path, Map<String, dynamic> data) async {
    if (_dio == null) {
      throw Exception('DioService.init()이 호출되지 않았습니다.');
    }

    try {
      return await _dio!.post(
        path.startsWith('/') ? path : '/$path',
        data: data,
      );
    } catch (e) {
      throw Exception("Dio 요청 중 오류 발생: $e");
    }
  }

  /// baseUrl getter (디버깅 용도 등)
  static String get baseUrl {
    if (_baseUrl == null) {
      throw Exception('DioService.init()이 호출되지 않았습니다.');
    }
    return _baseUrl!;
  }
}
