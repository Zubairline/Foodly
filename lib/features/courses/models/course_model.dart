class Course {
  final int id;
  final String title;
  final String category;
  final String estimatedTime;
  final String description;
  final List<String> content;
  final String youtubeUrl;
  final double averageRating;

  Course({
    required this.id,
    required this.title,
    required this.category,
    required this.estimatedTime,
    required this.description,
    required this.content,
    required this.youtubeUrl,
    required this.averageRating,
  });

  factory Course.fromJson(Map<String, dynamic> json, double averageRating) {
    return Course(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      estimatedTime: json['estimatedTime'],
      description: json['description'],
      content: List<String>.from(json['content']),
      youtubeUrl: json['youtubeUrl'],
      averageRating: averageRating,
    );
  }
}
