import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lab_3/features/onboarding/data/model/onboarding_item.dart';
import '../../controller/onboarding_controller.dart';
import '../widgets/onboarding_content.dart';

class OnBoardingScreen extends ConsumerWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(onboardingControllerProvider);
    final pageController = ref.read(onboardingPageControllerProvider);
    final currentIndex = ref.watch(onboardingIndexProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: onboardingItems.length,
                onPageChanged: controller.updatePage,
                itemBuilder: (context, index) {
                  final item = onboardingItems[index];
                  return OnboardingContent(
                    image: item.image,
                    title: item.title,
                    description: item.description,
                  );
                },
              ),
            ),
            // ===== Bottom Controls =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ===== Previous Button =====
                  IconButton(
                    onPressed: controller.previousPage,
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 30,
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(14),
                      backgroundColor: Colors.grey.shade200,
                      shape: const CircleBorder(),
                    ),
                  ),

                  // ===== Dot Indicator =====
                  Row(
                    children: List.generate(
                      onboardingItems.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        height: 8,
                        width: currentIndex == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? Colors.blue
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  // ===== Next or Get Started Button =====
                  currentIndex == onboardingItems.length - 1
                      ? ElevatedButton(
                          onPressed: () => context.go('/home'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            "Get Started",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : IconButton(
                          onPressed: controller.nextPage,
                          icon: const Icon(Icons.arrow_forward),
                          iconSize: 30,
                          style: IconButton.styleFrom(
                            padding: const EdgeInsets.all(14),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: const CircleBorder(),
                          ),
                        ),
                ],
              ),
            ),

            const SizedBox(height: 20, width: 20),
          ],
        ),
      ),
    );
  }
}
