import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/recipe.dart';
import '../providers/recipe_provider.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetail({super.key, required this.recipe});

  @override
  State<StatefulWidget> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = Provider.of<RecipesProvider>(context, listen: false)
        .favoriteRecipe.contains(widget.recipe);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Recipe recipe = widget.recipe;  // Access the recipe from the widget; RecipeDetail is the widget
    return Scaffold(
      appBar: AppBar(
          title: Text(recipe.name, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.teal,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          actions: [
            IconButton(
                onPressed: () async {
                  await Provider.of<RecipesProvider>(context, listen: false)
                      .toggleFavoriteStatus(recipe);
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                icon: ScaleTransition(
                    scale: scaleAnimation,
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                    )))
          ]),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(recipe.imageLink),
              SizedBox(
                height: 8,
              ),
              Text(
                recipe.name,
                style: TextStyle(
                  color: Colors.teal,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(recipe.author,
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  )),
              SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recipes steps:',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 12),
                  for (var step in recipe.instructions)
                    Row(children: [Icon(Icons.check, size: 16), SizedBox(width: 8), Flexible(child: Text(step))]),
                ],
              ),
              SizedBox(height: 36,)
            ],
          ),
        ),
      ),
    );
  }
}
