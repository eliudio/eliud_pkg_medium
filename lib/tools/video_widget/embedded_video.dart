import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class EmbeddedVideo extends StatefulWidget {
  final String url;

  const EmbeddedVideo({super.key, required this.url});

  @override
  State<EmbeddedVideo> createState() => _EmbeddedVideoState();
}

class _EmbeddedVideoState extends State<EmbeddedVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stack widget;
    if (_controller.value.isPlaying) {
      widget = Stack(
        children: [
          VideoPlayer(_controller),
          Align(alignment: Alignment.bottomCenter, child: Icon(Icons.pause)),
        ],
      );
    } else {
      widget = Stack(
        children: [
          VideoPlayer(_controller),
          Align(
              alignment: Alignment.bottomCenter, child: Icon(Icons.play_arrow)),
        ],
      );
    }
    return Container(
        height: 300,
        child: GestureDetector(
            child: widget,
            onTap: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.setLooping(true);
                  _controller.play();
                }
              });
            }));
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }
}
