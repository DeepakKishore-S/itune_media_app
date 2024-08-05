import 'package:flutter/material.dart';
import 'package:itunes_media_app/res/AppContextExtension.dart';
import 'package:itunes_media_app/view/shared/text_view.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() {
        if (_controller.value.hasError) {
          setState(() {
            _hasError = true;
          });
        }
      })
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
      }).catchError((error) {
        setState(() {
          _hasError = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Center(
        child: MyTextView(
          label: "No Preview Image",
          fontSize: context.resources.dimension.smallText,
          fontWeight: FontWeight.w300,
        ),
      );
    }

    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
