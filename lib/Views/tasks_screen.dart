import 'dart:io';
import 'package:better_video_player/better_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/Provider/auth_class.dart';
import 'package:event_app/Provider/data_class.dart';
import 'package:event_app/Provider/events_class.dart';
import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Provider/task_provider.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Views/event_profile_screen.dart';
import 'package:event_app/Views/first_info_screen.dart';
import 'package:event_app/Views/greetings_screen.dart';
import 'package:event_app/Views/profile_screen.dart';
import 'package:event_app/Views/tasks_complete_screen.dart';
import 'package:event_app/Widegts/image_popup_widget.dart';
import 'package:event_app/Widegts/language_widget.dart';
import 'package:event_app/Widegts/submit_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../Widegts/alert_popup_widget.dart';
import 'data_policy_screen.dart';
import 'gallery_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late BetterVideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = BetterVideoPlayerController();
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    taskProvider.checkTaskCompleteResponseModel = null;
    taskProvider.randomTaskResponseModel = null;

    taskProvider
        .checkIsRandomTasksCompleted(
            eventId: AppGlobal.eventId,
            context: context,
            token: AppGlobal.token)
        .then((value) {
      if (taskProvider.checkTaskCompleteResponseModel!.tasksAvailable) {
        taskProvider
            .selectedRandomTask(
              context: context,
              token: AppGlobal.token,
              eventId: AppGlobal.eventId,
            )
            .then((value) {});
      }
    });
    super.initState();
  }

  dateFormat({
    required String datefrom,
  }) {
    final DateTime docDateTime = DateTime.parse(datefrom);

    return '${DateFormat('dd.MM.yyyy').format(docDateTime)}';
  }

  getGalleryImage(languageModel) async {
    print('gallery');
    final eventModal = Provider.of<EventClass>(context, listen: false);
    //final languageModel = Provider.of<LanguageClass>(context,listen: false);

    List<XFile>? imageFileList = [];

    final picker = ImagePicker();
    final XFile? selectedImages =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    // await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    // print('image...${pickedFile.toString()}');

    if (selectedImages != null) {
      if (eventModal.image!.isNotEmpty) {
        eventModal.image!.clear();
      }
      imageFileList.add(selectedImages);
      eventModal.getImageAddress(imageFileList);
    } else {
      print('No image selected.');
    }
  }

  getGalleryVideo({languageModel}) async {
    print('gallery');
    final eventModal = Provider.of<EventClass>(context, listen: false);

    List<XFile>? imageFileList = [];

    final picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    // await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    // print('image...${pickedFile.toString()}');
    print('videos......${video?.path}');
    if (video != null) {
      // postModel.uploadloading=true;
      controller = BetterVideoPlayerController();
      imageFileList.add(video);
      eventModal.getImageAddress(imageFileList);
    } else {
      print('No video selected.');
    }
  }

  getCameraImage(languageModel) async {
    List<XFile>? imageFileList = [];
    final eventModal = Provider.of<EventClass>(context, listen: false);
    //final languageModel = Provider.of<LanguageClass>(context,listen: false);

    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      if (eventModal.image!.length < 6 && eventModal.image!.length < 5) {
        if (imageFileList.length <= 5) {
          print(
            'Images.. less than 5',
          );
          if (eventModal.image!.isNotEmpty) {
            eventModal.image!.clear();
          }
          imageFileList.add(pickedFile);
          eventModal.getImageAddress(imageFileList);
          print("Image List Length:" + imageFileList.length.toString());
        } else {
          // return  showDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return AlertPopup(
          //         title: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.Warning: "Warning!",
          //         content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.pleaseUpload5imagesAtatime: 'Please Select maximum 5 images \nat a time.',
          //       );
          //     });
        }
      } else {
        // return showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertPopup(
        //         title: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.Warning: "Warning!",
        //         content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.pleaseUpload5imagesAtatime: 'Please Select maximum 5 images \nat a time.',
        //       );
        //     });
      }
      // File image = File(pickedFile.path);
      // List<XFile> stringList =
      //     (jsonDecode(pickedFile.path) as List<dynamic>).cast<XFile>();

      print('image...${pickedFile}');
    } else {
      print('No image selected.');
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var appBarHeight = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final eventModel = Provider.of<EventClass>(context);
    final authModal = Provider.of<AuthClass>(context);
    final taskProvider = Provider.of<TaskProvider>(context);
    final postModel = Provider.of<DataClass>(context);
    final languageModel = Provider.of<LanguageClass>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kColorBackGround,
      appBar: AppBar(
        title: Text(
          languageModel.languageResponseModel != null
              ? languageModel.languageResponseModel!.mobileGallery.sidebarTasks
              : 'Tasks',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          //list if widget in appbar actions
          PopupMenuButton(
            icon: const Icon(Icons
                .more_vert_outlined), //don't specify icon if you want 3 dot menu
            offset: Offset(0.0, MediaQuery.of(context).size.height * 0.06),
            // color: Colors.blue,
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                onTap: () => Future(
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const TasksCompleteScreen(title: '')),
                  ),
                ),
                child: Text(
                  languageModel.languageResponseModel != null
                      ? languageModel
                          .languageResponseModel!.mobileTasks.viewCompleted
                      : 'View Task Completed',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
            onSelected: (item) => {print(item)},
          ),
        ],
        backgroundColor: kColorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: eventModel.image!.isEmpty &&
            (taskProvider.randomTaskResponseModel != null &&
                taskProvider.randomTaskResponseModel!.task != null),
        child: FloatingActionButton(
          backgroundColor: kColorPrimary,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ImagePopup(
                    onVideoPress: () {
                      getGalleryVideo(languageModel: languageModel);
                    },
                    onCameraPress: () {
                      getCameraImage(languageModel);
                    },
                    onGalleryPress: () {
                      getGalleryImage(languageModel);
                    },
                  );
                });
            // getImage();
          },
          child: SvgPicture.asset("assets/icons/Icon ionic-ios-add.svg",
              color: Colors.white, semanticsLabel: ''),
        ),
      ),
      drawer: Drawer(
          child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const EventProfileScreen(title: '')));
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
                            imageUrl: AppGlobal.profileImage,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => ClipRRect(
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
                            errorWidget: (context, url, error) => const Icon(
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
                                eventModel.eventResponseModel != null
                                    ? eventModel.eventResponseModel!.event!
                                        .generalInfo.eventName
                                    : '',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 24),
                                maxLines: 2,
                              ),
                              width: screenSize.width * 0.4,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              eventModel.eventResponseModel != null
                                  ? dateFormat(
                                      datefrom: eventModel.eventResponseModel!
                                          .event!.generalInfo.dateFrom)
                                  : '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
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
                                      const GalleryScreen(
                                          title: 'Categories')));
                        },
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                    Container(
                      color: kColorPrimary.withOpacity(0.3),
                      child: ListTile(
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
                        onTap: () {},
                      ),
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
                            ? languageModel.languageResponseModel!.mobileGallery
                                .sidebarGreetings
                            : 'Greetings',
                        style: const TextStyle(
                            color: kColorPrimary, fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const GreetingsScreen(
                                        title: 'Categories')));
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
                            ? languageModel.languageResponseModel!.mobileGallery
                                .sidebarLanguage
                            : 'Language',
                        style: const TextStyle(
                            color: kColorPrimary, fontWeight: FontWeight.w600),
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
                      leading: SvgPicture.asset("assets/icons/Path 6659.svg",
                          color: kColorPrimary,
                          height: 18,
                          width: 18,
                          semanticsLabel: ''),
                      title: Text(
                        languageModel.languageResponseModel != null
                            ? languageModel.languageResponseModel!.mobileGallery
                                .sidebarProfile
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
                            ? languageModel.languageResponseModel!.mobileGallery
                                .sidebarShare
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
                      leading: SvgPicture.asset("assets/icons/Group 7693.svg",
                          color: kColorPrimary,
                          height: 18,
                          width: 18,
                          semanticsLabel: ''),
                      title: Text(
                        languageModel.languageResponseModel != null
                            ? languageModel.languageResponseModel!.mobileGallery
                                .sidebarPolicy
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
                            ? languageModel.languageResponseModel!.mobileGallery
                                .sidebarLogout
                            : 'Logout',
                        style: const TextStyle(
                            color: kColorPrimary, fontWeight: FontWeight.w600),
                      ),
                      onTap: () async {
                        FlutterSecureStorage storage =
                            const FlutterSecureStorage();

                        ///todo: Socail login
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
                        taskProvider.taskCompletedDetailsResponseModel = null;
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
      )),
      body: taskProvider.loading
          ? Center(
              child: Container(
                child: SpinKitFadingCircle(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kColorPrimary,
                      ),
                    );
                  },
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height*0.025,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.025,
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.075,
                            bottom: MediaQuery.of(context).size.width * 0.05,
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            decoration: BoxDecoration(
                                color: Color(0xffF8F1F1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                (taskProvider.randomTaskResponseModel != null &&
                                        taskProvider.randomTaskResponseModel!
                                                .task !=
                                            null)
                                    ? taskProvider
                                        .randomTaskResponseModel!.task!.name
                                    : languageModel.languageResponseModel !=
                                            null
                                        ? languageModel.languageResponseModel!
                                            .mobileTasks.noTask
                                        : 'No Task Available',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kColorBrownText,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.075,
                                ),
                              ),
                            )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.41,
                            right: MediaQuery.of(context).size.width * 0.42,
                          ),
                          child: InkWell(
                            onTap: () {
                              // if (!(taskProvider.randomTaskResponseModel ==
                              //         null ||
                              //     taskProvider.randomTaskResponseModel!.task ==
                              //         null)) {
                              // taskProvider.buttonColorChange();

                              taskProvider
                                  .checkIsRandomTasksCompleted(
                                      eventId: AppGlobal.eventId,
                                      context: context,
                                      token: AppGlobal.token)
                                  .then((value) {
                                if (taskProvider.checkTaskCompleteResponseModel!
                                    .tasksAvailable) {
                                  taskProvider
                                      .selectedRandomTask(
                                        context: context,
                                        token: AppGlobal.token,
                                        eventId: AppGlobal.eventId,
                                      )
                                      .then((value) {});
                                }
                              });
                              //}
                            },
                            child: (taskProvider.loading)
                                ? Container(
                                    // color: kColorPrimary,
                                    child: SpinKitFadingCircle(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return DecoratedBox(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: kColorPrimary,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: (taskProvider
                                                          .randomTaskResponseModel !=
                                                      null &&
                                                  taskProvider
                                                          .randomTaskResponseModel!
                                                          .task !=
                                                      null)
                                              ? kColorPrimary
                                              : Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                            "assets/icons/Icon feather-refresh-cw.svg",
                                            // height: 50,
                                            color: Colors.white,
                                            semanticsLabel: ''),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: SingleChildScrollView(
                      child: Container(
                        height: 100,
                        width: 90,
                        child: Center(
                          child: GridView.builder(
                            //itemCount: eventModel.image!.length+1 ,
                            itemCount: eventModel.image!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 25 / 26,
                                    crossAxisSpacing: 8,
                                    crossAxisCount: 1),
                            itemBuilder: (BuildContext context, int index) {
                              return Center(
                                child: InkWell(
                                  onTap: () {},
                                  child: Stack(
                                    children: [
                                      Stack(
                                        children: [
                                          eventModel.image![index].path
                                                      .contains('.mp4') ||
                                                  eventModel.image![index].path
                                                      .contains('.MOV')
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: kColorPrimary,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.black,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: BetterVideoPlayer(
                                                      controller: controller,
                                                      configuration:
                                                          BetterVideoPlayerConfiguration(
                                                              autoPlay: false,
                                                              looping: false,
                                                              controls:
                                                                  BetterVideoPlayerControls(
                                                                isFullScreen:
                                                                    false,
                                                              )
                                                              // controls: const _CustomVideoPlayerControls(),
                                                              ),
                                                      dataSource:
                                                          BetterVideoPlayerDataSource(
                                                              BetterVideoPlayerDataSourceType
                                                                  .file,
                                                              eventModel
                                                                  .image![index]
                                                                  .path),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: kColorPrimary,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    //color: Colors.black,
                                                    image: DecorationImage(
                                                      image: FileImage(
                                                        File(eventModel
                                                            .image![index]
                                                            .path),
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )
                                        ],
                                        alignment: Alignment.center,
                                      ),
                                      Positioned(
                                          right: -5,
                                          top: -4,
                                          child: IconButton(
                                              onPressed: eventModel.loading
                                                  ? () {}
                                                  : () {
                                                      print('index ${index}');
                                                      controller =
                                                          BetterVideoPlayerController();
                                                      eventModel
                                                          .removeImageAddress(
                                                              index);
                                                    },
                                              icon: const Icon(
                                                Icons.close,
                                                color: kColorPrimary,
                                              )))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenSize.height * 0.1),
                    child: Visibility(
                      visible: eventModel.image!.isNotEmpty ? true : false,
                      child: Center(
                        child: Container(
                            width: screenSize.width * 0.5,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: eventModel.image!.isEmpty
                                      ? kColorGreyButton
                                      : kColorPrimary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(100),
                                color: eventModel.image!.isEmpty
                                    ? kColorGreyButton
                                    : kColorPrimary,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 4),
                                  )
                                ]),
                            child: InkWell(
                              onTap: () async {
                                if (eventModel.image!.isNotEmpty) {
                                  postModel
                                      .getEventInfoByID(
                                    eventId: AppGlobal.eventId,
                                    uploadedMediaLength:
                                        eventModel.image!.length,
                                    context: context,
                                  )
                                      .then((value) async {
                                    if (checkMediaMaxLimit(
                                        eventModel.image!.length)) {
                                      await eventModel.getImageUriData(
                                          imageAdress: eventModel.image!,
                                          context: context,
                                          taskId: taskProvider
                                              .randomTaskResponseModel!
                                              .task!
                                              .id,
                                          pid: AppGlobal.pId,
                                          token: AppGlobal.token);
                                      if (eventModel.imageUploadModel!.status ==
                                          true) {
                                        await eventModel.randomTaskComplete(
                                            pId: AppGlobal.pId,
                                            context: context,
                                            taskId: taskProvider
                                                .randomTaskResponseModel!
                                                .task!
                                                .id,
                                            token: AppGlobal.token);

                                        taskProvider.randomTaskResponseModel =
                                            null;

                                        eventModel.image = [];
                                        controller =
                                            BetterVideoPlayerController();
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SubmitPopup(
                                                title: languageModel
                                                            .languageResponseModel !=
                                                        null
                                                    ? '${languageModel.languageResponseModel!.mobileTasks.taskCompleted}!'
                                                    : 'Task completed!',
                                                icon: true,
                                                iconname:
                                                    Icons.check_circle_rounded,
                                                content: languageModel
                                                            .languageResponseModel !=
                                                        null
                                                    ? languageModel
                                                        .languageResponseModel!
                                                        .mobileTasks
                                                        .successMsg
                                                    : 'Task completed successfully.',
                                              );
                                            });

                                        taskProvider
                                            .checkIsRandomTasksCompleted(
                                                eventId: AppGlobal.eventId,
                                                context: context,
                                                token: AppGlobal.token)
                                            .then((value) {
                                          if (taskProvider
                                              .checkTaskCompleteResponseModel!
                                              .tasksAvailable) {
                                            taskProvider
                                                .selectedRandomTask(
                                                  context: context,
                                                  token: AppGlobal.token,
                                                  eventId: AppGlobal.eventId,
                                                )
                                                .then((value) {});
                                          }
                                        });
                                      }
                                    } else {
                                      eventModel.loading = false;
                                      eventModel.image!.clear();

                                      return showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertPopup(
                                              content: languageModel
                                                          .languageResponseModel !=
                                                      null
                                                  ? languageModel
                                                      .languageResponseModel!
                                                      .generalMessages
                                                      .mediaLimit
                                                  : 'Media limit exceeded',
                                            );
                                          });
                                    }
                                  });
                                }
                              },
                              child: eventModel.loading
                                  ? Container(
                                      child: SpinKitFadingCircle(
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                              child: Text(
                                            languageModel
                                                        .languageResponseModel !=
                                                    null
                                                ? languageModel
                                                    .languageResponseModel!
                                                    .mobileTasks
                                                    .uploadBtn
                                                : 'UPLOAD',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
                                          )),
                                          const Icon(
                                            Icons.upload,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  bool checkMediaMaxLimit(int imageFileListLength) {
    final postModel = Provider.of<DataClass>(context, listen: false);
    int totalVal = ((postModel.eventInfoByInfoIdResponse!.totalImages +
            postModel.eventInfoByInfoIdResponse!.totalVideos) +
        imageFileListLength);

    if (postModel.eventInfoByInfoIdResponse!.event.maxMedia > totalVal) {
      return true;
    } else {
      return false;
    }
  }
}
