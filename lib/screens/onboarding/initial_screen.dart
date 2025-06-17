import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class InitialScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱바 제거
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 5),
            const Center(
              child: Text(
                '자판기 프로그램',
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Pretendard',
                  color: Colors.indigo,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                '자판기 프로그램에 오신 것을 환영합니다',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 118, 118, 118),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(flex: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(LoginScreen.routeName),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: const Text(
                  '로그인',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Pretendard',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(SignupScreen.routeName),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: const Text(
                  '회원가입',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Pretendard',
                    color: Color.fromARGB(255, 118, 118, 118),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
