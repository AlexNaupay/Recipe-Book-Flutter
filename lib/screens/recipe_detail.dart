import 'package:flutter/material.dart';

class RecipeDetail extends StatelessWidget {
  final String recipeName;

  const RecipeDetail({super.key, required this.recipeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white,)
        ),
      ),
      body: Text('Recipe: $recipeName'),
    );
  }


}