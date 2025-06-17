import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 이메일 입력
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),

            // 비밀번호 입력
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),

            // 로그인 버튼
            ElevatedButton(
              onPressed: () {
                // 로그인 처리 생략, 단순 이동만
                Navigator.pushReplacementNamed(context, '/admin');
              },
              child: Text('로그인'),
            ),
            SizedBox(height: 16),

            // 비밀번호 변경 페이지 이동
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/change-password');
              },
              child: Text('비밀번호를 잊으셨나요?'),
            ),

            // 회원가입 페이지 이동
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
