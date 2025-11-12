import 'package:first_flutter_project/app/home.dart';
import 'package:first_flutter_project/app/login.dart';
import 'package:first_flutter_project/app/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPG Demo',
      theme: ThemeData(primarySwatch: Colors.brown),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const LoginPage());

          case '/register':
            return MaterialPageRoute(builder: (_) => const RegisterPage());

          case '/home':
            final username = settings.arguments as String? ?? 'Guest';
            return MaterialPageRoute(
              builder: (_) => HomePage(username: username),
            );

          default:
            return null;
        }
      },
    );
  }
}
