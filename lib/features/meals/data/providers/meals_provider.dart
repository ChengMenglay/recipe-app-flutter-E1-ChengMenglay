import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:lab_3/features/meals/service/api_service.dart';
import 'package:lab_3/features/meals/data/model/meal_model.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final mealsProvider = FutureProvider<List<Meal>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  return await api.fetchMeals();
});

final popularMealsProvider = FutureProvider<List<Meal>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  final meals = await api.fetchMeals();

  return meals.take(5).toList();
});

final selectedMealIdProvider = StateProvider<String>((ref) => "");
final selectedCategoryProvider = StateProvider<String>((ref) => "All");

// Pagination and sorting providers
final currentPageProvider = StateProvider<int>((ref) => 1);
final itemsPerPageProvider = StateProvider<int>((ref) => 10);
final sortFieldProvider = StateProvider<String?>((ref) => null);
final sortOrderProvider = StateProvider<String>(
  (ref) => 'asc',
); // 'asc' or 'desc'

// Paginated meals provider
final paginatedMealsProvider = FutureProvider<List<Meal>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  final page = ref.watch(currentPageProvider);
  final limit = ref.watch(itemsPerPageProvider);
  final sortField = ref.watch(sortFieldProvider);
  final sortOrder = ref.watch(sortOrderProvider);
  final category = ref.watch(selectedCategoryProvider);

  return await api.fetchMealsPaginated(
    page: page,
    limit: limit,
    sortBy: sortField,
    order: sortOrder,
    category: category,
  );
});
final mealDetailsProvider = FutureProvider<Meal>((ref) async {
  final api = ref.watch(apiServiceProvider);
  final String mealId = ref.watch(selectedMealIdProvider);
  return await api.fetchMealById(mealId);
});

final mealRandomProvider = FutureProvider<Meal>((ref) async {
  final api = ref.watch(apiServiceProvider);
  final meals = await api.fetchMeals();

  meals.shuffle();
  return meals.first;
});

final areaProvider = FutureProvider<List<String>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  final meals = await api.fetchMeals();

  final areas =
      meals
          .map((meal) => meal.area)
          .where((area) => area.isNotEmpty)
          .toSet()
          .toList()
        ..sort();
  return areas;
});

final filteredMealsProvider = FutureProvider<List<Meal>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  final String category = ref.watch(selectedCategoryProvider);
  if (category == "All") {
    final meals = await api.fetchMeals();
    return meals;
  } else {
    final meals = await api.fetchMealsByCategory(category);
    return meals;
  }
});
