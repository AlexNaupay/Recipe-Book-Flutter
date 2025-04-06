class Recipe {
  int id;
  final String name;
  final String author;
  final String imageLink;
  final List<String> instructions;

  Recipe({
    this.id = 0,
    required this.name,
    required this.author,
    required this.imageLink,
    required this.instructions
  });

  factory Recipe.fromJson(Map<String, dynamic> json){
    return Recipe(
      id: json['id'],
      name: json['name'],
      author: json['author'],
      imageLink: json['image_link'],
      instructions: List<String>.from(json['recipe'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'image_link': imageLink,
      'recipe': instructions
    };
  }

  @override
  String toString() {
    return 'Recipe{id: $id, name: $name, author: $author, imageLink: $imageLink, instructions: $instructions}';
  }

}
