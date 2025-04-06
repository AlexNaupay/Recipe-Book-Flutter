import 'package:flutter/material.dart';
import 'package:recipe_book_flutter/screens/recipe_detail.dart';

import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipeDetail(
                  recipeName: recipe.name,
                )));
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 125,
        child: Card(
          child: Row(
            children: [
              Container(
                height: 125,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  // child: Image.asset("assets/images/pizza_lasagna.webp", fit: BoxFit.cover),
                  child: Image.network(
                    recipe.imageLink,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // return const Icon(Icons.error);
                      return Image.asset("assets/images/pizza_lasagna.webp", fit: BoxFit.cover);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 26),
              Column(
                mainAxisAlignment: MainAxisAlignment.center, // vertical
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 2,
                    width: 75,
                    color: Colors.teal,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(recipe.author),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}