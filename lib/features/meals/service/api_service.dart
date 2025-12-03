import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lab_3/features/meals/data/model/meal_model.dart';

class ApiService {
  static const String baseUrl = 'https://meal-db-sandy.vercel.app';
  static const String dbName = 'de202e5b-c726-49bd-b627-f3906bf81048';

  Future<List<Meal>> fetchMeals() async {
    final url = Uri.parse("$baseUrl/meals");

    final response = await http.get(url, headers: {'X-DB-Name': dbName});

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Meal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }

  Future<Meal> fetchMealById(String id) async {
    final url = Uri.parse("$baseUrl/meals/$id");

    final response = await http.get(url, headers: {'X-DB-Name': dbName});

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      return Meal.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load meal');
    }
  }

  Future<List<Meal>> fetchMealsByCategory(String category) async {
    final url = Uri.parse("$baseUrl/meals?category=$category");

    final response = await http.get(url, headers: {'X-DB-Name': dbName});
    if(response.statusCode == 200){
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json)=>Meal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load meals by category');
    }
  }
}
