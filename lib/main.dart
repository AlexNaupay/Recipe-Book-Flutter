import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_flutter/providers/recipe_provider.dart';
import 'package:recipe_book_flutter/screens/fav_screen.dart';
import 'package:recipe_book_flutter/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecipesProvider()),  // Singleton like
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // debugShowMaterialGrid: true,
        title: "Hello World",
        home: RecipeBook(),
      )
    );
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Recipe Book",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.teal,
            bottom: const TabBar(
                indicatorColor: Colors.teal,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white54,
                tabs: [
                  Tab(icon: Icon(Icons.home), text: 'Home'),
                  Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
                ]),
          ),
          body: const TabBarView(children: [HomeScreen(), FavoriteScreen()]),
        ));
  }
}
