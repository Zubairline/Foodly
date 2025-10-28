import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodly_backup/features/courses/models/course_model.dart';
import 'courses_event.dart';
import 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc() : super(CoursesInitial()) {
    on<LoadCoursesEvent>(_onLoadCourses);
  }

  Future<void> _onLoadCourses(
      LoadCoursesEvent event, Emitter<CoursesState> emit) async {
    emit(CoursesLoading());
    try {
      final jsonString = await rootBundle.loadString('assets/json/courses.json');
      final List<dynamic> data = json.decode(jsonString);

      // Here we generate random average ratings for demo
      final List<Course> courses = data.map((json) {
        final randomRating = (3 + (2 * (json['id'] % 3))).toDouble(); // Just a placeholder
        return Course.fromJson(json, randomRating);
      }).toList();

      emit(CoursesLoaded(courses));
    } catch (e) {
      emit(CoursesError('Failed to load courses: $e'));
    }
  }
}
