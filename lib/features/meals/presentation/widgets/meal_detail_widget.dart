import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lab_3/features/meals/data/providers/meals_provider.dart';

class MealDetailWidget extends ConsumerWidget {
  const MealDetailWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealAsync = ref.watch(mealDetailsProvider);

    return ValueListenableBuilder(
      valueListenable: Hive.box('favorites').listenable(),
      builder: (context, box, child) {
        return mealAsync.when(
          data: (meal) {
            final isFavorite = box.get(meal.id) != null;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  meal.meal,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () async {
                      if (isFavorite) {
                        await box.delete(meal.id);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Removed from favorites'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      } else {
                        await box.put(meal.id, meal.toJson());
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added to favorites'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                  ),
                ],
              ),

              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---------- MEAL IMAGE ----------
                      Container(
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: FadeInImage(
                            placeholder: const AssetImage(
                              "assets/images/placeholder.png",
                            ),
                            image: NetworkImage(meal.mealThumb),
                            width: double.infinity,
                            height: 220,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            _tag(meal.category, Colors.orange.shade600),
                            const SizedBox(width: 8),
                            _tag(meal.area, Colors.green.shade600),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Text(
                          "Ingredients",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      ...meal.ingredients.map(
                        (ing) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                size: 20,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  ing.ingredient,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Text(
                          "Instructions",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          meal.instructions,
                          style: const TextStyle(fontSize: 16, height: 1.5),
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },

          loading: () => Scaffold(
            appBar: AppBar(title: const Text('Loading...'), centerTitle: true),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Loading meal details...',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          error: (err, _) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(child: Text("Error: $err")),
          ),
        );
      },
    );
  }

  Widget _tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
