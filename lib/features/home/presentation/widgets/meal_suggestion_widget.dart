import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:lab_3/features/meals/data/providers/meals_provider.dart';

class MealSuggestionWidget extends ConsumerWidget {
  const MealSuggestionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealAsync = ref.watch(mealRandomProvider);

    return mealAsync.when(
      data: (item) {
        return SizedBox(
          height: 210,
          child: Card(
            elevation: 5,
            shadowColor: Colors.black.withOpacity(0.15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                ref.read(selectedMealIdProvider.notifier).state = item.id;
                context.pushNamed('/meal-details');
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.network(
                          item.mealThumb,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stack) => Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                            alignment: Alignment.center,
                            child: const Icon(Icons.broken_image, size: 40),
                          ),
                        ),
                      ),

                      // Gradient
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.6),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),

                      // Suggested label + meal name
                      Positioned(
                        bottom: 10,
                        left: 12,
                        right: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade600,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                "Suggested Meal",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item.meal,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },

      loading: () => SizedBox(
        height: 210,
        child: Card(
          elevation: 5,
          shadowColor: Colors.black.withOpacity(0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Shimmer(
            duration: const Duration(seconds: 2),
            interval: const Duration(seconds: 1),
            color: Colors.grey.shade300,
            colorOpacity: 0.5,
            enabled: true,
            direction: const ShimmerDirection.fromLTRB(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ),
      error: (error, stack) => SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'Error loading suggestion',
            style: TextStyle(color: Colors.red.shade400),
          ),
        ),
      ),
    );
  }
}
