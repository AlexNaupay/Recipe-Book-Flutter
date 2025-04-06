import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/recipe.dart';

class RecipesProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Recipe> recipes = [];

  Future<List<Recipe>> getRecipes() async {
    isLoading = true;
    notifyListeners();

    try{
      // localhost
      // Android: 10.0.2.2
      // iOS: 127.0.0.1
      final url = Uri.parse(
          'https://raw.githubusercontent.com/AlexNaupay/Recipe-Book-Flutter/refs/heads/master/recipes.json');
      final response = await http.get(url);
      if(response.statusCode != 200){
        print('Error http response: ${response.statusCode}');
        return [];
      }
      final jsonData = json.decode(response.body);
      final recipesList = jsonData['recipes'] as List;
      recipes = recipesList.map((recipe) => Recipe.fromJson(recipe)).toList();
      return recipes;
    }catch(e){
      print('Error getting recipes: $e');
      return [];
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

}