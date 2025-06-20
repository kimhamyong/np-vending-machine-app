import 'dart:convert';
import 'package:flutter/material.dart';
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
      'userid': userId,
      'password': password,
    };

    try {
      // 모바일에서는 TCP로, 웹에서는 HTTP로 요청
      if (isMobilePlatform) {
        payload['action'] = 'user_signup';
        // TCP 연결을 초기화하고 연결 후 전송
        bool success =
            await _sendTcpRequest(payload, userId, context); // userId를 함께 넘김
        return success; // 서버 응답에 따라 true 또는 false 반환
      } else {
        // 웹에서는 'action' 제외하고 HTTP 요청
        final response = await NetworkService.sendAndPost(
          apiPath: '/api/user_signup', // 웹에서 사용할 경로
          payload: payload,
        );

        // 응답 타입 출력
        print('서버 응답 타입: ${response.runtimeType}'); // 타입 확인
        print('서버 응답: $response'); // 응답 전체 출력

        // 응답 처리 (success 체크)
        if (response is Map<String, dynamic>) {
          if (response['success'] == true) {
            print("회원가입 성공: $userId");

            // 성공 시 SharedPreferences에 userId 저장
            await _saveUserIdToSharedPreferences(userId);

            return true; // 성공 시 true 반환
          } else {
            // 실패 처리 (에러 메시지 다이얼로그 띄우기)
            ErrorDialog.show(
                context, response['error'] ?? '알 수 없는 오류가 발생했습니다.');
            return false; // 실패 시 false 반환
          }
        } else {
          // 응답 형식이 예상과 다를 경우 처리
          throw Exception('잘못된 응답 형식');
        }
      }
    } catch (e) {
      print('회원가입 실패: $e');
      ErrorDialog.show(context, '네트워크 오류가 발생했습니다. 다시 시도해 주세요.');
      return false; // 실패 시 false 반환
    }
  }

  // SharedPreferences에 userId 저장
  Future<void> _saveUserIdToSharedPreferences(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userid', userId); // userId 저장
    print('회원가입 후 userId 저장: $userId');
  }

  // TCP 요청을 전송하는 함수
  Future<bool> _sendTcpRequest(
      Map<String, dynamic> payload, String userId, BuildContext context) async {
    // Completer를 사용하여 비동기 작업 완료를 처리
    final completer = Completer<bool>();

    try {
      if (TcpConnectionManager.instance.socket == null ||
          !TcpConnectionManager.instance.isConnected) {
        await TcpConnectionManager.instance.connect();
      }

      // 서버 응답을 받기 위한 콜백 설정
      TcpConnectionManager.instance.onMessageReceived = (response) {
        final responseData = jsonDecode(response);

        // 응답이 success: false일 경우 처리
        if (responseData['success'] == false) {
          // 실패 처리
          ErrorDialog.show(
              context, responseData['error'] ?? '알 수 없는 오류가 발생했습니다.');
          completer.complete(false); // 실패 시 false 반환
          return;
        }

        if (responseData['success'] == true) {
          // 성공 처리
          print("회원가입 성공: $responseData");
          // 성공하면 SharedPreferences에 userId 저장
          _saveUserIdToSharedPreferences(userId);
          completer.complete(true); // 성공 시 true 반환
        }
      };

      // TCP로 전송
      TcpConnectionManager.instance.send(jsonEncode(payload));
    } catch (e) {
      print("TCP 요청 실패: $e");
      completer.complete(false); // 실패 시 false 반환
    }

    // Completer가 완료될 때까지 기다림
    return completer.future;
  }
}
