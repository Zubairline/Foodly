import 'package:flutter/material.dart';
import 'package:foodly_backup/features/courses/models/course_model.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class CourseDetailScreen extends StatefulWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayerController.convertUrlToId(
      widget.course.youtubeUrl,
    );
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
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.course.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_controller != null)
              YoutubePlayer(controller: _controller!, aspectRatio: 16 / 9),
            if (_controller == null)
              Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(
                  child: Text('No video available for this course'),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              widget.course.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.course.category} • ${widget.course.estimatedTime}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              widget.course.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Content:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...widget.course.content.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('• $item'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
