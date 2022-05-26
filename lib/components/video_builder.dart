import 'package:flutter/material.dart';
import 'package:pfe_app/components/video/basic_overlay_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_orientation/auto_orientation.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key, required this.controller})
      : super(key: key);
  final VideoPlayerController? controller;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? controller;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return controller != null && controller!.value.isInitialized
        ? Container(
            alignment: Alignment.center,
            child: buildVideo(),
          )
        : const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget buildVideo() => Stack(
        fit: StackFit.expand,
        children: [
          buildVideoPlayer(),
          Positioned.fill(
            child: BasicOverlayWidget(
              controller: controller,
              onClickedFullScreen: () {
                AutoOrientation.landscapeRightMode();
              },
            ),
          ),
        ],
      );

  Widget buildVideoPlayer() => buildFullScreen(
        child: SizedBox(
          height: 350.0,
          width: MediaQuery.of(context).size.width - 150,
          child: AspectRatio(
            aspectRatio: controller!.value.aspectRatio,
            child: VideoPlayer(controller!),
          ),
        ),
      );

  Widget buildFullScreen({required Widget child}) {
    final size = controller!.value.size;
    final width = size.width;
    final height = size.height;
    return FittedBox(
      fit: BoxFit.fill,
      child: SizedBox(
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}
