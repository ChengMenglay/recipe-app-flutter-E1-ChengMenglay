import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:lab_3/features/meals/data/providers/meals_provider.dart';
import 'package:lab_3/features/meals/presentation/widgets/meal_card.dart';

class PopularMealsWidget extends ConsumerWidget {
  const PopularMealsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealsAsync = ref.watch(popularMealsProvider);

    return mealsAsync.when(
      data: (meals) {
        return SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: meals.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: MealCard(meal: meals[index]),
              );
            },
          ),
        );
      },
      loading: () => SizedBox(
        height: 260,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Shimmer(
                duration: const Duration(seconds: 2),
                interval: const Duration(seconds: 1),
                color: Colors.grey.shade300,
                colorOpacity: 0.5,
                enabled: true,
                direction: const ShimmerDirection.fromLTRB(),
                child: Container(
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      error: (err, _) =>
          SizedBox(height: 260, child: Center(child: Text("Error: $err"))),
    );
  }
}
