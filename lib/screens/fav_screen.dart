import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_flutter/screens/recipe_card.dart';

import '../providers/recipe_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Consumer<RecipesProvider>(
          builder: (BuildContext context, provider, Widget? child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.favoriteRecipe.isEmpty) {
              return const Center(child: Text('There are no favorites yet'));
            } else {
              return ListView.builder(
                itemCount: provider.favoriteRecipe.length,
                itemBuilder: (context, index) {
                  return RecipeCard(recipe: provider.favoriteRecipe[index]);
                },
              );
            }
          })
    );

  }

}