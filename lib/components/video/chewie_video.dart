import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoChew extends StatefulWidget {
  const VideoChew({Key? key, required this.videoPlayerController})
      : super(key: key);
  final VideoPlayerController? videoPlayerController;

  @override
  State<VideoChew> createState() => _VideoChewState();
}

class _VideoChewState extends State<VideoChew> {
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController!,
        aspectRatio: widget.videoPlayerController!.value.aspectRatio,
        autoInitialize: true,
        looping: true,
        errorBuilder: (context, errorMessage) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                errorMessage,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController!.dispose();
    _chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.0,
      width: MediaQuery.of(context).size.width - 150,
      child: Chewie(
        controller: _chewieController!,
      ),
    );
  }
}
