import 'package:foodly_backup/features/courses/models/course_model.dart';

abstract class CourseDetailState {}

class CourseDetailInitial extends CourseDetailState {}

class CourseDetailLoading extends CourseDetailState {}

class CourseDetailLoaded extends CourseDetailState {
  final Course course;

  CourseDetailLoaded(this.course);

  List<Object?> get props => [course];
}

class CourseDetailError extends CourseDetailState {
  final String message;

  CourseDetailError(this.message);

  List<Object?> get props => [message];
}
