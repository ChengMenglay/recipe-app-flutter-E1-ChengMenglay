import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lab_3/features/meals/data/providers/meals_provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:lab_3/features/category/data/provider/category_provider.dart';

class CategoryCardWidget extends ConsumerWidget {
  const CategoryCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider);

    return categories.when(
      data: (categories) {
        return SizedBox(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final cat = categories[index];

              return SizedBox(
                width: 100,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        ref.read(selectedCategoryProvider.notifier).state =
                            cat.category;
                        context.pushNamed('/explore');
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: 1, // makes it a square card
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/placeholder.png',
                          image: cat.categoryThumb,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      cat.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      loading: () => SizedBox(
        height: 130,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Shimmer(
                duration: const Duration(seconds: 2),
                interval: const Duration(seconds: 1),
                color: Colors.grey.shade300,
                colorOpacity: 0.5,
                enabled: true,
                direction: const ShimmerDirection.fromLTRB(),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      error: (err, stack) => Center(child: Text("Error: $err")),
    );
  }
}
