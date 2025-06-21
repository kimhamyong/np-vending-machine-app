import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:np_vending_machine_app/services/dio_service.dart';
import 'package:np_vending_machine_app/services/network_service.dart';
import 'package:np_vending_machine_app/services/tcp_connection.dart';
import 'package:np_vending_machine_app/screens/utils/error_dialog.dart';
import 'dart:async'; // Completer를 사용하기 위한 import
import 'package:shared_preferences/shared_preferences.dart'; // SharedPreferences import

class SignupService {
  // 회원가입 함수
  Future<bool> signup(
      BuildContext context, String userId, String password) async {
    final payload = {
      'action': 'user_signup',
      'userid': userId,
      'password': password,
    };

    try {
      print('보내는 데이터: ${jsonEncode(payload)}');

      if (isMobilePlatform) {
        // 모바일에서는 TCP로 요청
        bool success = await _sendTcpRequest(payload, userId, context);
        return success;
      } else {
        // 웹에서도 action 포함된 상태로 전송
        final response = await DioService.post(
          '/api/user/user_signup',
          payload,
        );

        print('서버 응답 타입: ${response.runtimeType}');
        print('서버 응답: $response');

        if (response is Response<dynamic>) {
          if (response.data['success'] == true) {
            print("회원가입 성공: $userId");
            await _saveUserIdToSharedPreferences(userId);
            return true;
          } else {
            ErrorDialog.show(
                context, response.data['error'] ?? '알 수 없는 오류가 발생했습니다.');
            return false;
          }
        } else {
          throw Exception('잘못된 응답 형식');
        }
      }
    } catch (e) {
      print('회원가입 실패: $e');
      ErrorDialog.show(context, '네트워크 오류가 발생했습니다. 다시 시도해 주세요.');
      return false;
    }
  }

  // SharedPreferences에 userId 저장
  Future<void> _saveUserIdToSharedPreferences(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userid', userId);
    print('회원가입 후 userId 저장: $userId');
  }

  // TCP 요청을 전송하는 함수
  Future<bool> _sendTcpRequest(
      Map<String, dynamic> payload, String userId, BuildContext context) async {
    final completer = Completer<bool>();

    try {
      if (TcpConnectionManager.instance.socket == null ||
          !TcpConnectionManager.instance.isConnected) {
        await TcpConnectionManager.instance.connect();
      }

      TcpConnectionManager.instance.onMessageReceived = (response) {
        final responseData = jsonDecode(response);

        if (responseData['success'] == false) {
          ErrorDialog.show(
              context, responseData['error'] ?? '알 수 없는 오류가 발생했습니다.');
          completer.complete(false);
          return;
        }

        if (responseData['success'] == true) {
          print("회원가입 성공: $responseData");
          _saveUserIdToSharedPreferences(userId);
          completer.complete(true);
        }
      };

      TcpConnectionManager.instance.send(jsonEncode(payload));
    } catch (e) {
      print("TCP 요청 실패: $e");
      completer.complete(false);
    }

    return completer.future;
  }
}
