import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class BasicOverlayWidget extends StatefulWidget {
  const BasicOverlayWidget(
      {Key? key, required this.controller, required this.onClickedFullScreen})
      : super(key: key);
  final VideoPlayerController? controller;
  final VoidCallback? onClickedFullScreen;

  @override
  State<BasicOverlayWidget> createState() => _BasicOverlayWidgetState();
}

class _BasicOverlayWidgetState extends State<BasicOverlayWidget> {
  VideoPlayerController? controller;
  VoidCallback? onClickedFullScreen;

  @override
  void initState() {
    controller = widget.controller;
    onClickedFullScreen = widget.onClickedFullScreen;
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
            child: Row(
              children: [
                Expanded(
                  child: buildIndicator(),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                /*GestureDetector(
                  onTap: pushFullScreenVideo,
                  child: const Icon(
                    Icons.fullscreen,
                    color: Colors.white,
                    size: 28.0,
                  ),
                )*/
              ],
            ),
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

  void pushFullScreenVideo() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    );

    Navigator.of(context)
        .push(
      PageRouteBuilder(
        opaque: false,
        settings: const RouteSettings(),
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: Dismissible(
                  key: const Key('key'),
                  direction: DismissDirection.vertical,
                  onDismissed: (_) => Navigator.of(context).pop(),
                  child: OrientationBuilder(
                    builder: (context, orientation) {
                      bool isPortrait = (orientation == Orientation.portrait);
                      return Center(
                        child: Stack(
                          //This will help to expand video in Horizontal mode till last pixel of screen
                          fit: isPortrait ? StackFit.loose : StackFit.expand,
                          children: [
                            AspectRatio(
                              aspectRatio: controller!.value.aspectRatio,
                              child: VideoPlayer(controller!),
                            ),
                          ],
                        ),
                      );
                    },
                  )));
        },
      ),
    )
        .then(
      (value) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        SystemChrome.setPreferredOrientations(
          [
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ],
        );
      },
    );
  }
}
