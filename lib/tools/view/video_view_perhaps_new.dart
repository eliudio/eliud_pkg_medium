import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum SourceType { file, network }

class VideoView extends StatefulWidget {
  final SourceType sourceType;
  final String source;

  VideoView({super.key, required this.sourceType, required this.source});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    if (widget.sourceType == SourceType.file) {
      videoPlayerController = VideoPlayerController.file(File(widget.source));
    } else {
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.source));
//      videoPlayerController = VideoPlayerController.network(widget.source);
    }
    await videoPlayerController.initialize();
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: videoPlayerController.value.aspectRatio,
      autoPlay: true,
      looping: false,
      allowFullScreen: false,
      fullScreenByDefault: false,
      showControls: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            videoPlayerController.value.isInitialized
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * .8,
                    child: Chewie(
                      controller: chewieController!,
                    ))
                : Center(
                    child: CircularProgressIndicator(),
                  )
          ]),
          Align(
              alignment: Alignment.topRight,
              child: /*Column(children: [*/
                  TextButton(
                child: Icon(Icons.close, color: Colors.red, size: 30),
                onPressed: () {
                  Navigator.maybePop(context);
                },
              )
/*          ], mainAxisAlignment: MainAxisAlignment.start)),]*/
              )
        ]));
  }
}
