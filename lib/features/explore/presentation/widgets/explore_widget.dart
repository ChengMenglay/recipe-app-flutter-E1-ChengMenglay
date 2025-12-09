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
    final mealsAsync = ref.watch(paginatedMealsProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final currentPage = ref.watch(currentPageProvider);
    final sortField = ref.watch(sortFieldProvider);
    final sortOrder = ref.watch(sortOrderProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Explore",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                      ref.read(selectedCategoryProvider.notifier).state =
                          category;
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.orange
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.orange.withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Meals",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
                ),
              ),
              // Sort dropdown
              PopupMenuButton<String>(
                icon: Row(
                  children: [
                    Icon(Icons.sort, size: 20, color: Colors.grey.shade700),
                    const SizedBox(width: 4),
                    Icon(
                      sortOrder == 'asc'
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 16,
                      color: Colors.grey.shade700,
                    ),
                  ],
                ),
                tooltip: 'Sort by',
                onSelected: (value) {
                  if (value == 'none') {
                    ref.read(sortFieldProvider.notifier).state = null;
                  } else if (value == 'toggle_order') {
                    ref.read(sortOrderProvider.notifier).state =
                        sortOrder == 'asc' ? 'desc' : 'asc';
                  } else {
                    ref.read(sortFieldProvider.notifier).state = value;
                    ref.read(currentPageProvider.notifier).state = 1;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'none',
                    child: Row(
                      children: [
                        Icon(
                          Icons.clear,
                          size: 18,
                          color: sortField == null
                              ? Colors.orange
                              : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        const Text('No sorting'),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'meal',
                    child: Row(
                      children: [
                        Icon(
                          Icons.restaurant_menu,
                          size: 18,
                          color: sortField == 'meal'
                              ? Colors.orange
                              : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        const Text('Name'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'category',
                    child: Row(
                      children: [
                        Icon(
                          Icons.category,
                          size: 18,
                          color: sortField == 'category'
                              ? Colors.orange
                              : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        const Text('Category'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'area',
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 18,
                          color: sortField == 'area'
                              ? Colors.orange
                              : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        const Text('Area'),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'toggle_order',
                    child: Row(
                      children: [
                        Icon(
                          sortOrder == 'asc'
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          size: 18,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        Text(sortOrder == 'asc' ? 'Descending' : 'Ascending'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        Expanded(
          child: mealsAsync.when(
            data: (meals) {
              if (meals.isEmpty) {
                return const Center(child: Text("No meals found."));
              }

              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                    ),
                  ),
                  // Pagination controls
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Previous page button
                        IconButton(
                          onPressed: currentPage > 1
                              ? () {
                                  ref
                                      .read(currentPageProvider.notifier)
                                      .state--;
                                }
                              : null,
                          icon: const Icon(Icons.chevron_left),
                          style: IconButton.styleFrom(
                            backgroundColor: currentPage > 1
                                ? Colors.orange.shade100
                                : Colors.grey.shade200,
                            foregroundColor: currentPage > 1
                                ? Colors.orange.shade700
                                : Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Page indicator
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.orange.shade200,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'Page $currentPage',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Next page button
                        IconButton(
                          onPressed: meals.length >= 10
                              ? () {
                                  ref
                                      .read(currentPageProvider.notifier)
                                      .state++;
                                }
                              : null,
                          icon: const Icon(Icons.chevron_right),
                          style: IconButton.styleFrom(
                            backgroundColor: meals.length >= 10
                                ? Colors.orange.shade100
                                : Colors.grey.shade200,
                            foregroundColor: meals.length >= 10
                                ? Colors.orange.shade700
                                : Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
