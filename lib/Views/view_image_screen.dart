import 'package:better_video_player/better_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_app/Provider/auth_class.dart';
import 'package:event_app/Provider/comments_class.dart';
import 'package:event_app/Provider/data_class.dart';
import 'package:event_app/Provider/events_class.dart';
import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Views/comments_screen.dart';
import 'package:event_app/Views/view_media_screen.dart';
import 'package:event_app/Widegts/alert_popup_widget.dart';
import 'package:event_app/Widegts/delete_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:toast/toast.dart';

import '../Widegts/video_preview_widget.dart';

class ImageViewScreen extends StatefulWidget {
  ImageViewScreen(
      {Key? key,
      required this.currentIndex,
      required this.imageId,
      required this.currentPage,
      required this.tempScreenWidth,
      required this.isFromPublicGallery})
      : super(key: key);

  int currentIndex;
  int currentPage;
  final String imageId;
  double tempScreenWidth;

  bool isFromPublicGallery;

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  int _current = 0;
  late BetterVideoPlayerController controller;
  double value = 0;
  var languageModel;
  late String currentImageUrl;
  CarouselController controllerC = CarouselController();

  final _scrollController = ScrollController();
  double scrollScreenJump = 0.0;
  int previousIndex = 0;

  @override
  void initState() {
    controller = BetterVideoPlayerController();
    ToastContext().init(context);
    // languageModel  = Provider.of<LanguageClass>(context);
    final commentModel = Provider.of<CommentClass>(context, listen: false);
    final postModel = Provider.of<DataClass>(context, listen: false);
    // commentModel.currentImageURl = widget.currentImageURl;
    currentImageUrl =
        postModel.publicGalleryResponseModel!.images[widget.currentIndex];
    _current = widget.currentIndex;
    commentModel.imageDetailsResponseModel = null;
    commentModel.checksResponseModel = null;

    if (widget.currentIndex >=
        postModel.publicGalleryResponseModel!.images.length - 3) {
      postModel.selectedPublicGalleryTab(
          pId: AppGlobal.pId,
          context: context,
          eventId: AppGlobal.eventId,
          selectedTab: postModel.isPublicGallerySelected
              ? "Public Gallery"
              : "My Uploads",
          token: AppGlobal.token);
    }

    Future.delayed(Duration.zero, () async {
      commentModel.getlAllChecksInfo(
          token: AppGlobal.token, eventId: AppGlobal.eventId, context: context);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  getTimeAgo({
    required String datefrom,
  }) {
    final DateTime docDateTime = DateTime.parse(datefrom);

    return timeago.format(docDateTime);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final eventModal = Provider.of<EventClass>(context);
    final commentModal = Provider.of<CommentClass>(context);
    final authModal = Provider.of<AuthClass>(context);
    final languageModel = Provider.of<LanguageClass>(context);
    final postModel = Provider.of<DataClass>(context);

    return Scaffold(
      backgroundColor: kColorBackGround,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: Text(
          languageModel.languageResponseModel != null
              ? languageModel.languageResponseModel!.imageView.viewImage
              : 'View Image',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: kColorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: commentModal.downloading
            ? SimpleCircularProgressBar(
                size: 40,
                valueNotifier: ValueNotifier(commentModal.downloadingPercent),
                backColor: kColorBackGround,
                backStrokeWidth: 10,
                progressColors: const [kColorPrimary],
                fullProgressColor: kColorPrimary,
                progressStrokeWidth: 5,
                mergeMode: false,
                onGetText: (double value) {
                  return Text(
                    '${commentModal.downloadingPercent.toInt()}%',
                    style: const TextStyle(fontSize: 10),
                  );
                },
              )
            : Container(),
      ),
      body: SingleChildScrollView(
        child: eventModal.loading
            ? Center(
                child: Container(
                  height: screenSize.height * 0.75,
                  alignment: Alignment.center,
                  child: SpinKitFadingCircle(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: kColorTextField,
                        ),
                      );
                    },
                  ),
                ),
              )
            : Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Container(
                      height: screenSize.height * 0.40,
                      width: screenSize.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kColorPrimary,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: kColorPrimary,
                      ),
                      child: CarouselSlider(
                        carouselController: controllerC,
                        options: CarouselOptions(
                          height: screenSize.height * 0.40,
                          enableInfiniteScroll: false,
                          autoPlay: false,
                          initialPage: widget.currentIndex,
                          viewportFraction: 1,
                          autoPlayInterval: const Duration(seconds: 6),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          // enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            print('$index');
                            widget.currentIndex = index;
                            // if (postModel.publicGalleryResponseModel!
                            //         .gal[widget.currentIndex].type ==
                            //     'application/mp4') {
                            //   controller = BetterVideoPlayerController();
                            // }
                            setState(() {
                              _current = index;
                              if (_current % 3 == 0) {
                                if (previousIndex > _current) {
                                  scrollScreenJump = scrollScreenJump -
                                      screenSize.width * 0.07;
                                  _scrollController.jumpTo(scrollScreenJump);
                                } else {
                                  scrollScreenJump = scrollScreenJump +
                                      screenSize.width * 0.05;
                                  _scrollController.jumpTo(scrollScreenJump);
                                }
                                previousIndex = _current;
                              }
                            });
                            if (widget.currentIndex >=
                                postModel.publicGalleryResponseModel!.images
                                        .length -
                                    3) {
                              postModel.selectedPublicGalleryTab(
                                  pId: AppGlobal.pId,
                                  context: context,
                                  eventId: AppGlobal.eventId,
                                  selectedTab: postModel.isPublicGallerySelected
                                      ? "Public Gallery"
                                      : "My Uploads",
                                  token: AppGlobal.token);
                            }
                          },
                        ),
                        items: postModel.publicGalleryResponseModel!.images
                            .map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ViewMediaScreen(
                                                    mediaURl: postModel
                                                            .publicGalleryResponseModel!
                                                            .images[
                                                        widget.currentIndex],
                                                    mediaType: postModel
                                                        .publicGalleryResponseModel!
                                                        .gal[
                                                            widget.currentIndex]
                                                        .type,
                                                  )));
                                    },
                                    child: Container(
                                      height: screenSize.height * 0.33,
                                      child: postModel
                                                  .publicGalleryResponseModel!
                                                  .gal[widget.currentIndex]
                                                  .type ==
                                              'application/mp4'
                                          ? Stack(children: [
                                              Container(
                                                  height:
                                                      screenSize.height * 0.33,
                                                  // height: 130.0,
                                                  color: Colors.black,
                                                  child: VideoPlayerWidget(
                                                      url: i,
                                                      mediaTypeisLocalVideo:
                                                          false)),
                                              Positioned(
                                                  child: Center(
                                                      child: Icon(
                                                Icons
                                                    .play_circle_outline_outlined,
                                                color: Colors.white,
                                                size: screenSize.height * 0.1,
                                              )))
                                            ])
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                height: screenSize.height,
                                                width: screenSize.width,
                                                fit: BoxFit.cover,
                                                imageUrl: i,
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        SizedBox(
                                                  width: 100.0,
                                                  height: 100.0,
                                                  child: Shimmer.fromColors(
                                                    direction:
                                                        ShimmerDirection.ttb,
                                                    baseColor:
                                                        Colors.grey.shade300,
                                                    highlightColor:
                                                        Colors.grey.shade100,
                                                    enabled: true,
                                                    child: Container(
                                                      color:
                                                          Colors.grey.shade200,
                                                    ),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                    ),
                                  ),
                                  postModel.publicGalleryResponseModel != null
                                      ? postModel
                                                  .publicGalleryResponseModel!
                                                  .gal[widget.currentIndex]
                                                  .task !=
                                              null
                                          ? Container(
                                              height: screenSize.height * 0.06,
                                              width: screenSize.width * 0.8,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: kColorPrimary
                                                    .withOpacity(0.1),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                postModel
                                                    .publicGalleryResponseModel!
                                                    .gal[widget.currentIndex]
                                                    .task!
                                                    .name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 17),
                                              )))
                                          : SizedBox()
                                      : const SizedBox(),
                                ],
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: postModel.publicGalleryResponseModel!.images.length >
                            1
                        ? postModel.publicGalleryResponseModel!.images.length >
                                2
                            ? postModel.publicGalleryResponseModel!.images
                                        .length >
                                    4
                                ? screenSize.width * 0.2
                                : screenSize.width * 0.11
                            : screenSize.width * 0.06
                        : screenSize.width * 0.04,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: postModel.publicGalleryResponseModel!.images
                            .map((url) {
                          int index = postModel
                              .publicGalleryResponseModel!.images
                              .indexOf(url);
                          return Container(
                            width: _current == index ? 8 : 5,
                            height: _current == index ? 8 : 5,
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 2,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? kColorPrimary
                                  : const Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.currentIndex > 0
                            ? InkWell(
                                onTap: () {
                                  if (widget.currentIndex > 0) {
                                    widget.currentIndex =
                                        widget.currentIndex - 1;
                                    _current = widget.currentIndex;
                                    // if (postModel.publicGalleryResponseModel!
                                    //         .gal[widget.currentIndex].type ==
                                    //     'application/mp4') {
                                    //   controller =
                                    //       BetterVideoPlayerController();
                                    // }
                                    controllerC.previousPage();
                                    setState(() {
                                      _current = widget.currentIndex;
                                      if (_current % 3 == 0) {
                                        scrollScreenJump = scrollScreenJump -
                                            screenSize.width * 0.05;
                                        _scrollController
                                            .jumpTo(scrollScreenJump);
                                      }
                                    });
                                    // if (widget.isFromPublicGallery) {
                                    //   commentModal.getImageDetailByIndex(
                                    //       imageId: postModel
                                    //           .publicGalleryResponseModel!
                                    //           .gal[widget.currentIndex]
                                    //           .id,
                                    //       token: AppGlobal.token,
                                    //       context: context);
                                    // }
                                    // else {
                                    //   commentModal.getImageDetailByIndex(
                                    //       imageId: postModel
                                    //           .allMyUploadResponseModel!
                                    //           .gal[widget.currentIndex]
                                    //           .id,
                                    //       token: AppGlobal.token,
                                    //       context: context);
                                    // }
                                  }
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: kColorPrimary,
                                ),
                              )
                            : const SizedBox(
                                width: 25,
                              ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (commentModal
                                        .checksResponseModel?.downloadAllowed ==
                                    'yes') {
                                  commentModal.downloadFile(
                                      postModel.publicGalleryResponseModel !=
                                              null
                                          ? postModel
                                              .publicGalleryResponseModel!
                                              .images[widget.currentIndex]
                                          : '',
                                      contextVar: context,
                                      type: postModel
                                                  .publicGalleryResponseModel !=
                                              null
                                          ? postModel
                                              .publicGalleryResponseModel!
                                              .gal[widget.currentIndex]
                                              .type
                                          : '',
                                      languageModel: languageModel);
                                } else if (commentModal
                                        .checksResponseModel?.downloadAllowed ==
                                    'no') {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertPopup(
                                          title: languageModel
                                                      .languageResponseModel !=
                                                  null
                                              ? languageModel
                                                  .languageResponseModel!
                                                  .imageView
                                                  .downloadErr
                                              : 'Download Error!',
                                          icon: false,
                                          content: languageModel
                                                      .languageResponseModel !=
                                                  null
                                              ? languageModel
                                                  .languageResponseModel!
                                                  .imageView
                                                  .downloadNAllowd
                                              : 'Downloading not allowed in your package.',
                                        );
                                      });
                                } else if (authModal.authModel != null &&
                                    authModal.authModel!.user.socialEmail !=
                                        null) {
                                  commentModal.downloadFile(
                                      postModel.publicGalleryResponseModel !=
                                              null
                                          ? postModel
                                              .publicGalleryResponseModel!
                                              .images[widget.currentIndex]
                                          : '',
                                      contextVar: context,
                                      type: postModel
                                                  .publicGalleryResponseModel !=
                                              null
                                          ? postModel
                                              .publicGalleryResponseModel!
                                              .gal[widget.currentIndex]
                                              .type
                                          : '',
                                      languageModel: languageModel);
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertPopup(
                                          title: languageModel
                                                      .languageResponseModel !=
                                                  null
                                              ? '${languageModel.languageResponseModel!.generalMessages.sorry}!'
                                              : 'Sorry!',
                                          icon: false,
                                          content: languageModel
                                                      .languageResponseModel !=
                                                  null
                                              ? languageModel
                                                  .languageResponseModel!
                                                  .imageView
                                                  .registerEmail
                                              : 'Please Register your email',
                                        );
                                      });
                                }
                              },
                              child: SvgPicture.asset(
                                  "assets/icons/Group 7689.svg",
                                  height: 20,
                                  width: 20,
                                  semanticsLabel: ''),
                            ),
                            SizedBox(
                              width: !widget.isFromPublicGallery
                                  ? screenSize.width * 0.2
                                  : 0,
                            ),
                            !widget.isFromPublicGallery
                                ?

                                ///Todo: Delete Functionality is undergoing
                                InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext contextVar) {
                                            return DeletePopup(
                                              content: languageModel
                                                          .languageResponseModel !=
                                                      null
                                                  ? languageModel
                                                      .languageResponseModel!
                                                      .imageView
                                                      .confirmationMsg
                                                  : 'Are you sure you want to delete this Item.',
                                              onDeletePress: () async {
                                                // Navigator.pop(contextVar);
                                                print(
                                                    'Current Index Going to Delete12: ${widget.currentIndex}');

                                                print(
                                                    'List Length12: ${postModel.publicGalleryResponseModel!.images.length}');
                                                await commentModal
                                                    .getDeleteImageResponse(
                                                        imageId: postModel
                                                            .publicGalleryResponseModel!
                                                            .gal[widget
                                                                .currentIndex]
                                                            .id,
                                                        context: context);
                                                // if (commentModal
                                                //         .greetingSaveResponseModel!
                                                //         .message ==
                                                //     'Data fetched successfully') {
                                                //   //Navigator.pop((context));

                                                if (widget.currentIndex <
                                                    postModel
                                                        .publicGalleryResponseModel!
                                                        .images
                                                        .length) {
                                                  postModel.loading = true;
                                                  postModel
                                                      .refreshScreenState();
                                                  print(
                                                      'Current Index Going to Delete: ${widget.currentIndex}');

                                                  print(
                                                      'List Length: ${postModel.publicGalleryResponseModel!.images.length}');

                                                  postModel
                                                      .publicGalleryResponseModel!
                                                      .images
                                                      .removeAt(
                                                          widget.currentIndex);

                                                  postModel.loading = false;
                                                  postModel
                                                      .refreshScreenState();
                                                }

                                                if (postModel
                                                    .publicGalleryResponseModel!
                                                    .images
                                                    .isEmpty) {
                                                  print(
                                                      '>>>>>>>>>>Pop up condition');
                                                  Navigator.pop(context);
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertPopup(
                                                          title: languageModel
                                                                      .languageResponseModel !=
                                                                  null
                                                              ? languageModel
                                                                  .languageResponseModel!
                                                                  .imageView
                                                                  .deleted
                                                              : 'Deleted!',
                                                          icon: false,
                                                          content: languageModel
                                                                      .languageResponseModel !=
                                                                  null
                                                              ? languageModel
                                                                  .languageResponseModel!
                                                                  .imageView
                                                                  .deletedSuccess
                                                              : 'Item deleted Successfully.',
                                                        );
                                                      });
                                                }
                                              },
                                            );
                                          });
                                    },
                                    child: SvgPicture.asset(
                                        "assets/icons/Group 7688.svg",
                                        height: 20,
                                        width: 20,
                                        semanticsLabel: ''),
                                  )
                                : Container(),
                          ],
                        ),
                        widget.currentIndex <
                                postModel.publicGalleryResponseModel!.gal
                                        .length -
                                    1
                            ? InkWell(
                                onTap: () {
                                  if (widget.currentIndex <
                                      postModel.publicGalleryResponseModel!
                                              .images.length -
                                          1) {
                                    widget.currentIndex =
                                        widget.currentIndex + 1;
                                    _current = widget.currentIndex;
                                    // if (postModel.publicGalleryResponseModel!
                                    //         .gal[widget.currentIndex].type ==
                                    //     'application/mp4') {
                                    //   controller =
                                    //       BetterVideoPlayerController();
                                    // }

                                    controllerC.nextPage();

                                    setState(() {
                                      _current = widget.currentIndex;
                                      if (_current % 3 == 0) {
                                        scrollScreenJump = scrollScreenJump +
                                            screenSize.width * 0.05;
                                        _scrollController
                                            .jumpTo(scrollScreenJump);
                                      }
                                    });

                                    if (widget.currentIndex >=
                                        postModel.publicGalleryResponseModel!
                                                .images.length -
                                            3) {
                                      postModel.selectedPublicGalleryTab(
                                          pId: AppGlobal.pId,
                                          context: context,
                                          eventId: AppGlobal.eventId,
                                          selectedTab:
                                              postModel.isPublicGallerySelected
                                                  ? "Public Gallery"
                                                  : "My Uploads",
                                          token: AppGlobal.token);
                                    }
                                    // if (widget.isFromPublicGallery) {
                                    //   commentModal.getImageDetailByIndex(
                                    //       imageId: postModel
                                    //           .publicGalleryResponseModel!
                                    //           .gal[widget.currentIndex]
                                    //           .id,
                                    //       token: AppGlobal.token,
                                    //       context: context);
                                    // }
                                    // else {
                                    //   commentModal.getImageDetailByIndex(
                                    //       imageId: postModel
                                    //           .allMyUploadResponseModel!
                                    //           .gal[widget.currentIndex]
                                    //           .id,
                                    //       token: AppGlobal.token,
                                    //       context: context);
                                    // }
                                  }
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: kColorPrimary,
                                ),
                              )
                            : const SizedBox(
                                width: 25,
                              )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: screenSize.width,
                    height: 40,
                    color: kColorPrimary.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  FlutterSecureStorage storage =
                                      const FlutterSecureStorage();
                                  final String? type =
                                      await storage.read(key: 'sign_type');

                                  if (postModel.publicGalleryResponseModel!
                                      .gal[widget.currentIndex].liked) {
                                    postModel.publicGalleryResponseModel!
                                        .gal[widget.currentIndex].liked = false;
                                    postModel
                                        .publicGalleryResponseModel!
                                        .gal[widget.currentIndex]
                                        .likesCount = postModel
                                            .publicGalleryResponseModel!
                                            .gal[widget.currentIndex]
                                            .likesCount -
                                        1;
                                    commentModal.refreshScreenState();
                                    commentModal
                                        .getLikeResponse(
                                            imageId: postModel
                                                .publicGalleryResponseModel!
                                                .gal[widget.currentIndex]
                                                .id,
                                            token: AppGlobal.token,
                                            context: context)
                                        .then((value) {
                                      if (commentModal.likeResponseModel !=
                                          null) {
                                        postModel
                                                .publicGalleryResponseModel!
                                                .gal[widget.currentIndex]
                                                .likesCount =
                                            commentModal.likeResponseModel!
                                                .image.likesCount;
                                        postModel
                                                .publicGalleryResponseModel!
                                                .gal[widget.currentIndex]
                                                .commentsCount =
                                            commentModal.likeResponseModel!
                                                .image.commentsCount;
                                      }
                                    });
                                  } else {
                                    postModel.publicGalleryResponseModel!
                                        .gal[widget.currentIndex].liked = true;
                                    postModel
                                        .publicGalleryResponseModel!
                                        .gal[widget.currentIndex]
                                        .likesCount = postModel
                                            .publicGalleryResponseModel!
                                            .gal[widget.currentIndex]
                                            .likesCount +
                                        1;

                                    commentModal.refreshScreenState();
                                    commentModal
                                        .getLikeResponse(
                                            imageId: postModel
                                                .publicGalleryResponseModel!
                                                .gal[widget.currentIndex]
                                                .id,
                                            token: AppGlobal.token,
                                            context: context)
                                        .then((value) {
                                      if (commentModal.likeResponseModel !=
                                          null) {
                                        postModel
                                                .publicGalleryResponseModel!
                                                .gal[widget.currentIndex]
                                                .likesCount =
                                            commentModal.likeResponseModel!
                                                .image.likesCount;
                                        postModel
                                                .publicGalleryResponseModel!
                                                .gal[widget.currentIndex]
                                                .commentsCount =
                                            commentModal.likeResponseModel!
                                                .image.commentsCount;
                                      }
                                    });
                                  }
                                },
                                child: SvgPicture.asset(
                                    "assets/icons/Icon awesome-heart.svg",
                                    color: !postModel.loading
                                        ? postModel.publicGalleryResponseModel!
                                                .gal[widget.currentIndex].liked
                                            ? kColorPrimary
                                            : Colors.grey
                                        : Colors.grey,
                                    height: 18,
                                    width: 18,
                                    semanticsLabel: ''),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                !postModel.loading
                                    ? postModel.publicGalleryResponseModel !=
                                            null
                                        ? postModel.publicGalleryResponseModel!
                                            .gal[widget.currentIndex].likesCount
                                            .toString()
                                        : '0'
                                    : '0',
                                style: const TextStyle(
                                    color: kColorPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              InkWell(
                                onTap: () async {
                                  FlutterSecureStorage storage =
                                      const FlutterSecureStorage();
                                  final String? type =
                                      await storage.read(key: 'sign_type');
                                  // if (type != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) => CommentsScreen(
                                              imageId: postModel
                                                          .publicGalleryResponseModel !=
                                                      null
                                                  ? postModel
                                                      .publicGalleryResponseModel!
                                                      .gal[widget.currentIndex]
                                                      .id
                                                      .toString()
                                                  : '',
                                              userName:
                                                  postModel.publicGalleryResponseModel !=
                                                          null
                                                      ? '${AppGlobal.userName}'
                                                      : '',
                                              imageUrl: postModel
                                                          .publicGalleryResponseModel !=
                                                      null
                                                  ? postModel
                                                      .publicGalleryResponseModel!
                                                      .gal[widget.currentIndex]
                                                      .image
                                                      .toString()
                                                  : '',
                                              title: ''))).then((value) {
                                    //if (value == true) {

                                    postModel
                                            .publicGalleryResponseModel!
                                            .gal[widget.currentIndex]
                                            .commentsCount =
                                        commentModal
                                            .viewCommentLikesResponseModel!
                                            .image
                                            .comments
                                            .length;
                                    final commentModel =
                                        Provider.of<CommentClass>(context,
                                            listen: false);

                                    // if (widget.isFromPublicGallery) {
                                    commentModal
                                        .getImageDetail(
                                            imageId: postModel
                                                .publicGalleryResponseModel!
                                                .gal[widget.currentIndex]
                                                .id,
                                            token: AppGlobal.token,
                                            context: context)
                                        .then((value) {
                                      postModel
                                              .publicGalleryResponseModel!
                                              .gal[widget.currentIndex]
                                              .commentsCount =
                                          commentModal
                                              .imageDetailsResponseModel!
                                              .gal
                                              .commentsCount;
                                      postModel
                                              .publicGalleryResponseModel!
                                              .gal[widget.currentIndex]
                                              .likesCount =
                                          commentModal
                                              .imageDetailsResponseModel!
                                              .gal
                                              .likesCount;
                                    });
                                    // }
                                    // else {
                                    //   commentModal
                                    //       .getImageDetail(
                                    //           imageId: postModel
                                    //               .allMyUploadResponseModel!
                                    //               .gal[widget.currentIndex]
                                    //               .id,
                                    //           token: AppGlobal.token,
                                    //           context: context)
                                    //       .then((value) {
                                    //     postModel
                                    //             .publicGalleryResponseModel!
                                    //             .gal[widget.currentIndex]
                                    //             .commentsCount =
                                    //         commentModal
                                    //             .imageDetailsResponseModel!
                                    //             .gal
                                    //             .commentsCount;
                                    //     postModel
                                    //             .publicGalleryResponseModel!
                                    //             .gal[widget.currentIndex]
                                    //             .likesCount =
                                    //         commentModal
                                    //             .imageDetailsResponseModel!
                                    //             .gal
                                    //             .likesCount;
                                    //   });
                                    // }
                                  });
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        "assets/icons/Icon material-message.svg",
                                        color: kColorPrimary,
                                        height: 18,
                                        width: 18,
                                        semanticsLabel: ''),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      postModel.publicGalleryResponseModel !=
                                              null
                                          ? postModel
                                              .publicGalleryResponseModel!
                                              .gal[widget.currentIndex]
                                              .commentsCount
                                              .toString()
                                          : '0',
                                      // eventModal.imageDetailsResponseModel.toString():'23',

                                      style: const TextStyle(
                                          color: kColorPrimary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        languageModel.languageResponseModel != null
                            ? languageModel
                                .languageResponseModel!.imageView.uploadGuest
                            : 'Uploaded guest',
                        style: const TextStyle(
                            color: kColorGreyText, fontSize: 14),
                      ),
                    ),
                  ),
                  postModel.publicGalleryResponseModel != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: kColorPrimary,
                                    child: CachedNetworkImage(
                                      imageUrl: postModel
                                          .publicGalleryResponseModel!
                                          .gal[widget.currentIndex]
                                          .user
                                          .photoURL,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            color: kColorPrimary,
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.account_circle_outlined,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    width: screenSize.width * 0.73,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: screenSize.width * 0.3,
                                          child: Text(
                                            postModel
                                                .publicGalleryResponseModel!
                                                .gal[widget.currentIndex]
                                                .user
                                                .username,
                                            style: const TextStyle(
                                                color: kColorBrownText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Text(
                                          postModel.publicGalleryResponseModel !=
                                                  null
                                              ? '${getTimeAgo(datefrom: postModel.publicGalleryResponseModel!.gal[widget.currentIndex].user.createdAt.toString())}'
                                              : '',
                                          style: const TextStyle(
                                              color: kColorGreyText,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider()
                            ],
                          ),
                        )
                      : const SizedBox(),
                  // SizedBox(
                  //   height: screenSize.height * 0.01,
                  // ),
                  // postModel.publicGalleryResponseModel != null
                  //     ? postModel.publicGalleryResponseModel!
                  //                 .gal[widget.currentIndex].task !=
                  //             null
                  //         ? Container(
                  //             width: screenSize.width * 0.85,
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(30),
                  //               color: kColorPrimary.withOpacity(0.1),
                  //             ),
                  //             child: Center(
                  //                 child: Padding(
                  //               padding: EdgeInsets.all(15),
                  //               child: Text(
                  //                 postModel.publicGalleryResponseModel!
                  //                     .gal[widget.currentIndex].task!.name,
                  //                 textAlign: TextAlign.center,
                  //                 style: const TextStyle(
                  //                     color: kColorBrownText, fontSize: 17),
                  //               ),
                  //             )))
                  //         : const SizedBox()
                  //     : const SizedBox(),
                ],
              ),
      ),
    );
  }
}
