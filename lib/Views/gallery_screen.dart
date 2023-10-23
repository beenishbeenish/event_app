import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:event_app/Provider/auth_class.dart';
import 'package:event_app/Provider/data_class.dart';
import 'package:event_app/Provider/events_class.dart';
import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Provider/task_provider.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Views/tasks_screen.dart';
import 'package:event_app/Views/event_profile_screen.dart';
import 'package:event_app/Views/greetings_screen.dart';
import 'package:event_app/Views/profile_screen.dart';
import 'package:event_app/Views/view_image_screen.dart';
import 'package:event_app/Widegts/alert_popup_widget.dart';
import 'package:event_app/Widegts/language_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../Widegts/video_preview_widget.dart';
import 'data_policy_screen.dart';
import 'first_info_screen.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    final eventModal = Provider.of<EventClass>(context, listen: false);
    final authModal = Provider.of<AuthClass>(context, listen: false);
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final languageModel = Provider.of<LanguageClass>(context, listen: false);
    final greetingModel = Provider.of<EventClass>(context, listen: false);
    final postModel = Provider.of<DataClass>(context, listen: false);

    postModel.currentPageNo = 0;
    Future.delayed(Duration.zero, () async {
      postModel.selectedPublicGalleryTab(
          pId: AppGlobal.pId,
          context: context,
          eventId: AppGlobal.eventId,
          selectedTab: 'Public Gallery',
          token: AppGlobal.token);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print(
            ">>>>>>>>>>>>>>Next Page ${postModel.currentPageNo}  < ${postModel.totalPages}");
        if (postModel.currentPageNo < postModel.totalPages) {
          Future.delayed(Duration.zero, () async {
            postModel.selectedPublicGalleryTab(
                pId: AppGlobal.pId,
                context: context,
                eventId: AppGlobal.eventId,
                selectedTab: postModel.isPublicGallerySelected
                    ? "Public Gallery"
                    : "My Uploads",
                token: AppGlobal.token);
          });
        }
      }
    });
  }

  dateFormate({
    required String datefrom,
  }) {
    final DateTime docDateTime = DateTime.parse(datefrom);

    return '${DateFormat('dd.MM.yyyy').format(docDateTime)}';
  }

  getGalleryImage(languageModel) async {
    //final languageModel = Provider.of<LanguageClass>(context);
    print('gallery');
    final postModel = Provider.of<DataClass>(context, listen: false);

    final greetingModel = Provider.of<EventClass>(context, listen: false);
    List<XFile>? imageFileList = [];

    final picker = ImagePicker();
    final List<XFile>? selectedImages =
        await picker.pickMultiImage(imageQuality: 50);
    // await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    // print('image...${pickedFile.toString()}');

    if (selectedImages!.isNotEmpty) {
      if (greetingModel.image!.length < 6) {
        if (selectedImages.length <= 5 && greetingModel.image!.length < 5) {
          postModel.uploadloading = true;
          imageFileList.addAll(selectedImages);
          postModel
              .getEventInfoByID(
            eventId: AppGlobal.eventId,
            uploadedMediaLength: imageFileList.length,
            context: context,
          )
              .then((value) {
            bool lessThanMediaLimit = checkMediaMaxLimit(imageFileList.length);
            print('>>>>>>>>>>>Media limit check $lessThanMediaLimit');
            if (lessThanMediaLimit == true) {
              postModel
                  .getUploadImageResponse(
                      token: AppGlobal.token,
                      eventId: AppGlobal.eventId,
                      imageAdress: imageFileList,
                      pid: AppGlobal.pId,
                      context: context)
                  .then((value) {
                postModel.uploadloading = false;
                postModel.selectedPublicGalleryTab(
                    pId: AppGlobal.pId,
                    context: context,
                    eventId: AppGlobal.eventId,
                    withoutPagination: true,
                    sizeOfNewUploadedMedia: imageFileList.length,
                    selectedTab: postModel.isPublicGallerySelected
                        ? 'Public Gallery'
                        : 'My Uploads',
                    token: AppGlobal.token);
              }).catchError((e) {
                postModel.uploadloading = false;
              });
            } else {
              postModel.uploadloading = false;

              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertPopup(
                      content: languageModel.languageResponseModel != null
                          ? languageModel
                              .languageResponseModel!.generalMessages.mediaLimit
                          : 'Media limit exceeded',
                    );
                  });
            }
          });
        } else {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertPopup(
                  content: languageModel.languageResponseModel != null
                      ? languageModel
                          .languageResponseModel!.widgetAlerts.selectMax
                      : 'Please Select maximum 5 images \nat a time.',
                );
              });
        }
      } else {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertPopup(
                content: languageModel.languageResponseModel != null
                    ? languageModel
                        .languageResponseModel!.widgetAlerts.selectMax
                    : 'Please Select maximum 5 images \nat a time.',
              );
            });
      }
    } else {
      print('No image selected.');
    }
  }

  bool checkMediaMaxLimit(int imageFileListLength) {
    final postModel = Provider.of<DataClass>(context, listen: false);
    print('Total Images: ${postModel.eventInfoByInfoIdResponse!.totalImages}');
    print(
        'Total totalVideos: ${postModel.eventInfoByInfoIdResponse!.totalVideos}');
    print('Total New Media: $imageFileListLength');
    print(
        'Total Max Media: ${postModel.eventInfoByInfoIdResponse!.event.maxMedia}');
    int totalVal = ((postModel.eventInfoByInfoIdResponse!.totalImages +
            postModel.eventInfoByInfoIdResponse!.totalVideos) +
        imageFileListLength);
    print('Total Media: $totalVal');
    if (totalVal < postModel.eventInfoByInfoIdResponse!.event.maxMedia) {
      print('>>>>>>>>>>Total Value is less than Max Media');
      return true;
    } else {
      print('>>>>>>>>>>Total Value is greater than Max Media');
      return false;
    }
  }

  getGalleryVideo() async {
    final postModel = Provider.of<DataClass>(context, listen: false);
    final languageModel = Provider.of<LanguageClass>(context, listen: false);
    List<XFile>? imageFileList = [];

    final picker = ImagePicker();
    final XFile? video = await picker.pickVideo(
      source: ImageSource.camera,
    );
    // await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    // print('image...${pickedFile.toString()}');

    if (video != null) {
      postModel.uploadloading = true;

      imageFileList.add(video);
      postModel
          .getEventInfoByID(
        eventId: AppGlobal.eventId,
        uploadedMediaLength: imageFileList.length,
        context: context,
      )
          .then((value) {
        bool lessThanMediaLimit = checkMediaMaxLimit(imageFileList.length);
        if (lessThanMediaLimit == true) {
          postModel
              .getUploadImageResponse(
                  token: AppGlobal.token,
                  eventId: AppGlobal.eventId,
                  imageAdress: imageFileList,
                  pid: AppGlobal.pId,
                  context: context)
              .then((value) {
            postModel.uploadloading = false;
            postModel.selectedPublicGalleryTab(
                pId: AppGlobal.pId,
                context: context,
                eventId: AppGlobal.eventId,
                withoutPagination: true,
                sizeOfNewUploadedMedia: imageFileList.length,
                selectedTab: postModel.isPublicGallerySelected
                    ? 'Public Gallery'
                    : 'My Uploads',
                token: AppGlobal.token);
          }).catchError((e) {
            postModel.uploadloading = false;
          });
        } else {
          postModel.uploadloading = false;

          return showDialog(
              context: context,
              builder: (context) {
                return AlertPopup(
                  content: languageModel.languageResponseModel != null
                      ? languageModel
                          .languageResponseModel!.generalMessages.mediaLimit
                      : 'Media limit exceeded',
                );
              });
        }
      });
    } else {
      print('No image selected.');
    }
  }

  getCameraImage(languageModel) async {
    //final languageModel = Provider.of<LanguageClass>(context);
    final postModel = Provider.of<DataClass>(context, listen: false);
    List<XFile>? imageFileList = [];
    final greetingModel = Provider.of<EventClass>(context, listen: false);

    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      if (greetingModel.image!.length < 6) {
        if (greetingModel.image!.length < 5) {
          postModel.uploadloading = true;
          imageFileList.add(pickedFile);

          postModel
              .getEventInfoByID(
            eventId: AppGlobal.eventId,
            uploadedMediaLength: imageFileList.length,
            context: context,
          )
              .then((value) {
            bool lessThanMediaLimit = checkMediaMaxLimit(imageFileList.length);
            if (lessThanMediaLimit == true) {
              postModel
                  .getUploadImageResponse(
                      token: AppGlobal.token,
                      eventId: AppGlobal.eventId,
                      imageAdress: imageFileList,
                      pid: AppGlobal.pId,
                      context: context)
                  .then((value) {
                postModel.uploadloading = false;

                postModel.selectedPublicGalleryTab(
                    pId: AppGlobal.pId,
                    context: context,
                    eventId: AppGlobal.eventId,
                    withoutPagination: true,
                    sizeOfNewUploadedMedia: imageFileList.length,
                    selectedTab: postModel.isPublicGallerySelected
                        ? 'Public Gallery'
                        : 'My Uploads',
                    token: AppGlobal.token);
              }).catchError((e) {
                postModel.uploadloading = false;
              });
            } else {
              postModel.uploadloading = false;
              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertPopup(
                      content: languageModel.languageResponseModel != null
                          ? languageModel
                              .languageResponseModel!.generalMessages.mediaLimit
                          : 'Media limit exceeded',
                    );
                  });
            }
          });
        } else {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertPopup(
                  content: languageModel.languageResponseModel != null
                      ? languageModel
                          .languageResponseModel!.widgetAlerts.selectMax
                      : 'Please Select maximum 5 images \nat a time.',
                );
              });
        }
      } else {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertPopup(
                content: languageModel.languageResponseModel != null
                    ? languageModel
                        .languageResponseModel!.widgetAlerts.selectMax
                    : 'Please Select maximum 5 images \nat a time.',
              );
            });
      }
      // File image = File(pickedFile.path);
      // List<XFile> stringList =
      //     (jsonDecode(pickedFile.path) as List<dynamic>).cast<XFile>();

      print('image...$pickedFile');
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final eventModal = Provider.of<EventClass>(context);
    final postModel = Provider.of<DataClass>(context);
    final authModal = Provider.of<AuthClass>(context);
    final taskProvider = Provider.of<TaskProvider>(context);
    final languageModel = Provider.of<LanguageClass>(context);

    int publicUploadLength = postModel.publicGalleryResponseModel != null
        ? postModel.publicGalleryResponseModel!.gal.length
        : 0;

    return Scaffold(
        backgroundColor: kColorBackGround,
        appBar: AppBar(
          // leading: SvgPicture.asset("assets/icons/menu.svg",
          //     color: Colors.white, height: 10, width: 10, semanticsLabel: ''),
          title: Row(
            children: [
              Text(
                postModel.isPublicGallerySelected
                    ? languageModel.languageResponseModel != null
                        ? languageModel
                            .languageResponseModel!.mobileGallery.publicGallery
                        : 'Public Gallery'
                    : languageModel.languageResponseModel != null
                        ? languageModel
                            .languageResponseModel!.mobileGallery.myGallery
                        : 'My Uploads',
                style: const TextStyle(color: Colors.white),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  postModel.currentPageNo = 0;
                  postModel.publicGalleryResponseModel = null;
                  postModel.selectedPublicGalleryTab(
                      context: context,
                      selectedTab: value,
                      pId: AppGlobal.pId,
                      token: AppGlobal.token,
                      eventId: AppGlobal.eventId);
                },
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                //padding: EdgeInsets.all(30),
                color: Colors.white,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                itemBuilder: (BuildContext context) {
                  return {
                    'Public Gallery',
                    'My Uploads',
                  }.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(
                        choice == 'My Uploads'
                            ? languageModel.languageResponseModel != null
                                ? languageModel.languageResponseModel!
                                    .mobileGallery.myGallery
                                : 'My Uploads'
                            : languageModel.languageResponseModel != null
                                ? languageModel.languageResponseModel!
                                    .mobileGallery.publicGallery
                                : 'Public Gallery',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    );
                  }).toList();
                },
              )
            ],
          ),
          backgroundColor: kColorPrimary,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: Drawer(
            child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const EventProfileScreen(title: 'Categories')));
                },
                child: Container(
                  height: screenSize.height * 0.2,
                  width: screenSize.width,
                  color: kColorPrimary,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            CircleAvatar(
                              radius: 35.0,
                              backgroundColor: Colors.white,
                              child: CachedNetworkImage(
                                memCacheHeight: 600,
                                memCacheWidth: 600,
                                imageUrl: AppGlobal.profileImage,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                      35.0,
                                    )),
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
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                  size: 35,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: screenSize.height * 0.06,
                                ),
                                Container(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    eventModal.eventResponseModel != null
                                        ? eventModal.eventResponseModel!.event!
                                            .generalInfo.eventName
                                        : '',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24),
                                    maxLines: 2,
                                  ),
                                  width: screenSize.width * 0.3,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text(
                                    eventModal.eventResponseModel != null
                                        ? dateFormate(
                                            datefrom: eventModal
                                                .eventResponseModel!
                                                .event!
                                                .generalInfo
                                                .dateFrom)
                                        : '',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.white,
                          size: 13,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: screenSize.height * 0.8,
                width: screenSize.width,
                color: kColorBackGround,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          color: kColorPrimary.withOpacity(0.3),
                          child: ListTile(
                            leading: SvgPicture.asset(
                                "assets/icons/image-gallery_icon.svg",
                                color: kColorPrimary,
                                height: 22,
                                width: 22,
                                semanticsLabel: ''),
                            title: Text(
                              languageModel.languageResponseModel != null
                                  ? languageModel.languageResponseModel!
                                      .mobileGallery.sidebarGallery
                                  : 'Gallery',
                              style: const TextStyle(
                                  color: kColorPrimary,
                                  fontWeight: FontWeight.w600),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const GalleryScreen(title: '')));
                            },
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                              "assets/icons/Icon open-task.svg",
                              color: kColorPrimary,
                              height: 18,
                              width: 18,
                              semanticsLabel: ''),
                          title: Text(
                            languageModel.languageResponseModel != null
                                ? languageModel.languageResponseModel!
                                    .mobileGallery.sidebarTasks
                                : 'Tasks',
                            style: const TextStyle(
                                color: kColorPrimary,
                                fontWeight: FontWeight.w600),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const TasksScreen(
                                            title: 'Categories')));
                          },
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                              "assets/icons/Icon feather-smile.svg",
                              color: kColorPrimary,
                              height: 18,
                              width: 18,
                              semanticsLabel: ''),
                          title: Text(
                            languageModel.languageResponseModel != null
                                ? languageModel.languageResponseModel!
                                    .mobileGallery.sidebarGreetings
                                : 'Greetings',
                            style: const TextStyle(
                                color: kColorPrimary,
                                fontWeight: FontWeight.w600),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const GreetingsScreen(title: '')));
                          },
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ListTile(
                          leading: SvgPicture.asset(
                              "assets/icons/langauge_icon.svg",
                              color: kColorPrimary,
                              height: 22,
                              width: 22,
                              semanticsLabel: ''),
                          title: Text(
                            languageModel.languageResponseModel != null
                                ? languageModel.languageResponseModel!
                                    .mobileGallery.sidebarLanguage
                                : 'Language',
                            style: const TextStyle(
                                color: kColorPrimary,
                                fontWeight: FontWeight.w600),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return LanguagePopup(
                                    onGalleryPress: () {},
                                  );
                                });
                          },
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                              "assets/icons/Path 6659.svg",
                              color: kColorPrimary,
                              height: 18,
                              width: 18,
                              semanticsLabel: ''),
                          title: Text(
                            languageModel.languageResponseModel != null
                                ? languageModel.languageResponseModel!
                                    .mobileGallery.sidebarProfile
                                : 'Profile',
                            style: const TextStyle(
                              color: kColorPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const ProfileScreen()));
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.share,
                            color: kColorPrimary,
                          ),
                          title: Text(
                            languageModel.languageResponseModel != null
                                ? languageModel.languageResponseModel!
                                    .mobileGallery.sidebarShare
                                : 'Share',
                            style: const TextStyle(
                              color: kColorPrimary,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () {
                            Share.share(
                                '${languageModel.languageResponseModel != null ? languageModel.languageResponseModel!.generalMessages.joinByCode : 'Join event by entering this six digit code '} :  ${AppGlobal.eventCode} ${languageModel.languageResponseModel != null ? languageModel.languageResponseModel!.generalMessages.on : 'on'} JSTPRTY App.',
                                subject:
                                    '${languageModel.languageResponseModel != null ? languageModel.languageResponseModel!.generalMessages.joinUs : 'Join us at '} JSTPRTY App!');
                          },
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                              "assets/icons/Group 7693.svg",
                              color: kColorPrimary,
                              height: 18,
                              width: 18,
                              semanticsLabel: ''),
                          title: Text(
                            languageModel.languageResponseModel != null
                                ? languageModel.languageResponseModel!
                                    .mobileGallery.sidebarPolicy
                                : 'Data Policy',
                            style: const TextStyle(
                              color: kColorPrimary,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DataPolicyScreen()));
                          },
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                              "assets/icons/Icon open-account-logout.svg",
                              color: kColorPrimary,
                              height: 18,
                              width: 18,
                              semanticsLabel: ''),
                          title: Text(
                            languageModel.languageResponseModel != null
                                ? languageModel.languageResponseModel!
                                    .mobileGallery.sidebarLogout
                                : 'Logout',
                            style: const TextStyle(
                                color: kColorPrimary,
                                fontWeight: FontWeight.w600),
                          ),
                          onTap: () async {
                            FlutterSecureStorage storage =
                                const FlutterSecureStorage();

                            ///Todo: social login
                            // final String? type= await storage.read(key: 'sign_type');
                            // if(type=='google')
                            // {
                            //   await FirebaseAuth.instance.signOut().then((value){
                            //     print('Signout Succesfull');
                            //   }).catchError((e){
                            //     print('Signout error....$e');
                            //
                            //   });
                            //
                            // }
                            await storage.deleteAll();
                            AppGlobal.token = '';
                            AppGlobal.eventId = '';
                            AppGlobal.pId = '';
                            authModal.authModel = null;
                            taskProvider.taskCompletedDetailsResponseModel =
                                null;
                            taskProvider.taskCompletedResponseModel = null;
                            taskProvider.randomTaskResponseModel = null;

                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const FirstInfoScreen()));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: postModel.uploadloading
            ? Container(
                margin: const EdgeInsets.only(bottom: 14),
                child: FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: kColorPrimary,
                  child: Container(
                    // padding: EdgeInsets.only(left: screenSize.width*0.05),
                    child: SpinKitFadingCircle(
                      size: 30,
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            : Container(
                // padding: EdgeInsets.only(left: screenSize.width*0.05),
                alignment: Alignment.center,
                child: CircularMenu(
                    toggleButtonColor: kColorPrimary,
                    alignment: Alignment.bottomCenter,
                    items: [
                      CircularMenuItem(
                        badgeTextColor: Colors.red,
                        iconSize: MediaQuery.of(context).size.height * 0.03,
                        badgeLabel: 'Hello',
                        onTap: () {
                          authModal
                              .getlAllChecksInfo(
                                  token: AppGlobal.token,
                                  eventId: AppGlobal.eventId,
                                  context: context)
                              .then((e) {
                            if ((authModal.checksResponseModel?.mediaType ==
                                        'image') ==
                                    true ||
                                (authModal.checksResponseModel?.mediaType ==
                                        'image/video') ==
                                    true) {
                              getCameraImage(languageModel);
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertPopup(
                                      title:
                                          languageModel.languageResponseModel !=
                                                  null
                                              ? languageModel
                                                  .languageResponseModel!
                                                  .generalMessages
                                                  .sorry
                                              : 'Sorry',
                                      icon: false,
                                      content: languageModel
                                                  .languageResponseModel !=
                                              null
                                          ? languageModel.languageResponseModel!
                                              .generalMessages.uploadNotAv
                                          : 'Your can not upload images to this event',
                                    );
                                  });
                            }
                          });
                        },
                        icon: Icons.camera_alt,
                        color: kColorPrimary,
                      ),
                      CircularMenuItem(
                        iconSize: MediaQuery.of(context).size.height * 0.03,
                        onTap: () {
                          authModal
                              .getlAllChecksInfo(
                                  token: AppGlobal.token,
                                  eventId: AppGlobal.eventId,
                                  context: context)
                              .then((e) {
                            if ((authModal.checksResponseModel?.mediaType ==
                                        'image') ==
                                    true ||
                                (authModal.checksResponseModel?.mediaType ==
                                        'image/video') ==
                                    true) {
                              getGalleryImage(languageModel);
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertPopup(
                                      title:
                                          languageModel.languageResponseModel !=
                                                  null
                                              ? languageModel
                                                  .languageResponseModel!
                                                  .generalMessages
                                                  .sorry
                                              : 'Sorry',
                                      icon: false,
                                      content: languageModel
                                                  .languageResponseModel !=
                                              null
                                          ? languageModel.languageResponseModel!
                                              .generalMessages.uploadNotAv
                                          : 'Your can not upload images to this event',
                                    );
                                  });
                            }
                          });
                        },
                        icon: Icons.filter,
                        color: kColorPrimary,
                      ),
                      CircularMenuItem(
                        iconSize: MediaQuery.of(context).size.height * 0.03,
                        onTap: () {
                          authModal
                              .getlAllChecksInfo(
                                  token: AppGlobal.token,
                                  eventId: AppGlobal.eventId,
                                  context: context)
                              .then((e) {
                            if ((authModal.checksResponseModel?.mediaType ==
                                        'video') ==
                                    true ||
                                (authModal.checksResponseModel?.mediaType ==
                                        'image/video') ==
                                    true) {
                              getGalleryVideo();
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertPopup(
                                      title:
                                          languageModel.languageResponseModel !=
                                                  null
                                              ? languageModel
                                                  .languageResponseModel!
                                                  .generalMessages
                                                  .sorry
                                              : 'Sorry',
                                      icon: false,
                                      content: languageModel
                                                  .languageResponseModel !=
                                              null
                                          ? languageModel.languageResponseModel!
                                              .generalMessages.vidUploadNotAv
                                          : 'Your can not upload videos to this event',
                                    );
                                  });
                            }
                          });
                        },
                        icon: Icons.videocam,
                        color: kColorPrimary,
                      ),
                      CircularMenuItem(
                        iconSize: MediaQuery.of(context).size.height * 0.03,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const TasksScreen(title: 'Categories')));
                        },
                        icon: Icons.format_list_bulleted,
                        color: kColorPrimary,
                      ),
                    ]),
              ),
        body: postModel.loading
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
            : publicUploadLength == 0
                ? (postModel.isPublicGallerySelected == false &&
                        postModel.publicGalleryResponseModel!.images.isEmpty)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenSize.height * 0.15,
                            ),
                            SvgPicture.asset("assets/icons/Group 7589.svg",
                                semanticsLabel: ''),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: Text(
                              languageModel.languageResponseModel != null
                                  ? languageModel.languageResponseModel!
                                      .generalMessages.noUploads
                                  : 'No Meida Uploaded',
                              style: const TextStyle(
                                  color: kColorPrimary, fontSize: 20),
                            )),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenSize.height * 0.1,
                            ),
                            SvgPicture.asset("assets/icons/Group 7589.svg",
                                semanticsLabel: ''),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: Text(
                              languageModel.languageResponseModel != null
                                  ? languageModel.languageResponseModel!
                                      .generalMessages.galleryPublic
                                  : 'Gallery not public yet',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: kColorPrimary, fontSize: 20),
                            )),
                          ],
                        ),
                      )
                : Container(
                    width: screenSize.width,
                    height: screenSize.height,
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      child: Column(
                        children: [
                          GridView.builder(
                            itemCount:
                                postModel.publicGalleryResponseModel != null
                                    ? postModel.publicGalleryResponseModel!
                                        .images.length
                                    : 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 30 / 30,
                                    crossAxisSpacing: 1,
                                    crossAxisCount: 3),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 2),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext
                                                      contextVar) =>
                                                  ImageViewScreen(
                                                      currentIndex: index,
                                                      currentPage: 0,
                                                      imageId: postModel
                                                          .publicGalleryResponseModel!
                                                          .gal[index]
                                                          .id,
                                                      tempScreenWidth:
                                                          screenSize.width,
                                                      isFromPublicGallery: postModel
                                                          .isPublicGallerySelected))).then(
                                          (value) {
                                        if (postModel
                                            .publicGalleryResponseModel!
                                            .images
                                            .isEmpty) {
                                          postModel
                                              .publicGalleryResponseModel!.gal
                                              .clear();
                                          // postModel.publicGalleryResponseModel =
                                          //     null;
                                        }
                                      });
                                    },
                                    child: Container(
                                      // color:
                                      //     Colors.transparent.withOpacity(0.1)
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.transparent
                                                .withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0, 0),
                                          )
                                        ],
                                      ),
                                      child: postModel
                                                  .publicGalleryResponseModel!
                                                  .gal[index]
                                                  .type ==
                                              'application/mp4'
                                          ? Stack(children: [
                                              Container(
                                                  width: screenSize.height * 1,
                                                  // height: 130.0,
                                                  // color: Colors.black,
                                                  child: VideoPlayerWidget(
                                                      url: postModel
                                                                  .publicGalleryResponseModel !=
                                                              null
                                                          ? postModel
                                                              .publicGalleryResponseModel!
                                                              .images[index]
                                                          : '',
                                                      mediaTypeisLocalVideo:
                                                          false)),
                                              const Positioned(
                                                  child: Center(
                                                      child: Icon(
                                                Icons
                                                    .play_circle_outline_outlined,
                                                color: kColorPrimary,
                                                size: 35,
                                              )))
                                            ])
                                          : CachedNetworkImage(
                                              // height: 100,
                                              // width: 100,
                                              // fit: BoxFit.cover,
                                              imageUrl: postModel
                                                          .publicGalleryResponseModel !=
                                                      null
                                                  ? postModel
                                                      .publicGalleryResponseModel!
                                                      .images[index]
                                                  : '',
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
                                                    color: Colors.grey.shade200,
                                                  ),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Shimmer.fromColors(
                                                direction: ShimmerDirection.ttb,
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                    Colors.grey.shade100,
                                                enabled: true,
                                                child: Container(
                                                  color: Colors.grey.shade200,
                                                ),
                                              ),
                                            ),
                                    )),
                              );
                            },
                          ),
                          SizedBox(
                            height: screenSize.height * 0.15,
                          )
                        ],
                      ),
                    ),
                  ));
  }
}
