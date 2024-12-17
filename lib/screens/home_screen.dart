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
    final formKey = GlobalKey<FormState>();

    TextEditingController nameController = TextEditingController();
    TextEditingController authorController = TextEditingController();
    TextEditingController urlController = TextEditingController();
    TextEditingController ingredientsController = TextEditingController();
    TextEditingController instructionsController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Add a New Recipe", style: TextStyle(color: Colors.teal, fontSize: 24)),
                const SizedBox(height: 10),
                _buildTextField(label: "Recipe Name", controller: nameController, validator: checkFieldEmpty),

                const SizedBox(height: 10),
                _buildTextField(
                    label: "Author",
                    controller: authorController,
                    validator: (value){ return emptyValidator(value, "Author es obligatorio"); }),

                const SizedBox(height: 10),
                _buildTextField(label: "Image URL", controller: urlController, validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),

                const SizedBox(height: 10),
                _buildTextField(label: "Ingredients", controller: ingredientsController, validator: checkFieldEmpty, maxLines: 3),

                const SizedBox(height: 10),
                _buildTextField(label: "Instructions", controller: instructionsController, validator: checkFieldEmpty, maxLines: 3),

                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          Navigator.pop(context);
                        }
                      },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 46, right: 46),
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    child: const Text("Save Recipe", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                )

              ],
            ),
          )
      ),
    );
  }

  String? emptyValidator(String? value, String message){
      if (value == null || value.isEmpty){
        return message;
      }
      return null;
  }

  String? checkFieldEmpty(String? value) { //<-- add String? as a return type
    if(value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }


  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int maxLines = 1
  }){
    return TextFormField(
      //autovalidateMode: AutovalidateMode.always,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontFamily: 'Quicksand', color: Colors.teal),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:const BorderSide(color: Colors.teal, width: 1)
        ),
      ),
      controller: controller,
      validator: validator,
      focusNode: FocusNode(),
      maxLines: maxLines,
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