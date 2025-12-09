import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lab_3/features/meals/data/model/meal_model.dart';
import 'package:lab_3/features/meals/data/providers/meals_provider.dart';

class MealCard extends ConsumerWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Material(
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
