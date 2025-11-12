import 'package:flutter/material.dart';
import 'widgets/app_container.dart';
import 'widgets/app_header.dart';
import '../theme/app_colors.dart';

class HeroTablePage extends StatefulWidget {
  final Map<String, dynamic> selectedHero;

  const HeroTablePage({super.key, required this.selectedHero});

  @override
  State<HeroTablePage> createState() => _HeroTablePageState();
}

class _HeroTablePageState extends State<HeroTablePage> {
  late List<Map<String, dynamic>> heroes;
  Map<String, dynamic>? _selectedHero;

  @override
  void initState() {
    super.initState();
    heroes = [widget.selectedHero];
  }

  void _openHeroDetail(Map<String, dynamic> hero) {
    setState(() => _selectedHero = hero);
  }

  void _closeDetail() {
    setState(() => _selectedHero = null);
  }

  void _updateStat(String key, int delta) {
    setState(() {
      final value = _selectedHero!['stats'][key];
      _selectedHero!['stats'][key] = (value + delta).clamp(0, 999);
    });
  }

  void _deleteHero(Map<String, dynamic> hero) {
    setState(() {
      heroes.remove(hero);
      _selectedHero = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/app_background.jpg', fit: BoxFit.cover),
          Container(color: const Color.fromARGB(255, 63, 61, 61).withValues(alpha: 0.7)),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeader(title: 'Your Heroes'),

              Expanded(
                child: AppContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          spacing: 16,
                          runSpacing: 16,
                          children: heroes.map((hero) {
                            final stats = hero['stats'];
                            return Container(
                              width: 150,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: appGradient,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black87,
                                    blurRadius: 8,
                                    offset: Offset(3, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      hero['image'],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    hero['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'STR: ${stats['Strength']}',
                                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                                  ),
                                  Text(
                                    'DEX: ${stats['Agility']}',
                                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                                  ),
                                  Text(
                                    'INT: ${stats['Intelligence']}',
                                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                                  ),
                                  const SizedBox(height: 12),

                                 GestureDetector(
                                    onTap: () => _openHeroDetail(hero),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 255, 215, 0),  
                                            Color.fromARGB(255, 255, 165, 0),  
                                            Color.fromARGB(255, 184, 134, 11), 
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.amberAccent,
                                            blurRadius: 10,
                                            spreadRadius: 0.5,
                                          ),
                                        ],
                                      ),
                                      child: const Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.auto_awesome, color: Colors.white, size: 14),
                                          SizedBox(height: 4),
                                          Text(
                                            'Upgrade\nYour Hero',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.5,
                                              height: 1.1,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(1, 1),
                                                  blurRadius: 4,
                                                  color: Colors.black54,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Overlay dettaglio eroe
          if (_selectedHero != null)
            Container(
              color: Colors.black.withValues(alpha: 0.85),
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 80),
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: appGradient,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.black54, blurRadius: 8, offset: Offset(2, 2)),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        _selectedHero!['image'],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _selectedHero!['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ..._selectedHero!['stats'].entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(entry.key,
                                style: const TextStyle(color: Colors.white, fontSize: 14)),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.sell, color: Colors.redAccent, size: 22),
                                  tooltip: 'Sell Token (-1)',
                                  onPressed: () => _updateStat(entry.key, -1),
                                ),
                                Text('${entry.value}',
                                    style: const TextStyle(color: Colors.white, fontSize: 14)),
                                IconButton(
                                  icon: const Icon(Icons.monetization_on,
                                      color: Colors.greenAccent, size: 22),
                                  tooltip: 'Buy Token (+1)',
                                  onPressed: () => _updateStat(entry.key, 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
                          ),
                          onPressed: () => _deleteHero(_selectedHero!),
                          child: const Text('Delete', style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white24,
                          ),
                          onPressed: _closeDetail,
                          child: const Text('Close', style: TextStyle(color: Colors.white)),
                        ),
                      ],
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
