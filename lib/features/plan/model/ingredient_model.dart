class Ingredient {
  final String name;
  final String quantity;

  Ingredient({
    required this.name,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'quantity': quantity,
  };

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    name: json['name'],
    quantity: json['quantity'],
  );
}
