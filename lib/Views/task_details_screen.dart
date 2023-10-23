import 'package:better_video_player/better_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:event_app/Provider/events_class.dart';
import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Provider/task_provider.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Views/comments_screen.dart';
import 'package:event_app/Views/tasks_complete_screen.dart';
import 'package:event_app/Views/view_media_screen.dart';
import 'package:event_app/Widegts/submit_popup_widget.dart';
import 'package:event_app/Widegts/warning_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:toast/toast.dart';

import '../Widegts/alert_popup_widget.dart';
import 'profile_screen.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({Key? key, required this.title, required this.taskId})
      : super(key: key);

  final String title;
  final String taskId;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  int _current = 1;
  List<String> variantPic = ['dasd', 'adasd', 'adasd'];
  late BetterVideoPlayerController controller;

  final _controller = PageController(
    initialPage: 0,
  );
  int _currentPag = 0;

  @override
  void initState() {
    ToastContext().init(context);
    print("Task id: ${widget.taskId}");
    print("Token: ${AppGlobal.token}");

    controller = BetterVideoPlayerController();

    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.taskCompletedDetailsResponseModel = null;

    Future.delayed(Duration.zero, () async {
      taskProvider.completedTaskDetails(
          context: context,
          pId: AppGlobal.pId,
          token: AppGlobal.token,
          taskId: widget.taskId);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    //Provider.of<TaskProvider>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contextParent) {
    var screenSize = MediaQuery.of(contextParent).size;
    final eventModal = Provider.of<EventClass>(contextParent);
    final taskProvider = Provider.of<TaskProvider>(contextParent);
    final eventModel = Provider.of<EventClass>(contextParent);

    final languageModel = Provider.of<LanguageClass>(contextParent);

    return Scaffold(
      backgroundColor: kColorBackGround,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(contextParent);
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: Text(
          languageModel.languageResponseModel != null
              ? languageModel.languageResponseModel!.mobileTasks.taskDetails
              : 'Task Details',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: kColorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: taskProvider.downloading
            ? SimpleCircularProgressBar(
                size: 40,
                valueNotifier: ValueNotifier(taskProvider.downloadingPercent),
                backColor: kColorBackGround,
                backStrokeWidth: 10,
                progressColors: [kColorPrimary],
                fullProgressColor: kColorPrimary,
                progressStrokeWidth: 5,
                mergeMode: false,
                onGetText: (double value) {
                  return Text(
                    '${taskProvider.downloadingPercent.toInt()}%',
                    style: const TextStyle(fontSize: 10),
                  );
                },
              )
            : Container(),
      ),
      body: taskProvider.loading
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
          : Container(
              height: screenSize.height,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: taskProvider.taskCompletedDetailsResponseModel !=
                            null
                        ? PageView(
                            controller: _controller,
                            allowImplicitScrolling: true,
                            children: taskProvider
                                .taskCompletedDetailsResponseModel!.images
                                .map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ViewMediaScreen(
                                                          mediaURl: i.image,
                                                          mediaType: i.type,
                                                        )));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: kColorPrimary,
                                            ),
                                            child: i.type == 'application/mp4'
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: AspectRatio(
                                                      aspectRatio: 16.0 / 10.8,
                                                      child: BetterVideoPlayer(
                                                        controller: controller,
                                                        configuration:
                                                            BetterVideoPlayerConfiguration(
                                                          autoPlay: false,
                                                          placeholder:
                                                              Image.network(
                                                            i.image,
                                                            fit: BoxFit.contain,
                                                          ),
                                                          // controls: const _CustomVideoPlayerControls(),
                                                        ),
                                                        dataSource:
                                                            BetterVideoPlayerDataSource(
                                                          BetterVideoPlayerDataSourceType
                                                              .network,
                                                          i.image,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      // color: Colors.black,

                                                      height:
                                                          screenSize.height *
                                                              0.38,
                                                      width: screenSize.width,
                                                      fit: BoxFit.cover,
                                                      imageUrl: i.image,
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  downloadProgress) =>
                                                              SizedBox(
                                                        width: 100.0,
                                                        height: 100.0,
                                                        child:
                                                            Shimmer.fromColors(
                                                          direction:
                                                              ShimmerDirection
                                                                  .ttb,
                                                          baseColor: Colors
                                                              .grey.shade300,
                                                          highlightColor: Colors
                                                              .grey.shade100,
                                                          enabled: true,
                                                          child: Container(
                                                            color: Colors
                                                                .grey.shade200,
                                                          ),
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Container(
                                                              color:
                                                                  kColorPrimary,
                                                              child: const Icon(
                                                                  Icons.error)),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      // variantPic.length > 1
                                      //     ? DotsIndicator(
                                      //         dotsCount: taskProvider
                                      //                     .taskCompletedDetailsResponseModel !=
                                      //                 null
                                      //             ? taskProvider
                                      //                 .taskCompletedDetailsResponseModel!
                                      //                 .images
                                      //                 .length
                                      //             : 1,
                                      //         position:
                                      //             eventModal.currentPage.toDouble(),
                                      //         decorator: const DotsDecorator(
                                      //           spacing: EdgeInsets.all(6.0),
                                      //           activeColor: kColorPrimary,
                                      //         ))
                                      //     : const SizedBox(),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              taskProvider.downloadFile(i.image,
                                                  type: i.type,
                                                  contextVar: contextParent);
                                              // _onImageDownloadButton(
                                              //     url: i.image.toString());
                                            },
                                            child: SvgPicture.asset(
                                                "assets/icons/Group 7689.svg",
                                                height: 20,
                                                width: 20,
                                                semanticsLabel: ''),
                                          ),
                                          SizedBox(
                                            width: screenSize.width * 0.2,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await taskProvider.deleteTask(
                                                  taskId: widget.taskId,
                                                  context: contextParent);
                                              //
                                              // Navigator.pushReplacement(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (BuildContext context) =>
                                              //          const TasksScreen(
                                              //             title: '',)));

                                              if (taskProvider
                                                      .deleteResponse!.status ==
                                                  true) {
                                                taskProvider
                                                        .randomTaskResponseModel =
                                                    null;
                                                // taskProvider.randomTasksSelected = false;
                                                // Navigator.pop(context);
                                                Navigator.of(contextParent)
                                                    .pop(true);

                                                showDialog(
                                                    context: contextParent,
                                                    builder:
                                                        (BuildContext context) {
                                                      return SubmitPopup(
                                                        title: languageModel
                                                                    .languageResponseModel !=
                                                                null
                                                            ? languageModel
                                                                    .languageResponseModel!
                                                                    .mobileTasks
                                                                    .taskDeleted +
                                                                '!'
                                                            : 'Task deleted!',
                                                        icon: true,
                                                        iconname: Icons
                                                            .check_circle_rounded,
                                                        content: languageModel
                                                                    .languageResponseModel !=
                                                                null
                                                            ? languageModel
                                                                .languageResponseModel!
                                                                .mobileTasks
                                                                .deletedMsg
                                                            : 'Task deleted successfully.',
                                                      );
                                                    });
                                              }
                                            },
                                            child: SvgPicture.asset(
                                                "assets/icons/Group 7688.svg",
                                                height: 20,
                                                width: 20,
                                                semanticsLabel: ''),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      Container(
                                        width: screenSize.width,
                                        height: 40,
                                        color: kColorPrimary.withOpacity(0.1),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      if (i.isLiked == true) {
                                                        // taskProvider.updateLikes(_currentPag);

                                                        i.likesCount - 1;

                                                        taskProvider
                                                            .getLikeResponse(
                                                                imageId: i.id,
                                                                index:
                                                                    _currentPag,
                                                                token: AppGlobal
                                                                    .token,
                                                                context:
                                                                    context);
                                                      } else {
                                                        // taskProvider.updateLikes(_currentPag);
                                                        // taskProvider.updateLikes(_currentPag);

                                                        i.likesCount + 1;

                                                        // taskProvider.isliked[_currentPag]=true;
                                                        taskProvider
                                                            .getLikeResponse(
                                                                imageId: i.id,
                                                                index:
                                                                    _currentPag,
                                                                token: AppGlobal
                                                                    .token,
                                                                context:
                                                                    context);

                                                        // commentModal.imageDetailsResponseModel!.gal.likesCount +1;
                                                        // commentModal.getLikeResponse(imageId: widget.imageId,token: AppGlobal.token,context:context);

                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                        "assets/icons/Icon awesome-heart.svg",
                                                        color: taskProvider
                                                                    .isliked[
                                                                _currentPag]
                                                            ? kColorPrimary
                                                            : Colors.grey,
                                                        height: 18,
                                                        width: 18,
                                                        semanticsLabel: ''),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    i.likesCount.toString(),
                                                    style: const TextStyle(
                                                        color: kColorPrimary,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    width: 25,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  CommentsScreen(
                                                                      imageId: i
                                                                          .id
                                                                          .toString(),
                                                                      userName:
                                                                          AppGlobal
                                                                              .userName!,
                                                                      imageUrl: i
                                                                          .image
                                                                          .toString(),
                                                                      title:
                                                                          'Categories'))).then(
                                                          (value) async {
                                                        await taskProvider
                                                            .completedTaskDetails(
                                                                context:
                                                                    context,
                                                                pId: AppGlobal
                                                                    .pId,
                                                                token: AppGlobal
                                                                    .token,
                                                                taskId: widget
                                                                    .taskId);
                                                      });

                                                      // Navigator.push(
                                                      // context,
                                                      // MaterialPageRoute(
                                                      // builder: (BuildContext context) =>
                                                      //  CommentsScreen(
                                                      // imageId: i.id.toString(),
                                                      // title: 'Categories',imageUrl: i.image.toString(),
                                                      // userName: '${'Anomyus'+ i.uid.toString().substring(0,5))));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            "assets/icons/Icon material-message.svg",
                                                            color:
                                                                kColorPrimary,
                                                            height: 18,
                                                            width: 18,
                                                            semanticsLabel: ''),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          i.commentsCount
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color:
                                                                  kColorPrimary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                      SizedBox(
                                        height: screenSize.height * 0.025,
                                      ),
                                    ],
                                  );
                                },
                              );
                            }).toList(),
                            onPageChanged: (index) {
                              eventModal.updatePageIndex(index);
                              _currentPag = index;
                            })
                        : const SizedBox(),
                  ),

                  Container(
                      width: screenSize.width * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: kColorPrimary.withOpacity(0.1),
                      ),
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          widget.title.toString(),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: kColorBrownText, fontSize: 17),
                        ),
                      ))),
                  SizedBox(
                    height: screenSize.height * 0.1,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                      child: taskProvider.downloading
                          ? const SizedBox()
                          : const SizedBox()),
                  SizedBox(
                    height: screenSize.height * 0.035,
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),

                  //  SizedBox(
                  //   height: screenSize.height*0.02,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SvgPicture.asset("assets/icons/Group 7689.svg",
                  //         height: 20, width: 20, semanticsLabel: ''),
                  //     SizedBox(
                  //       width: screenSize.width * 0.2,
                  //     ),
                  //     SvgPicture.asset("assets/icons/Group 7688.svg",
                  //         height: 20, width: 20, semanticsLabel: ''),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Container(
                  //   width: screenSize.width,
                  //   height: 40,
                  //   color: kColorPrimary.withOpacity(0.1),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 20),
                  //     child: Row(
                  //       children: [
                  //         Row(
                  //           children: [
                  //             SvgPicture.asset("assets/icons/Icon awesome-heart.svg",
                  //                 color: kColorPrimary,
                  //                 height: 18,
                  //                 width: 18,
                  //                 semanticsLabel: ''),
                  //             const SizedBox(
                  //               width: 5,
                  //             ),
                  //             const Text(
                  //               '40',
                  //               style: TextStyle(
                  //                   color: kColorPrimary, fontWeight: FontWeight.bold),
                  //             ),
                  //             const SizedBox(
                  //               width: 25,
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //
                  //                 //TODO:task details comment.
                  //                 // Navigator.push(
                  //                 //     context,
                  //                 //     MaterialPageRoute(
                  //                 //         builder: (BuildContext context) =>
                  //                 //             const CommentsScreen(
                  //                 //                 title: 'Categories')));
                  //               },
                  //               child: Row(
                  //                 children: [
                  //                   SvgPicture.asset(
                  //                       "assets/icons/Icon material-message.svg",
                  //                       color: kColorPrimary,
                  //                       height: 18,
                  //                       width: 18,
                  //                       semanticsLabel: ''),
                  //                   SizedBox(
                  //                     width: 5,
                  //                   ),
                  //                   Text(
                  //                     '23',
                  //                     style: TextStyle(
                  //                         color: kColorPrimary,
                  //                         fontWeight: FontWeight.bold),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  //  SizedBox(
                  //   height: screenSize.height*0.03,
                  // ),
                  // Container(
                  //     width: screenSize.width * 0.85,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(30),
                  //       color: kColorPrimary.withOpacity(0.1),
                  //     ),
                  //     child: const Center(
                  //         child: Padding(
                  //       padding: EdgeInsets.all(15),
                  //       child: Text(
                  //         'Add Pictures with Bride Family',
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(color: kColorBrownText, fontSize: 17),
                  //       ),
                  //     ))),
                  // SizedBox(
                  //   height: screenSize.height * 0.1,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  //   child: InkWell(
                  //     onTap: () {
                  //       Navigator.pop(context);
                  //     },
                  //     child: Container(
                  //         width: screenSize.width,
                  //         height: 50,
                  //         decoration: BoxDecoration(
                  //             border: Border.all(
                  //               color: kColorPrimary,
                  //               width: 2.0,
                  //             ),
                  //             borderRadius: BorderRadius.circular(100),
                  //             color: kColorPrimary,
                  //             boxShadow: const [
                  //               BoxShadow(
                  //                 color: Colors.black26,
                  //                 spreadRadius: 1,
                  //                 blurRadius: 2,
                  //                 offset: Offset(0, 4),
                  //               )
                  //             ]),
                  //         child: const Padding(
                  //           padding: EdgeInsets.symmetric(horizontal: 10),
                  //           child: Center(
                  //               child: Text(
                  //             'Done',
                  //             style: TextStyle(color: Colors.white, fontSize: 17),
                  //           )),
                  //         )),
                  //   ),
                  // ),
                ],
              ),
            ),
    );
  }
}
