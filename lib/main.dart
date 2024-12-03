import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Hello World",
      home: RecipeBook(),
    );
  }
}

class RecipeBook extends StatelessWidget{
  const RecipeBook({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Title of Screen")),
      body: const Text("Hello World content!"),
    );
  }
}