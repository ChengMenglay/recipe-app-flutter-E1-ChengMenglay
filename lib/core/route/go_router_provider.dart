import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lab_3/core/route/route_name.dart';
import 'package:lab_3/features/explore/presentation/screens/explore_screen.dart';
import 'package:lab_3/features/favorite/presentation/screens/favorite_screen.dart';
import 'package:lab_3/features/home/presentation/screens/home_screen.dart';
import 'package:lab_3/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:lab_3/features/meals/presentation/screens/meal_detail.dart';
import 'package:lab_3/root/Root_bottomNavigation_screen.dart';
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: onboardingRoute,
    routes: [
      // Onboarding is separate (no bottom bar)
      GoRoute(
        path: '/onboarding',
        name: onboardingRoute,
        builder: (context, state) => const OnBoardingScreen(),
      ),

      // Bottom navigation routes
      ShellRoute(
        builder: (context, state, child) =>
            RootBottomNavigationScreen(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: homeRoute,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/explore',
            name: exploreRoute,
            builder: (context, state) => const ExploreScreen(),
          ),
          GoRoute(
            path: '/favorite',
            name: favoriteRoute,
            builder: (context, state) => const FavoriteScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/meal-details',
        name: mealDetailRoute,
        builder: (context, state) => const MealDetailScreen(),
      )
    ],
  );
});
