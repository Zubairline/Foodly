import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:foodly_backup/features/courses/models/course_model.dart';

class CourseService {
  static Future<List<Course>> loadCourses() async {
    final String response = await rootBundle.loadString('assets/json/courses.json');
    final List<dynamic> data = json.decode(response);

    final String ratingsResponse = await rootBundle.loadString('assets/csv/ratings.csv');
    final List<String> ratingsLines = ratingsResponse.split('\n').where((line) => line.isNotEmpty).toList();
    final Map<int, List<int>> ratingsMap = {};

    for (final line in ratingsLines) {
      final parts = line.split(',');
      if (parts.length == 2) {
        final id = int.tryParse(parts[0]);
        final rating = int.tryParse(parts[1]);
        if (id != null && rating != null) {
          ratingsMap.putIfAbsent(id, () => []).add(rating);
        }
      }
    }

    return data.map((json) {
      final id = json['id'] as int;
      final ratings = ratingsMap[id] ?? [];
      final averageRating = ratings.isNotEmpty ? ratings.reduce((a, b) => a + b) / ratings.length : 0.0;
      return Course.fromJson(json, averageRating);
    }).toList();
  }
}
