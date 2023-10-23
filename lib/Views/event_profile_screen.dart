import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/Provider/auth_class.dart';
import 'package:event_app/Provider/events_class.dart';
import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Provider/task_provider.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Views/data_policy_screen.dart';
import 'package:event_app/Views/first_info_screen.dart';
import 'package:event_app/Views/profile_screen.dart';
import 'package:event_app/Views/tasks_complete_screen.dart';
import 'package:event_app/Views/tasks_screen.dart';
import 'package:event_app/Widegts/language_widget.dart';

///Todo: Uncomment firebase and implement socail login's
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../Provider/data_class.dart';
import '../Widegts/video_preview_widget.dart';
import 'gallery_screen.dart';
import 'greetings_screen.dart';

class EventProfileScreen extends StatefulWidget {
  const EventProfileScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<EventProfileScreen> createState() => _EventProfileScreenState();
}

class _EventProfileScreenState extends State<EventProfileScreen> {
  @override
  void initState() {
    super.initState();
    print("Token :${AppGlobal.token}");
    final eventModal = Provider.of<EventClass>(context, listen: false);
    final postModel = Provider.of<DataClass>(context, listen: false);
    eventModal.guestCountResponseModel = null;
    // if (postModel.publicGalleryResponseModel != null) {
    //   postModel.publicGalleryResponseModel!.images.clear();
    // }
    // postModel.allMyUploadResponseModel = null;
    Future.delayed(Duration.zero, () async {
      eventModal.getGuestCount(
          eventId: AppGlobal.eventId, token: AppGlobal.token, context: context);
    });

    Future.delayed(Duration.zero, () async {
      postModel.selectedPublicGalleryTab(
          pId: AppGlobal.pId,
          context: context,
          eventId: AppGlobal.eventId,
          selectedTab: 'Public Gallery',
          token: AppGlobal.token);
    });
  }

  dateFormate({
    required String datefrom,
  }) {
    final DateTime docDateTime = DateTime.parse(datefrom);

    return DateFormat('dd.MM.yyyy').format(docDateTime);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final eventModal = Provider.of<EventClass>(context);
    final authModal = Provider.of<AuthClass>(context);
    final languageModel = Provider.of<LanguageClass>(context);
    final taskProvider = Provider.of<TaskProvider>(context);
    final postModel = Provider.of<DataClass>(context);

    return Scaffold(
      backgroundColor: kColorBackGround,
      appBar: AppBar(
        title: Text(
          languageModel.languageResponseModel != null
              ? languageModel.languageResponseModel!.eventProfile.eventProfile
              : 'Event Profile',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: kColorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
          child: Column(
        children: [
          InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) =>
              //             const EventProfileScreen(title: 'Categories')));
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
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
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
                                        datefrom:
                                            '${eventModal.eventResponseModel!.event!.generalInfo.dateFrom}')
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
                    ListTile(
                      leading: SvgPicture.asset(
                          "assets/icons/Icon open-task.svg",
                          color: kColorPrimary,
                          height: 18,
                          width: 18,
                          semanticsLabel: ''),
                      title: Text(
                        languageModel.languageResponseModel != null
                            ? languageModel.languageResponseModel!.mobileGallery
                                .sidebarTasks
                            : 'Tasks',
                        style: const TextStyle(
                            color: kColorPrimary, fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const TasksScreen(title: 'Categories')));
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
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //         const GreetingsScreen(
                        //             title: 'Categories')));
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
                    // ListTile(
                    //   leading: SvgPicture.asset("assets/icons/Path 6659.svg",
                    //       color: kColorPrimary,
                    //       height: 18,
                    //       width: 18,
                    //       semanticsLabel: ''),
                    //   title:  Text(
                    //     languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.data[0].attributes.imprintTitle:'Imprint',
                    //     style: TextStyle(
                    //       color: kColorPrimary,
                    //       fontWeight: FontWeight.w600,
                    //       decoration: TextDecoration.underline,
                    //     ),
                    //   ),
                    //   onTap: () {},
                    // ),
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

                        ///Todo: Uncomment firebase and implement socail login's
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: screenSize.height * 0.3,
                  width: screenSize.width,
                  color: kColorPrimary,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: eventModal.guestCountResponseModel != null
                            ? eventModal.guestCountResponseModel!.coverImage!
                            : '',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => ClipRRect(
                          // borderRadius: BorderRadius.circular(35),
                          child: Container(
                            height: screenSize.height * 0.3,
                            width: screenSize.width,
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
                        errorWidget: (context, url, error) => Container(
                          height: screenSize.height * 0.3,
                          width: screenSize.width,
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
                      // Image.network(
                      //
                      //   eventModal.guestCountResponseModel!=null? eventModal.guestCountResponseModel!.profileImage:'',
                      //   fit: BoxFit.fill,
                      //   height: screenSize.height * 0.3,
                      //   width: screenSize.width,
                      // ),
                      // Container(
                      //   width: screenSize.width,
                      //   height: screenSize.height * 0.3,
                      //   decoration: const BoxDecoration(
                      //     color: kColorPrimary
                      //     //color: kColorPrimary,
                      //   ),
                      //
                      // ),
                      Container(
                        width: screenSize.width * 0.3,
                        height: screenSize.width * 0.3,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 5.0,
                            ),
                            borderRadius: BorderRadius.circular(200),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              )
                            ]
                            //color: kColorPrimary,
                            ),
                        child: CircleAvatar(
                          radius: screenSize.width * 0.35,
                          backgroundColor: Colors.white,
                          child: Container(
                            width: screenSize.width * 0.3,
                            height: screenSize.width * 0.3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  )
                                ]
                                //color: kColorPrimary,
                                ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl:
                                    eventModal.guestCountResponseModel != null
                                        ? eventModal.guestCountResponseModel!
                                            .profileImage!
                                        : '',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
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
                                  color: Colors.black38,
                                  size: 45,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      eventModal.eventResponseModel != null
                          ? eventModal
                              .eventResponseModel!.event!.generalInfo.eventName
                          : '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: kColorBrownText,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      eventModal.eventResponseModel != null
                          ? dateFormate(
                              datefrom: eventModal.eventResponseModel!.event!
                                  .generalInfo.dateFrom)
                          : '',
                      style: const TextStyle(
                        fontSize: 12,
                        color: kColorGreyText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset("assets/icons/Group 7566.svg",
                            color: kColorPrimary,
                            height: 20,
                            width: 20,
                            semanticsLabel: ''),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(eventModal.guestCountResponseModel != null
                            ? eventModal.guestCountResponseModel!.imagesCount
                                .toString()
                            : '0')
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset("assets/icons/video.svg",
                            color: kColorPrimary,
                            height: 20,
                            width: 20,
                            semanticsLabel: ''),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(eventModal.guestCountResponseModel != null
                            ? eventModal.guestCountResponseModel!.videoCount
                                .toString()
                            : '0')
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset("assets/icons/Group 7568.svg",
                            color: kColorPrimary,
                            height: 20,
                            width: 20,
                            semanticsLabel: ''),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(eventModal.guestCountResponseModel != null
                            ? eventModal.guestCountResponseModel!.maxGuests
                                .toString()
                            : '0')
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: SvgPicture.asset("assets/icons/Icon open-task.svg",
                      color: kColorPrimary,
                      height: 18,
                      width: 18,
                      semanticsLabel: ''),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        languageModel.languageResponseModel != null
                            ? languageModel
                                .languageResponseModel!.eventProfile.performTask
                            : 'Perform Tasks',
                        style: TextStyle(
                            color: kColorPrimary, fontWeight: FontWeight.w600),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: kColorPrimary,
                        size: 14,
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const TasksScreen(title: 'Categories')));
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
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        languageModel.languageResponseModel != null
                            ? languageModel.languageResponseModel!
                                .mobileGreetings.addGreeting
                            : 'Add Greetings',
                        style: TextStyle(
                            color: kColorPrimary, fontWeight: FontWeight.w600),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: kColorPrimary,
                        size: 14,
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const GreetingsScreen(title: 'Categories')));
                  },
                ),
                Divider(
                  height: 1,
                  color: Colors.grey.shade300,
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const GalleryScreen(title: 'Categories')));
                  },
                  child: Column(
                    children: [
                      Container(
                        width: screenSize.width,
                        height: screenSize.width * 0.3,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            postModel.publicGalleryResponseModel != null
                                ? postModel.publicGalleryResponseModel!.gal
                                        .isNotEmpty
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          postModel.publicGalleryResponseModel!
                                                  .gal.isNotEmpty
                                              ? postModel.publicGalleryResponseModel!
                                                          .gal[0].type ==
                                                      'application/mp4'
                                                  ? Container(
                                                      width: screenSize.width *
                                                          0.29,
                                                      height: screenSize.width *
                                                          0.29,
                                                      child: Stack(children: [
                                                        Container(
                                                            width: screenSize
                                                                    .width *
                                                                0.29,
                                                            height:
                                                                screenSize
                                                                        .width *
                                                                    0.29,
                                                            decoration:
                                                                BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .transparent
                                                                      .withOpacity(
                                                                          0.1),
                                                                  spreadRadius:
                                                                      1,
                                                                  blurRadius: 2,
                                                                  offset:
                                                                      Offset(
                                                                          0, 0),
                                                                )
                                                              ],
                                                            ),
                                                            child: VideoPlayerWidget(
                                                                url: postModel
                                                                            .publicGalleryResponseModel !=
                                                                        null
                                                                    ? postModel
                                                                            .publicGalleryResponseModel!
                                                                            .images[
                                                                        0]
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
                                                      ]),
                                                    )
                                                  : Container(
                                                      width: screenSize.width *
                                                          0.29,
                                                      height: screenSize.width *
                                                          0.29,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .transparent
                                                                .withOpacity(
                                                                    0.1),
                                                            spreadRadius: 1,
                                                            blurRadius: 2,
                                                            offset:
                                                                Offset(0, 0),
                                                          )
                                                        ],
                                                      ),
                                                      child: CachedNetworkImage(
                                                        // fit: BoxFit.cover,
                                                        imageUrl: postModel
                                                                    .publicGalleryResponseModel !=
                                                                null
                                                            ? postModel
                                                                .publicGalleryResponseModel!
                                                                .images[0]
                                                            : '',
                                                        progressIndicatorBuilder: (context,
                                                                url,
                                                                downloadProgress) =>
                                                            SizedBox(
                                                                width: 100.0,
                                                                height: 100.0,
                                                                child: Container(
                                                                    width:
                                                                        120.0,
                                                                    height:
                                                                        120.0,
                                                                    color: Colors
                                                                        .black,
                                                                    child: const Icon(
                                                                        Icons
                                                                            .error))),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Container(
                                                                width: 120.0,
                                                                height: 120.0,
                                                                color: Colors
                                                                    .black,
                                                                child: const Icon(
                                                                    Icons
                                                                        .error)),
                                                      ),
                                                    )
                                              : const SizedBox(),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          postModel.publicGalleryResponseModel!
                                                      .gal.length >
                                                  1
                                              ? postModel.publicGalleryResponseModel!
                                                          .gal[1].type ==
                                                      'application/mp4'
                                                  ? Container(
                                                      width: screenSize.width *
                                                          0.29,
                                                      height: screenSize.width *
                                                          0.29,
                                                      child: Stack(children: [
                                                        Container(
                                                            width: screenSize
                                                                    .width *
                                                                0.29,
                                                            height:
                                                                screenSize
                                                                        .width *
                                                                    0.29,
                                                            decoration:
                                                                BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .transparent
                                                                      .withOpacity(
                                                                          0.1),
                                                                  spreadRadius:
                                                                      1,
                                                                  blurRadius: 2,
                                                                  offset:
                                                                      Offset(
                                                                          0, 0),
                                                                )
                                                              ],
                                                            ),
                                                            child: VideoPlayerWidget(
                                                                url: postModel
                                                                            .publicGalleryResponseModel !=
                                                                        null
                                                                    ? postModel
                                                                            .publicGalleryResponseModel!
                                                                            .images[
                                                                        1]
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
                                                      ]),
                                                    )
                                                  : Container(
                                                      width: screenSize.width *
                                                          0.29,
                                                      height: screenSize.width *
                                                          0.29,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .transparent
                                                                .withOpacity(
                                                                    0.1),
                                                            spreadRadius: 1,
                                                            blurRadius: 2,
                                                            offset:
                                                                Offset(0, 0),
                                                          )
                                                        ],
                                                      ),
                                                      child: CachedNetworkImage(
                                                        // fit: BoxFit.cover,
                                                        imageUrl: postModel
                                                                    .publicGalleryResponseModel !=
                                                                null
                                                            ? postModel
                                                                .publicGalleryResponseModel!
                                                                .images[1]
                                                            : '',
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    downloadProgress) =>
                                                                SizedBox(
                                                          width: 100.0,
                                                          height: 100.0,
                                                          child: Shimmer
                                                              .fromColors(
                                                            direction:
                                                                ShimmerDirection
                                                                    .ttb,
                                                            baseColor: Colors
                                                                .grey.shade300,
                                                            highlightColor:
                                                                Colors.grey
                                                                    .shade100,
                                                            enabled: true,
                                                            child: Container(
                                                              color: Colors.grey
                                                                  .shade200,
                                                            ),
                                                          ),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
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
                                                    )
                                              : const SizedBox(),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          postModel.publicGalleryResponseModel!
                                                      .gal.length >
                                                  2
                                              ? postModel.publicGalleryResponseModel!
                                                          .gal[2].type ==
                                                      'application/mp4'
                                                  ? Container(
                                                      width: screenSize.width *
                                                          0.29,
                                                      height: screenSize.width *
                                                          0.29,
                                                      child: Stack(children: [
                                                        Container(
                                                            width: screenSize
                                                                    .width *
                                                                0.29,
                                                            height:
                                                                screenSize
                                                                        .width *
                                                                    0.29,
                                                            decoration:
                                                                BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .transparent
                                                                      .withOpacity(
                                                                          0.1),
                                                                  spreadRadius:
                                                                      1,
                                                                  blurRadius: 2,
                                                                  offset:
                                                                      Offset(
                                                                          0, 0),
                                                                )
                                                              ],
                                                            ),
                                                            child: VideoPlayerWidget(
                                                                url: postModel
                                                                            .publicGalleryResponseModel !=
                                                                        null
                                                                    ? postModel
                                                                            .publicGalleryResponseModel!
                                                                            .images[
                                                                        2]
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
                                                      ]),
                                                    )
                                                  : Container(
                                                      width: screenSize.width *
                                                          0.29,
                                                      height: screenSize.width *
                                                          0.29,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .transparent
                                                                .withOpacity(
                                                                    0.1),
                                                            spreadRadius: 1,
                                                            blurRadius: 2,
                                                            offset:
                                                                Offset(0, 0),
                                                          )
                                                        ],
                                                      ),
                                                      child: CachedNetworkImage(
                                                        // height: 100,
                                                        // width: 100,
                                                        // fit: BoxFit.cover,
                                                        imageUrl: postModel
                                                                    .publicGalleryResponseModel !=
                                                                null
                                                            ? postModel
                                                                .publicGalleryResponseModel!
                                                                .images[2]
                                                            : '',
                                                        progressIndicatorBuilder: (context,
                                                                url,
                                                                downloadProgress) =>
                                                            SizedBox(
                                                                width: 100.0,
                                                                height: 100.0,
                                                                child: Container(
                                                                    width:
                                                                        120.0,
                                                                    height:
                                                                        120.0,
                                                                    color: Colors
                                                                        .black,
                                                                    child: const Icon(
                                                                        Icons
                                                                            .error))),

                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Container(
                                                                width: 120.0,
                                                                height: 120.0,
                                                                color: Colors
                                                                    .black,
                                                                child: const Icon(
                                                                    Icons
                                                                        .error)),
                                                      ),
                                                    )
                                              : const SizedBox(),
                                        ],
                                      )
                                    : const SizedBox()
                                : const SizedBox(),
                            Container(
                              width: screenSize.width * 0.93,
                              height: screenSize.width * 0.1,
                              decoration: BoxDecoration(
                                //  borderRadius: BorderRadius.circular(20),
                                color: kColorPrimary.withOpacity(0.7),
                                //color: kColorPrimary,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    languageModel.languageResponseModel != null
                                        ? languageModel.languageResponseModel!
                                            .mobileGallery.sidebarGallery
                                        : 'Gallery',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
