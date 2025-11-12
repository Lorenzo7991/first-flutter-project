import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class AppHeader extends StatelessWidget {
  final String title;

  const AppHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      padding: const EdgeInsets.only(top: 40, right: 16, left: 16),
      decoration: const BoxDecoration(
        gradient: appGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0, 3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 48),

          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 176, 196, 222),
                        Color.fromARGB(255, 255, 255, 255),
                        Color.fromARGB(255, 188, 187, 187),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(const Rect.fromLTWH(0, 0, 250, 80)),
                  shadows: const [
                    Shadow(
                      offset: Offset(0, 0),
                      blurRadius: 20, 
                      color: Colors.white54, 
                    ),
                    Shadow(
                      offset: Offset(3, 3),
                      blurRadius: 14, 
                      color: Colors.black87, 
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          IconButton(
            iconSize: 22, 
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Confirm Logout'),
                  content: const Text(
                    'Are you sure you want to disconnect?\nYou will be redirected to the login page.',
                  ),
                  actionsPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  ],
                ),
              );

              if (shouldLogout == true && context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
