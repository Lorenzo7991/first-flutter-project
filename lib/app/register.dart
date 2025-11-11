import 'package:flutter/material.dart';
import 'widgets/app_container.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Create a new account', style: TextStyle(fontSize: 22)),
          const SizedBox(height: 20),
          const TextField(decoration: InputDecoration(labelText: 'Username')),
          const TextField(
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
            child: const Text('Create Account'),
          ),
        ],
      ),
    );
  }
}
