import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: const RecipeCard(),
            ),
            const RecipeCard(),
            const RecipeCard()
          ],
        ),

      ),
    );
  }

}

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container( width: MediaQuery.of(context).size.width, height: 125,
      child: Card(
        child: Row(
          children: [
            Container(
              height: 125,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(10)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(

                ),
              ),
            ),
            const SizedBox(width: 26),
            Column(
              mainAxisAlignment: MainAxisAlignment.center, // vertical
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Lasagna", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                Container(height: 2, width: 75, color: Colors.teal,),
                const SizedBox(height: 4,),
                const Text("Alison J"),

            ],)
          ],
        ),
      ),
    );
  }
}