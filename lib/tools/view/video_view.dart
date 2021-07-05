import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum SourceType { File, Network }

class VideoView extends StatefulWidget {
  final SourceType sourceType;
  final String source;

  VideoView({Key? key, required this.sourceType, required this.source})
      : super(key: key);

  @override
  _VideoViewState createState() => new _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  Future<void>? future;

  Future<void> initVideoPlayer() async {
    await videoPlayerController!.initialize();
    setState(() {
      print(videoPlayerController!.value.aspectRatio);
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        aspectRatio: videoPlayerController!.value.aspectRatio,
        autoPlay: true,
        looping: false,
        allowFullScreen: false,
        fullScreenByDefault: false,
        showControls: true,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.sourceType == SourceType.File) {
      videoPlayerController = VideoPlayerController.file(File(widget.source));
    } else {
      videoPlayerController = VideoPlayerController.network(widget.source);
    }
    future = initVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  return new Center(
                    child: videoPlayerController!.value.isInitialized
                        ? AspectRatio(
                            aspectRatio:
                                videoPlayerController!.value.aspectRatio,
                            child: Theme(
                                data: Theme.of(context).copyWith(
                                  dialogBackgroundColor: Colors.white,
                                ),
                                child: Chewie(
                                  controller: chewieController!,
                                )),
                          )
                        : new Center(child: CircularProgressIndicator()),
                  );
                })
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

  @override
  void dispose() {
    videoPlayerController!.dispose();
    chewieController!.dispose();
    super.dispose();
  }
}
