import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodly_backup/features/course_detail/managers/course_details_event.dart';
import 'package:foodly_backup/features/course_detail/managers/course_details_state.dart';
import 'package:foodly_backup/features/courses/models/course_model.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  CourseDetailBloc() : super(CourseDetailInitial()) {
    on<LoadCourseDetail>(_onLoadCourseDetail);
  }

  Future<void> _onLoadCourseDetail(
    LoadCourseDetail event,
    Emitter<CourseDetailState> emit,
  ) async {
    emit(CourseDetailLoading());
    try {
      final jsonString = await rootBundle.loadString(
        'assets/json/courses.json',
      );
      final List<dynamic> data = json.decode(jsonString);

      final courseData = data.firstWhere(
        (item) => item['id'] == event.courseId,
        orElse: () => throw Exception('Course not found'),
      );

      final course = Course.fromJson(courseData, 0.0);

      emit(CourseDetailLoaded(course));
    } catch (e) {
      emit(CourseDetailError('Failed to load course details.'));
    }
  }
}
