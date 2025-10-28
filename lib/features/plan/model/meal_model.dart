class Meal {
  final String name;
  final String category;
  final String time;
  final String image;

  Meal({
    required this.name,
    required this.category,
    required this.time,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'category': category,
    'time': time,
    'image': image,
  };

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
    name: json['name'],
    category: json['category'],
    time: json['time'],
    image: json['image'],
  );
}
