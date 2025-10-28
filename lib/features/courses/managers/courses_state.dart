import 'package:foodly_backup/features/courses/models/course_model.dart';

abstract class CoursesState {}

class CoursesInitial extends CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesLoaded extends CoursesState {
  final List<Course> courses;

  CoursesLoaded(this.courses);

  List<Object?> get props => [courses];
}

class CoursesError extends CoursesState {
  final String message;

  CoursesError(this.message);

  List<Object?> get props => [message];
}
