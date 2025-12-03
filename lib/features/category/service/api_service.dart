import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_3/features/category/data/model/category_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {
  static const String baseUrl = 'https://meal-db-sandy.vercel.app';
  static const String dbName = 'de202e5b-c726-49bd-b627-f3906bf81048';

  Future<List<Category>> fetchCategories() async {
    final url = Uri.parse("$baseUrl/categories");

    final response = await http.get(url, headers: {'X-DB-Name': dbName});

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      return jsonList.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
