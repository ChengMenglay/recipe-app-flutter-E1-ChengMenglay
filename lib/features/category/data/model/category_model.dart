class Category {
  final String id;
  final String category;
  final String categoryThumb;
  final String categoryDescription;

  Category({
    required this.id,
    required this.category,
    required this.categoryThumb,
    required this.categoryDescription,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      category: json['category'] ?? '',
      categoryThumb: json['categoryThumb'] ?? '',
      categoryDescription: json['categoryDescription'] ?? '',
    );
  }
}
