import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_3/features/category/data/model/category_model.dart';
import 'package:lab_3/features/category/service/api_service.dart';

final categoryProvider = FutureProvider<List<Category>>((ref) async {
  final api = ref.watch(apiServiceProvider);

  final categories = await api.fetchCategories();

  return categories.map((cateogory) => cateogory).toSet().toList()
    ..sort((a, b) => a.category.compareTo(b.category));
});
