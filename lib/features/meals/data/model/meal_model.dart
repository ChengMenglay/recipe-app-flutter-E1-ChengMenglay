class Ingredient {
  final String ingredient;
  final String measure;

  Ingredient({required this.ingredient, required this.measure});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      ingredient: json['ingredient'] ?? '',
      measure: json['measure'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'ingredient': ingredient, 'measure': measure};
  }
}

class Meal {
  final String id;
  final String meal;
  final String category;
  final String area;
  final String instructions;
  final String mealThumb;
  final String tags;
  final String youtube;
  final String categoryId;
  final List<Ingredient> ingredients;

  Meal({
    required this.id,
    required this.meal,
    required this.category,
    required this.area,
    required this.instructions,
    required this.mealThumb,
    required this.tags,
    required this.youtube,
    required this.categoryId,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'] ?? '',
      meal: json['meal'] ?? '',
      category: json['category'] ?? '',
      area: json['area'] ?? '',
      instructions: json['instructions'] ?? '',
      mealThumb: json['mealThumb'] ?? '',
      tags: json['tags'] ?? '',
      youtube: json['youtube'] ?? '',
      categoryId: json['categoryId'] ?? '',
      ingredients: (json['ingredients'] as List<dynamic>? ?? [])
          .map((item) => Ingredient.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meal': meal,
      'category': category,
      'area': area,
      'instructions': instructions,
      'mealThumb': mealThumb,
      'tags': tags,
      'youtube': youtube,
      'categoryId': categoryId,
      'ingredients': ingredients.map((ing) => ing.toJson()).toList(),
    };
  }
}
