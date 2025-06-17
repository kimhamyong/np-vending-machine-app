import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? passwordError;
  String? passwordMatchError;

  bool isPasswordValid(String password) {
    final regex = RegExp(r'^(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$');
    return regex.hasMatch(password);
  }

  void handleSignup() {
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    setState(() {
      passwordError = null;
      passwordMatchError = null;
    });

    if (!isPasswordValid(password)) {
      setState(() {
        passwordError = '비밀번호는 8자 이상, 숫자와 특수문자를 포함해야 합니다.';
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        passwordMatchError = '비밀번호가 일치하지 않습니다.';
      });
      return;
    }

    print('회원가입 성공: ${emailController.text}');
    Navigator.pushReplacementNamed(context, '/admin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          '회원가입',
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
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                // 비밀번호 입력
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '비밀번호를 입력해주세요',
                    labelStyle: const TextStyle(fontFamily: 'Pretendard'),
                    filled: true,
                    fillColor: Colors.white70,
                    errorText: passwordError,
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

                // 비밀번호 확인
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '비밀번호를 다시 입력해주세요',
                    labelStyle: const TextStyle(fontFamily: 'Pretendard'),
                    filled: true,
                    fillColor: Colors.white70,
                    errorText: passwordMatchError,
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

                // 회원가입 버튼
                ElevatedButton(
                  onPressed: handleSignup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: const Size(double.infinity, 55),
                  ),
                  child: const Text(
                    '회원가입',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 160),

                // 로그인 페이지 이동 안내
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '이미 계정이 있으신가요?',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        color: Color.fromARGB(255, 0, 0, 0),
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
                          color: Color.fromARGB(255, 0, 0, 0),
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
