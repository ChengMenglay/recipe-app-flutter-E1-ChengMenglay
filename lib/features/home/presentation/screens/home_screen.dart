import 'package:flutter/material.dart';
import 'package:lab_3/features/home/presentation/widgets/area_card_widget.dart';
import 'package:lab_3/features/home/presentation/widgets/category_card_widget.dart';
import 'package:lab_3/features/home/presentation/widgets/popular_meals_widget.dart';
import 'package:lab_3/features/home/presentation/widgets/meal_suggestion_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const horizontal = EdgeInsets.symmetric(horizontal: 16);
    const sectionSpacing = SizedBox(height: 16);

    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: horizontal,
                child: Row(
                  children: [
                    const Icon(Icons.qr_code, size: 28),

                    const SizedBox(width: 14),

                    // Search bar
                    Expanded(
                      child: Container(
                        height: 42,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "Search meals...",
                            border: InputBorder.none,
                            icon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),
                    const Icon(Icons.notifications_none, size: 28),
                  ],
                ),
              ),

              sectionSpacing,

              const Padding(
                padding: horizontal,
                child: Text(
                  "Today's Suggestion",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),

              const SizedBox(height: 12),
              const Padding(padding: horizontal, child: MealSuggestionWidget()),

              sectionSpacing,

              const Padding(
                padding: horizontal,
                child: Text(
                  "Popular Meals",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),

              const SizedBox(height: 12),
              const PopularMealsWidget(),

              const Padding(
                padding: horizontal,
                child: Text(
                  "Category",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 12),
              
              Padding(padding: horizontal, child: CategoryCardWidget()),
              const Padding(
                padding: horizontal,
                child: Text(
                  "Area",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),

              const SizedBox(height: 12),
              const Padding(padding: horizontal, child: AreaCardWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
