import 'dart:math';
import 'package:flutter/material.dart';
import 'widgets/app_container.dart';
import 'widgets/app_header.dart';
import '../theme/app_colors.dart';
import 'hero_table.dart';

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
  bool _showHeroOverlay = false;
  bool _showWelcomeOverlay = true;
  final Random _rand = Random();

  final List<String> allHeroImages = [
    'assets/images/heroes/archer.jpeg',
    'assets/images/heroes/bard.jpeg',
    'assets/images/heroes/dwarf.jpeg',
    'assets/images/heroes/mage.jpeg',
    'assets/images/heroes/paladin_hero.jpeg',
    'assets/images/heroes/paladin.jpeg',
    'assets/images/heroes/samurai_warrior.jpeg',
    'assets/images/heroes/thief.webp',
  ];

  List<Map<String, dynamic>> _heroes = [];

  List<Map<String, dynamic>> generateRandomHeroes() {
    final chosen = <String>{};
    while (chosen.length < 3) {
      chosen.add(allHeroImages[_rand.nextInt(allHeroImages.length)]);
    }

    return chosen.map((path) {
      final name = path.split('/').last.split('.').first;
      return {
        'name': name[0].toUpperCase() + name.substring(1),
        'image': path,
        'stats': {
          'Strength': 50 + _rand.nextInt(51),
          'Agility': 50 + _rand.nextInt(51),
          'Intelligence': 50 + _rand.nextInt(51),
        },
      };
    }).toList();
  }

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
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _controller.reverse();
        setState(() => _showWelcomeOverlay = false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onStartPressed() {
    final username = widget.username.toLowerCase();

    if (username == 'guest') {
      setState(() {
        _heroes = generateRandomHeroes();
        _showHeroOverlay = true;
      });
    } else {
      // TODO: logica per utenti registrati
    }
  }

  void _selectHero(Map<String, dynamic> hero) {
    setState(() => _showHeroOverlay = false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HeroTablePage(selectedHero: hero),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final username = widget.username.isNotEmpty ? widget.username : 'Guest';

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/app_background.jpg', fit: BoxFit.cover),
          Container(color: const Color.fromARGB(255, 63, 61, 61).withValues(alpha: 0.7)),

          Column(
            children: [
              const AppHeader(title: 'Hero’s Dawn'),
              Expanded(
                child: AppContainer(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: appGradient,
                        borderRadius: BorderRadius.circular(10),
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
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                        ),
                        onPressed: _onStartPressed,
                        child: const Text(
                          'Start',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Welcome overlay
          if (_showWelcomeOverlay)
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

          // Guest hero selection overlay
          if (_showHeroOverlay)
            Container(
              color: Colors.black.withValues(alpha: 0.85),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Choose your Hero',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _heroes.map((hero) {
                        return GestureDetector(
                          onTap: () => _selectHero(hero),
                          child: Container(
                            width: 110,
                            height: 170,
                            decoration: BoxDecoration(
                              gradient: appGradient,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 6,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(hero['image'], width: 65, height: 65, fit: BoxFit.cover),
                                const SizedBox(height: 8),
                                Text(
                                  hero['name'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                ...hero['stats'].entries.map((entry) => Text(
                                      '${entry.key}: ${entry.value}',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () => setState(() => _showHeroOverlay = false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white12,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      ),
                      child: const Text('Close', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
