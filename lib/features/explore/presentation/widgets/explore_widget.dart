import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_3/features/category/data/provider/category_provider.dart';
import 'package:lab_3/features/meals/data/providers/meals_provider.dart';
import 'package:lab_3/features/meals/presentation/widgets/meal_card.dart';

class ExploreWidget extends ConsumerWidget {
  const ExploreWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoryProvider);
    final mealsAsync = ref.watch(filteredMealsProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Explore",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15),
        categoriesAsync.when(
          data: (categories) {
            final fullList = ["All", ...categories.map((e) => e.category)];

            return SizedBox(
              height: 45,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                itemCount: fullList.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, index) {
                  final category = fullList[index];
                  final isSelected = category == selectedCategory;

                  return GestureDetector(
                    onTap: () {
                      ref.read(selectedCategoryProvider.notifier).state = category;
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.orange : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.orange.withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                )
                              ]
                            : null,
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Padding(
            padding: EdgeInsets.all(12),
            child: CircularProgressIndicator(),
          ),
          error: (_, __) => const Text("Failed to load categories"),
        ),

        const SizedBox(height: 20),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Meals",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
        ),

        const SizedBox(height: 10),

        Expanded(
          child: mealsAsync.when(
            data: (meals) {
              if (meals.isEmpty) {
                return const Center(child: Text("No meals found."));
              }

              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.75,
                ),
                itemCount: meals.length,
                itemBuilder: (_, index) {
                  final meal = meals[index];
                  return MealCard(meal: meal);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Center(child: Text("Failed to load meals")),
          ),
        ),
      ],
    );
  }
}