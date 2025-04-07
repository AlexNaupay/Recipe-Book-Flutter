import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_flutter/screens/recipe_card.dart';
import '../providers/recipe_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    // Do something after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RecipesProvider>(context, listen: false).getRecipes();
    });

    /*
    // Do something after the widget is built
    Future.microtask(() {
      if (!mounted) return;  // Check if the widget is still mounted
      Provider.of<RecipesProvider>(context, listen: false).getRecipes();  // Call the getRecipes method
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: FutureBuilder(
          future: getRecipes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('There is no recipes yet'));
            }

            final recipes = snapshot.data as List;
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return RecipeCard(recipe: recipes[index]);
              },
            );
          }),*/
      body: Consumer<RecipesProvider>(
          builder: (BuildContext context, provider, Widget? child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.recipes.isEmpty) {
              return const Center(child: Text('There are no recipes yet'));
            } else {
              return ListView.builder(
                itemCount: provider.recipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(recipe: provider.recipes[index]);
                },
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            _showBottomSheet(context);
          }),
    );
  }

}

Future<void> _showBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      // This ensures that the entire area of the GestureDetector receives tap events
      onTap: () => FocusScope.of(context).unfocus(),
      // Dismiss keyboard when tapping outside
      child: Padding(
        // Adds padding at the bottom equal to the keyboard height
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context)
              .viewInsets
              .bottom, // gets the current keyboard height
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
                const Text("Add a New Recipe",
                    style: TextStyle(color: Colors.teal, fontSize: 24)),
                const SizedBox(height: 10),
                _buildTextField(
                    label: "Recipe Name",
                    controller: nameController,
                    validator: checkFieldEmpty),
                const SizedBox(height: 10),
                _buildTextField(
                    label: "Author",
                    controller: authorController,
                    validator: (value) {
                      return emptyValidator(value, "Author es obligatorio");
                    }),
                const SizedBox(height: 10),
                _buildTextField(
                    label: "Image URL",
                    controller: urlController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    }),
                const SizedBox(height: 10),
                _buildTextField(
                    label: "Ingredients",
                    controller: ingredientsController,
                    validator: checkFieldEmpty,
                    maxLines: 3),
                const SizedBox(height: 10),
                _buildTextField(
                    label: "Instructions",
                    controller: instructionsController,
                    validator: checkFieldEmpty,
                    maxLines: 3),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 46, right: 46),
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text("Save Recipe",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                )
              ],
            ),
          )),
    );
  }

  String? emptyValidator(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  String? checkFieldEmpty(String? value) {
    //<-- add String? as a return type
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }

  Widget _buildTextField(
      {required String label,
      required TextEditingController controller,
      required String? Function(String?) validator,
      int maxLines = 1}) {
    return TextFormField(
      //autovalidateMode: AutovalidateMode.always,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            const TextStyle(fontFamily: 'Quicksand', color: Colors.teal),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.teal, width: 1)),
      ),
      controller: controller,
      validator: validator,
      focusNode: FocusNode(),
      maxLines: maxLines,
    );
  }
}

