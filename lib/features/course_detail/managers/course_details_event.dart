abstract class CourseDetailEvent {}

class LoadCourseDetail extends CourseDetailEvent {
  final int courseId;

  LoadCourseDetail(this.courseId);

  List<Object?> get props => [courseId];
}
