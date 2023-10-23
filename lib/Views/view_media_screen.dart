import 'package:better_video_player/better_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Utils/app_colors.dart';

import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../Provider/greeting_class.dart';

class ViewMediaScreen extends StatefulWidget {
  ViewMediaScreen({
    Key? key,
    required this.mediaURl,
    required this.mediaType,
  }) : super(key: key);

  final String mediaURl;
  final String mediaType;

  @override
  State<ViewMediaScreen> createState() => _ViewMediaScreenState();
}

class _ViewMediaScreenState extends State<ViewMediaScreen> {
  late BetterVideoPlayerController controller;

  @override
  void initState() {
    controller = BetterVideoPlayerController();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final languageModel = Provider.of<LanguageClass>(context);
    final greetingModal = Provider.of<GreetingClass>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        // title: Text(
        //   languageModel.languageResponseModel != null
        //       ? languageModel
        //           .languageResponseModel!.mobileGallery.sidebarGreetings
        //       : 'Greetings',
        //   style: const TextStyle(color: Colors.white),
        // ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Container(
          height: screenSize.height * 0.85,
          width: screenSize.width,
          child: widget.mediaType == 'application/mp4'
              ? AspectRatio(
                  aspectRatio: 16.0 / 9.0,
                  child: BetterVideoPlayer(
                    controller: controller,
                    configuration: BetterVideoPlayerConfiguration(
                      autoPlay: false,
                      placeholder: Image.network(
                        widget.mediaURl,
                        fit: BoxFit.contain,
                      ),
                      // controls: const _CustomVideoPlayerControls(),
                    ),
                    dataSource: BetterVideoPlayerDataSource(
                        BetterVideoPlayerDataSourceType.network,
                        widget.mediaURl),
                  ),
                )
              : ClipRRect(
                  //borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    height: screenSize.height,
                    width: screenSize.width,
                    fit: BoxFit.contain,
                    imageUrl: widget.mediaURl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: Shimmer.fromColors(
                        direction: ShimmerDirection.ttb,
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: Container(
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
        ),
      ),
    );
  }
}
