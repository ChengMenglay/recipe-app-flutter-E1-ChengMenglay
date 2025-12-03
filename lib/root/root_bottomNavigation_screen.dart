import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RootBottomNavigationScreen extends ConsumerWidget {
  final Widget child;

  const RootBottomNavigationScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();

    // Detect active tab from current route
    int currentIndex = 0;
    if (location.startsWith('/home')) currentIndex = 0;
    if (location.startsWith('/explore')) currentIndex = 1;
    if (location.startsWith('/favorite')) currentIndex = 2;

    void onTap(int index) {
      if (index == 0) context.go('/home');
      if (index == 1) context.go('/explore');
      if (index == 2) context.go('/favorite');
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        indicatorColor: Colors.blue,
        onDestinationSelected: onTap,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            selectedIcon: Icon(Icons.home, color: Colors.white),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.search, color: Colors.white),
            label: "Explore",
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            selectedIcon: Icon(Icons.favorite, color: Colors.white),
            label: "Favorite",
          ),
        ],
      ),
    );
  }
}
