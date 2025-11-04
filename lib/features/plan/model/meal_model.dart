import 'package:foodly_backup/features/plan/model/ingredient_model.dart';

class Meal {
  final String name;
  final String category;
  final String time;
  final String image;
  final List<Ingredient> ingredients;

  Meal({
    required this.name,
    required this.category,
    required this.time,
    required this.image,
    this.ingredients = const [],
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'category': category,
    'time': time,
    'image': image,
    'ingredients': ingredients.map((i) => i.toJson()).toList(),
  };

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
    name: json['name'],
    category: json['category'],
    time: json['time'],
    image: json['image'],
    ingredients: (json['ingredients'] as List<dynamic>?)
        ?.map((i) => Ingredient.fromJson(i as Map<String, dynamic>))
        .toList() ?? [],
  );
}
