import 'package:flutter/material.dart';
import 'widgets/app_container.dart';
import 'widgets/app_header.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final username = widget.username.isNotEmpty ? widget.username : 'Guest';

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Image.asset(
            'assets/images/app_background.jpg',
            fit: BoxFit.cover,
          ),
          Container(color: const Color.fromARGB(255, 63, 61, 61).withValues(alpha: 0.7)),

          // Main content
          const Column(
            children: [
              AppHeader(title: 'Hero’s Dawn'),
              Expanded(
                child: AppContainer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Welcome overlay
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Container(
                color: Colors.black.withValues(alpha: 0.9),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/welcome_loader.png',
                        width: 400,
                        fit: BoxFit.contain,
                      ),
                      Positioned(
                        bottom: 90, 
                        left: 125,
                        child: Text(
                          'Welcome\n$username',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 8,
                                color: Colors.black87,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
