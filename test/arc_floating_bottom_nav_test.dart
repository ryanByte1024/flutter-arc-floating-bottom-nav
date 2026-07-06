import 'package:arc_floating_bottom_nav/arc_floating_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders labels and reacts to taps', (WidgetTester tester) async {
    int currentIndex = 0;

    final List<FloatingBottomNavigationItem> items =
        <FloatingBottomNavigationItem>[
          const FloatingBottomNavigationItem(
            label: 'Home',
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
          ),
          const FloatingBottomNavigationItem(
            label: 'Trips',
            icon: Icons.directions_car_outlined,
            activeIcon: Icons.directions_car,
          ),
          const FloatingBottomNavigationItem(
            label: 'Assistant',
            isCenter: true,
            centerChild: ColoredBox(color: Colors.blue),
          ),
          const FloatingBottomNavigationItem(
            label: 'Explore',
            icon: Icons.explore_outlined,
            activeIcon: Icons.explore,
          ),
          const FloatingBottomNavigationItem(
            label: 'Profile',
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            filledSelection: true,
          ),
        ];

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: const SizedBox.shrink(),
              bottomNavigationBar: FloatingBottomNavigationBar(
                items: items,
                currentIndex: currentIndex,
                onTap: (int index) => setState(() => currentIndex = index),
              ),
            );
          },
        ),
      ),
    );

    expect(find.text('Assistant'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(currentIndex, 4);
  });

  testWidgets('supports icon-only center button variant', (
    WidgetTester tester,
  ) async {
    int currentIndex = 2;

    final List<FloatingBottomNavigationItem> items =
        <FloatingBottomNavigationItem>[
          const FloatingBottomNavigationItem(
            label: 'Home',
            icon: Icons.home_outlined,
          ),
          const FloatingBottomNavigationItem(
            label: 'Trips',
            icon: Icons.directions_car_outlined,
          ),
          const FloatingBottomNavigationItem(
            label: 'Publish',
            isCenter: true,
            centerVariant: FloatingCenterButtonVariant.iconOnly,
            centerIcon: Icons.add,
            activeCenterIcon: Icons.close,
          ),
          const FloatingBottomNavigationItem(
            label: 'Explore',
            icon: Icons.explore_outlined,
          ),
          const FloatingBottomNavigationItem(
            label: 'Profile',
            icon: Icons.person_outline,
          ),
        ];

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: const SizedBox.shrink(),
              bottomNavigationBar: FloatingBottomNavigationBar(
                items: items,
                currentIndex: currentIndex,
                onTap: (int index) => setState(() => currentIndex = index),
              ),
            );
          },
        ),
      ),
    );

    expect(find.byIcon(Icons.close), findsOneWidget);
    expect(find.byIcon(Icons.add), findsNothing);

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(currentIndex, 0);
  });
}
