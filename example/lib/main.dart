import 'package:arc_floating_bottom_nav/arc_floating_bottom_nav.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floating Bottom Navigation Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E88FF)),
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  int _currentIndex = 0;

  late final List<FloatingBottomNavigationItem> _items =
      <FloatingBottomNavigationItem>[
        const FloatingBottomNavigationItem(
          label: 'Home',
          icon: Icons.home_outlined,
          activeIcon: Icons.home_outlined,
        ),
        const FloatingBottomNavigationItem(
          label: 'Car Life',
          icon: Icons.directions_car_outlined,
          activeIcon: Icons.directions_car_outlined,
        ),
        const FloatingBottomNavigationItem(
          label: 'AI Travel',
          isCenter: true,
          centerVariant: FloatingCenterButtonVariant.circleBackground,
          centerIcon: Icons.auto_awesome,
          activeCenterIcon: Icons.auto_awesome,
          centerIconSize: 28,
          activeColor: Color(0xFF1E88FF),
          inactiveColor: Color(0xFF223D72),
        ),
        const FloatingBottomNavigationItem(
          label: 'Explore',
          icon: Icons.explore_outlined,
          activeIcon: Icons.explore_outlined,
        ),
        const FloatingBottomNavigationItem(
          label: 'Profile',
          icon: Icons.person_outline_rounded,
          activeIcon: Icons.person_outline_rounded,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFFF7FAFF), Color(0xFFF0F5FB)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: IndexedStack(
            index: _currentIndex,
            children: _items
                .map(
                  (FloatingBottomNavigationItem item) => Center(
                    child: Text(
                      item.label,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1C315C),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
      bottomNavigationBar: FloatingBottomNavigationBar(
        items: _items,
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
        style: const FloatingBottomNavigationStyle(
          outerPadding: EdgeInsets.zero,
          barHeight: 132,
          compactBarHeight: 124,
          adaptBottomSafeArea: true,
          backgroundColor: Colors.white,
          barTop: 30,
          compactBarTop: 28,
          centerGap: 108,
          compactCenterGap: 96,
          centerTop: 42,
          centerSelectedSize: 54,
          centerUnselectedSize: 54,
          centerButtonPadding: EdgeInsets.all(12),
          centerButtonColor: Color(0xFFEDF6FF),
          centerShadowColor: Color(0x22000000),
          centerShadowBlur: 12,
          centerShadowOffset: Offset(0, 4),
          itemTopPadding: 40,
          itemSpacing: 6,
          selectedItemColor: Color(0xFF1E88FF),
          unselectedItemColor: Color(0xFF314A81),
          curve: FloatingBottomNavigationCurve(
            topY: 31,
            shoulderWidth: 15,
            crestWidth: 82,
            crestHeight: 24,
            slopeLift: 1,
            topCornerRadius: 0,
            bottomCornerRadius: 0,
          ),
        ),
      ),
    );
  }
}
