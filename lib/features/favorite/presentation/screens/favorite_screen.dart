import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lab_3/features/meals/data/model/meal_model.dart';
import 'package:lab_3/features/meals/data/providers/meals_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Favorites',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('favorites').listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      size: 80,
                      color: Colors.orange.shade300,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'No favorites yet',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Start adding meals to your favorites\nby tapping the heart icon',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          final favorites = box.values.toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red.shade400, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '${favorites.length} ${favorites.length == 1 ? 'Meal' : 'Meals'}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final mealData = favorites[index] as Map<dynamic, dynamic>;
                    final meal = Meal.fromJson(
                      Map<String, dynamic>.from(mealData),
                    );
                    return _FavoriteMealCard(meal: meal);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FavoriteMealCard extends ConsumerWidget {
  final Meal meal;

  const _FavoriteMealCard({required this.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      elevation: 3,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          ref.read(selectedMealIdProvider.notifier).state = meal.id;
          context.pushNamed('/meal-details');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with gradient overlay
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      meal.mealThumb,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => Container(
                        color: Colors.grey.shade300,
                        child: Icon(
                          Icons.broken_image,
                          size: 50,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                  // Gradient overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Favorite icon badge
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red.shade400,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Meal info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.meal,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.restaurant,
                          size: 14,
                          color: Colors.orange.shade600,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            meal.category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.green.shade600,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            meal.area,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
