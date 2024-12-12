import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
      title: "Hello World",
      home: RecipeBook(),
    );
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recipe Book",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container( width: MediaQuery.of(context).size.width, height: 125,
        child: Card(
          child: Row(
            children: [
              Container(
                height: 125,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(

                  ),
                ),
              ),
              const SizedBox(width: 26),
              Column(children: [
                Text("Lasagna"),
                Text("Alison J"),
                Container(height: 2, width: 75, color: Colors.teal,)
              ],)
            ],
          ),
        ),
      )
    );
  }
}
