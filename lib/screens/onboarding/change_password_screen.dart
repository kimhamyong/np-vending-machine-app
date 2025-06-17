import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/change-password';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  String? currentPasswordError;
  String? newPasswordError;
  String? confirmPasswordError;

  bool isPasswordValid(String password) {
    final regex = RegExp(r'^(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$');
    return regex.hasMatch(password);
  }

  void handleChangePassword() {
    final email = emailController.text.trim();
    final currentPassword = currentPasswordController.text;
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmNewPasswordController.text;

    setState(() {
      currentPasswordError = null;
      newPasswordError = null;
      confirmPasswordError = null;
    });

    if (email != currentPassword) {
      setState(() {
        currentPasswordError = '아이디와 현재 비밀번호가 일치하지 않습니다.';
      });
      return;
    }

    if (!isPasswordValid(newPassword)) {
      setState(() {
        newPasswordError = '비밀번호는 8자 이상, 숫자와 특수문자를 포함해야 합니다.';
      });
      return;
    }

    if (newPassword != confirmPassword) {
      setState(() {
        confirmPasswordError = '새 비밀번호가 일치하지 않습니다.';
      });
      return;
    }

    print('비밀번호 변경 완료: $email → $newPassword');
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          '비밀번호 변경',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: kToolbarHeight + 200),

                // 아이디 입력
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: '아이디를 입력해주세요',
                    labelStyle: const TextStyle(fontFamily: 'Pretendard'),
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 현재 비밀번호 입력
                TextField(
                  controller: currentPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '현재 비밀번호를 입력해주세요',
                    labelStyle: const TextStyle(fontFamily: 'Pretendard'),
                    filled: true,
                    fillColor: Colors.white70,
                    errorText: currentPasswordError,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 새 비밀번호 입력
                TextField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '새 비밀번호를 입력해주세요',
                    labelStyle: const TextStyle(fontFamily: 'Pretendard'),
                    filled: true,
                    fillColor: Colors.white70,
                    errorText: newPasswordError,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 새 비밀번호 확인
                TextField(
                  controller: confirmNewPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '새 비밀번호를 다시 입력해주세요',
                    labelStyle: const TextStyle(fontFamily: 'Pretendard'),
                    filled: true,
                    fillColor: Colors.white70,
                    errorText: confirmPasswordError,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 변경 버튼
                ElevatedButton(
                  onPressed: handleChangePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: const Size(double.infinity, 55),
                  ),
                  child: const Text(
                    '비밀번호 변경',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 160),

                // 로그인 화면 이동 안내
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '비밀번호를 바꾸지 않으시겠어요?',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        '로그인',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
