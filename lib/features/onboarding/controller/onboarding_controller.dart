import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final onboardingPageControllerProvider = Provider((ref) => PageController());

final onboardingIndexProvider = StateProvider<int>((ref) => 0);

class OnboardingController {
  OnboardingController(this.ref);

  final Ref ref;

  void nextPage() {
    final pageController = ref.read(onboardingPageControllerProvider);
    final currentIndex = ref.read(onboardingIndexProvider);
    if (currentIndex < 2) {
      pageController.nextPage(
        duration: Duration(microseconds: 300),
        curve: Curves.easeOut,
      );
    }

  }

  void previousPage() {
    final pageController = ref.read(onboardingPageControllerProvider);
    final currentIndex = ref.read(onboardingIndexProvider);
    if (currentIndex > 0) {
      pageController.previousPage(
        duration: Duration(microseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void updatePage(int index) {
    ref.read(onboardingIndexProvider.notifier).state = index;
  }
}

final onboardingControllerProvider = Provider(
  (ref) => OnboardingController(ref),
);
