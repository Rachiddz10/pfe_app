import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BasicOverlayWidget extends StatefulWidget {
  const BasicOverlayWidget({Key? key, required this.controller})
      : super(key: key);
  final VideoPlayerController? controller;

  @override
  State<BasicOverlayWidget> createState() => _BasicOverlayWidgetState();
}

class _BasicOverlayWidgetState extends State<BasicOverlayWidget> {
  VideoPlayerController? controller;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        controller!.value.isPlaying ? controller!.pause() : controller!.play();
      },
      child: Stack(
        children: [
          buildPlay(),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: buildIndicator(),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return VideoProgressIndicator(
      controller!,
      allowScrubbing: true,
    );
  }

  Widget buildPlay() {
    return controller!.value.isPlaying
        ? Container()
        : Container(
            alignment: Alignment.center,
            color: Colors.black26,
            child: const Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 80.0,
            ),
          );
  }
}
