import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodly_backup/config/utils/routes.dart';
import 'package:foodly_backup/features/courses/managers/courses_bloc.dart';
import 'package:foodly_backup/features/courses/managers/courses_event.dart';
import 'package:foodly_backup/features/courses/managers/courses_state.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CoursesBloc>().add(LoadCoursesEvent());
  }

  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 16,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        if (state is CoursesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CoursesError) {
          return Center(child: Text(state.message));
        } else if (state is CoursesLoaded) {
          final courses = state.courses;
          return ListView.builder(
            padding: const EdgeInsets.only(top: 16),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(course.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${course.category} • ${course.estimatedTime}'),
                      const SizedBox(height: 4),
                      _buildStarRating(course.averageRating),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteGenerator.courseContent,
                      arguments: course.id,
                    );
                  },
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
