abstract class CoursesEvent {}

class LoadCoursesEvent extends CoursesEvent {}

class SubmitRatingEvent extends CoursesEvent {
  final int courseId;
  final int rating;
  final String feedback;

  SubmitRatingEvent({
    required this.courseId,
    required this.rating,
    required this.feedback,
  });

  List<Object?> get props => [courseId, rating, feedback];
}
