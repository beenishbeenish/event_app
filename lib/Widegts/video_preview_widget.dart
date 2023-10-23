import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget(
      {Key? key, required this.url, this.mediaTypeisLocalVideo, this.file})
      : super(key: key);
  final String url;
  bool? mediaTypeisLocalVideo = false;
  File? file;

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with WidgetsBindingObserver {
  Color mainColor = kColorPrimary;
  Color mainColorBorder = Colors.grey;
  Color tileColor = Colors.white;

  var _videoPlayerController;

  bool isLoading = true;
  late Future<void> _initializeVideoPlayerFuture;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    if (widget.mediaTypeisLocalVideo == false) {
      _videoPlayerController = VideoPlayerController.network(widget.url);
    } else {
      _videoPlayerController = VideoPlayerController.file(widget.file!);
    }
    _initializeVideoPlayerFuture =
        _videoPlayerController.initialize().then((value) {
      setState(() {
        isLoading = false;
      });

      _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          showControls: false,
          showControlsOnInitialize: false,
          autoPlay: false,
          allowFullScreen: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: isLoading
          ? Shimmer.fromColors(
              direction: ShimmerDirection.ttb,
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Container(
                color: Colors.grey.shade200,
              ),
            )
          : Chewie(
              controller: _chewieController,
            ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoPlayerController.dispose();
    //_chewieController.dispose();
    super.dispose();
  }
}
