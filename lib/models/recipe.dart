class Recipe {
  final String name;
  final String author;
  final String imageLink;
  final List<String> instructions;

  const Recipe({
      required this.name,
      required this.author,
      required this.imageLink,
      required this.instructions
  });

  factory Recipe.fromJson(Map<String, dynamic> json){
    return Recipe(
      name: json['name'],
      author: json['author'],
      imageLink: json['image_link'],
      instructions: List<String>.from(json['recipe'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'author': author,
      'image_link': imageLink,
      'recipe': instructions
    };
  }

  @override
  String toString() {
    return 'Recipe{name: $name, author: $author, imageLink: $imageLink, instructions: $instructions}';
  }

}
