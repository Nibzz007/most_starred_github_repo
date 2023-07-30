import 'package:flutter/material.dart';
import 'package:thiran_tech_task_2/controller/github_repo_data_controller.dart';
import 'package:thiran_tech_task_2/view/splash_screen.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) => GitHubRepoDataProvider(),
      child: MaterialApp(
        home: const SplashScreen(),
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
