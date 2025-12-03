import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:lab_3/features/meals/data/providers/meals_provider.dart';

class AreaCardWidget extends ConsumerWidget {
  const AreaCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final areas = ref.watch(areaProvider);

    return areas.when(
      data: (areaList) {
        if (areaList.isEmpty) {
          return const Text("No areas available");
        }

        return SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: areaList.length,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final area = areaList[index];
              return Chip(
                label: Text(area),
                backgroundColor: Colors.orange.shade600,
                labelStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 2,
                ),
              );
            },
          ),
        );
      },

      loading: () => SizedBox(
        height: 44,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Shimmer(
                duration: const Duration(seconds: 2),
                interval: const Duration(seconds: 1),
                color: Colors.grey.shade300,
                colorOpacity: 0.5,
                enabled: true,
                direction: const ShimmerDirection.fromLTRB(),
                child: Container(
                  width: 80,
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

      error: (err, _) => Padding(
        padding: const EdgeInsets.all(12),
        child: Text("Error: $err", style: const TextStyle(color: Colors.red)),
      ),
    );
  }
}
