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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
          child: const Icon(Icons.add, color: Colors.white,),
          onPressed: (){
            _showBottomSheet(context);
          }
      ),
    );
  }

}

Future<void> _showBottomSheet(BuildContext context){
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.opaque,  // This ensures that the entire area of the GestureDetector receives tap events
        onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard when tapping outside
        child: Padding(  // Adds padding at the bottom equal to the keyboard height
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,  // gets the current keyboard height
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 350,
            width: MediaQuery.of(context).size.width,
            child: const RecipeForm(),
          ),
        ),
      ),
  );
}

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        //key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Add a New Recipe", style: TextStyle(color: Colors.teal, fontSize: 24)),
                const SizedBox(height: 10),
                _buildTextField(label: "Recipe Name"),
                const SizedBox(height: 10),
                _buildTextField(label: "Author"),
                const SizedBox(height: 10),
                _buildTextField(label: "Image URL"),
                const SizedBox(height: 10),
                _buildTextField(label: "Ingredients"),
                const SizedBox(height: 10),
                _buildTextField(label: "Instructions"),
              ],
            ),
          )
      ),
    );
  }

  Widget _buildTextField({required String label}){
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontFamily: 'Quicksand', color: Colors.teal),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:const BorderSide(color: Colors.teal, width: 1)
        ),
      ),
      focusNode: FocusNode(),
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
                child: Image.asset("assets/images/pizza_lasagna.webp", fit: BoxFit.cover),
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