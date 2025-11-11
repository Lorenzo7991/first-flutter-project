import 'package:flutter/material.dart';
import 'widgets/app_container.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/login_background_3.png',
            fit: BoxFit.cover,
          ),

          // Semi-transparent overlay
          Container(color: Colors.black.withValues(alpha: 0.4)),

          // Main content
          AppContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 47, 69, 109),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Text(
                    'Welcome!\nSign in to continue...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, 
                    ),
                  ),
                ),
                const SizedBox(height: 40),
               Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color.fromARGB(255, 155, 181, 229), Color.fromARGB(255, 13, 44, 97)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      TextField(
                        controller: usernameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Color.fromARGB(255, 209, 209, 209)), 
                          hintText: 'Enter your username',
                          hintStyle: TextStyle(color: Color.fromARGB(255, 209, 209, 209)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 13, 44, 97)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 13, 44, 97), width: 2),
                          ),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Color.fromARGB(255, 209, 209, 209)),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Color.fromARGB(255, 209, 209, 209)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 13, 44, 97)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 13, 44, 97), width: 2),
                          ),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 155, 181, 229),
                        Color.fromARGB(255, 13, 44, 97),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 8,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, 
                      shadowColor: Colors.transparent,     
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/home'),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: const Text(
                    'You don\'t have an account yet? Register!',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 127, 201),
                      decoration: TextDecoration.underline,
                      decorationColor: Color.fromARGB(255, 0, 127, 201),
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/home'),
                  child: const Text(
                    'Try it out, continue as Guest!',
                   style: TextStyle(
                      color: Color.fromARGB(255, 0, 127, 201),
                      decoration: TextDecoration.underline,
                      decorationColor: Color.fromARGB(255, 0, 127, 201),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
