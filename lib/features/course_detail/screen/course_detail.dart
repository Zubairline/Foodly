import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodly_backup/features/course_detail/managers/course_details_bloc.dart';
import 'package:foodly_backup/features/course_detail/managers/course_details_event.dart';
import 'package:foodly_backup/features/course_detail/managers/course_details_state.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class CourseDetailScreen extends StatefulWidget {
  final int courseId;

  const CourseDetailScreen({super.key, required this.courseId});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    context.read<CourseDetailBloc>().add(LoadCourseDetail(widget.courseId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course Details')),
      body: BlocBuilder<CourseDetailBloc, CourseDetailState>(
        builder: (context, state) {
          if (state is CourseDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CourseDetailLoaded) {
            final course = state.course;
            final videoId = YoutubePlayerController.convertUrlToId(course.youtubeUrl);
            if (videoId != null) {
              _controller = YoutubePlayerController.fromVideoId(
                videoId: videoId,
                autoPlay: false,
                params: const YoutubePlayerParams(
                  mute: false,
                  showControls: true,
                  showFullscreenButton: true,
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_controller != null)
                    YoutubePlayer(controller: _controller!, aspectRatio: 16 / 9)
                  else
                    Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Text('No video available for this course'),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    course.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${course.category} • ${course.estimatedTime}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Text(course.description, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 16),
                  const Text('Content:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...course.content.map(
                        (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('• $item'),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CourseDetailError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Select a course to view details.'));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }
}
