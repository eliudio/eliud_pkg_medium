import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class EmbeddedVideo extends StatefulWidget {
  final String url;

  const EmbeddedVideo({Key? key, required this.url}) : super(key: key);

  @override
  _EmbeddedVideoState createState() => _EmbeddedVideoState();
}

class _EmbeddedVideoState extends State<EmbeddedVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    var widget;
    if (_controller.value.isPlaying) {
      widget = Stack(children: [
        VideoPlayer(_controller),
        Align(alignment: Alignment.bottomCenter, child: Icon(Icons.pause)),
      ],);
    } else {
      widget = Stack(children: [
        VideoPlayer(_controller),
        Align(alignment: Alignment.bottomCenter, child: Icon(Icons.play_arrow)),
      ],);
    }
    return GestureDetector(
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
        });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}