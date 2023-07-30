import 'package:flutter/material.dart';
import 'package:thiran_tech_task_2/view/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    goToHome(context);
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/pngwing.com.png',
          height: 80,
          width: 80,
        ),
      ),
    );
  }

  void goToHome(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      ),
    );
  }
}
