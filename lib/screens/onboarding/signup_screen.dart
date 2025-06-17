import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? passwordError;

  // 비밀번호 유효성 검사
  bool isPasswordValid(String password) {
    final regex = RegExp(r'^(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$');
    return regex.hasMatch(password);
  }

  void handleSignup() {
    final password = passwordController.text;
    if (!isPasswordValid(password)) {
      setState(() {
        passwordError = '비밀번호는 8자 이상, 숫자와 특수문자를 포함해야 합니다.';
      });
    } else {
      setState(() => passwordError = null);
      print('회원가입 성공: ${emailController.text}');
      Navigator.pushReplacementNamed(context, '/admin'); // 임시 이동
    }
  }

  Widget buildTextInput(String label, TextEditingController controller,
      {bool obscure = false, String? errorText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
            errorText: errorText,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            buildTextInput('이메일', emailController),
            buildTextInput('비밀번호', passwordController,
                obscure: true, errorText: passwordError),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: handleSignup,
              child: Text('회원가입'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
