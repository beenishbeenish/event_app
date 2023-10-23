import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:event_app/DataModelClasses/auth_model_response.dart';
import 'package:event_app/Provider/auth_class.dart';
import 'package:event_app/Provider/data_class.dart';
import 'package:event_app/Provider/events_class.dart';
import 'package:event_app/Provider/greeting_class.dart';
import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Provider/task_provider.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Views/add_more_greeting_screen.dart';
import 'package:event_app/Views/event_profile_screen.dart';
import 'package:event_app/Views/first_info_screen.dart';
import 'package:event_app/Views/profile_screen.dart';
import 'package:event_app/Views/tasks_complete_screen.dart';
import 'package:event_app/Views/tasks_screen.dart';
import 'package:event_app/Views/view_media_screen.dart';
import 'package:event_app/Widegts/alert_popup_widget.dart';
import 'package:event_app/Widegts/delete_popup_widget.dart';
import 'package:event_app/Widegts/language_widget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../Widegts/video_preview_widget.dart';
import 'data_policy_screen.dart';
import 'gallery_screen.dart';

class GreetingsScreen extends StatefulWidget {
  const GreetingsScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GreetingsScreen> createState() => _GreetingsScreenState();
}

class _GreetingsScreenState extends State<GreetingsScreen> {
  var highlightController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final greetingModal = Provider.of<GreetingClass>(context, listen: false);
    greetingModal.allGreetingResponse = null;
    Future.delayed(Duration.zero, () async {
      greetingModal.getAllGreetings(
          context: context, eventId: AppGlobal.eventId, token: AppGlobal.token);
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
    final greetingModal = Provider.of<GreetingClass>(context);
    final taskProvider = Provider.of<TaskProvider>(context);

    final languageModel = Provider.of<LanguageClass>(context);
    final authModal = Provider.of<AuthClass>(context);

    // moveToNext(languageModel) async {
    //   if (highlightController.text.isNotEmpty) {
    //     if (descriptionController.text.isNotEmpty) {
    //       final eventModal = Provider.of<EventClass>(context, listen: false);
    //
    //       await eventModal.setUsername(
    //         username: signUpUserNameController.text,
    //         context: context);
    //       if (eventModal.usernameSetResponse?.status == true) {
    //       AppGlobal.userName = signUpUserNameController.text;
    //
    //           Navigator.of(context).pushAndRemoveUntil(
    //               MaterialPageRoute(
    //                   builder: (context) => const AddMoreGreetingsScreen(title: 'Categories')),
    //                   (Route<dynamic> route) => false);
    //     }}
    //   } else {
    //     showDialog(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return AlertPopup(
    //             title: languageModel.languageResponseModel != null
    //                 ? languageModel.languageResponseModel!.infoScreen.warning
    //                 : 'Warning!',
    //             content: languageModel.languageResponseModel != null
    //                 ? languageModel
    //                 .languageResponseModel!.infoScreen.warningMsg
    //                 : 'Please fill all fields.',
    //           );
    //         });
    //   }
    // }

    return Scaffold(
      backgroundColor: kColorBackGround,
      appBar: AppBar(
        title: Text(
          languageModel.languageResponseModel != null
              ? languageModel
                  .languageResponseModel!.mobileGallery.sidebarGreetings
              : 'Greetings',
          style: const TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          // FlatButton(
          //   textColor: Colors.white,
          //   onPressed:  () {
          //     if(greetingModal.allGreetingResponse != null
          //         ){
          //       if( greetingModal.allGreetingResponse!.greetings==null){
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (BuildContext context) =>
          //                       const AddMoreGreetingsScreen(
          //                           title: 'Categories'))).then(
          //                   (value) {
          //                   //  print('print.........1.............$value');
          //                 if ( value == true){
          //                   final greetingModal =
          //                   Provider.of<GreetingClass>(context,
          //                       listen: false);
          //                   greetingModal.getAllGreetings(
          //                     context: context,
          //                       eventId: AppGlobal.eventId,
          //                       token: AppGlobal.token);
          //                 }
          //               });}
          //     }
          //         },
          //   child: greetingModal.allGreetingResponse != null
          //       ?  greetingModal.allGreetingResponse!.greetings==null?SvgPicture.asset("assets/icons/Icon ionic-ios-add.svg",
          //           color: Colors.white,
          //           height: 18,
          //           width: 18,
          //           semanticsLabel: '')
          //       : Text('' ): Text(''),
          // ),
        ],
        backgroundColor: kColorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: greetingModal.showAddButton
          ? FloatingActionButton(
              onPressed: () {
                // if(greetingModal.allGreetingResponse != null
                // ){
                if (greetingModal.showAddButton &&
                    greetingModal.loading == false) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AddMoreGreetingsScreen(
                                  title: 'Categories'))).then((value) {
                    //  print('print.........1.............$value');
                    if (value == true) {
                      final greetingModal =
                          Provider.of<GreetingClass>(context, listen: false);
                      greetingModal.getAllGreetings(
                          context: context,
                          eventId: AppGlobal.eventId,
                          token: AppGlobal.token);
                    }
                  });
                  //}
                }
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 29,
              ),
              backgroundColor: kColorPrimary,
              elevation: 5,
              splashColor: Colors.grey,
            )
          : const SizedBox(),
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
                            imageUrl: AppGlobal.profileImage != null
                                ? AppGlobal.profileImage
                                : '',
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
                                eventModal.eventResponseModel != null
                                    ? eventModal.eventResponseModel!.event!
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
                              eventModal.eventResponseModel != null
                                  ? dateFormate(
                                      datefrom: eventModal.eventResponseModel!
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
                    Container(
                      color: kColorPrimary.withOpacity(0.3),
                      child: ListTile(
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
                        onTap: () {},
                      ),
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
                            : 'App Language',
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
                        style: TextStyle(
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
                      title: const Text(
                        'Share',
                        style: TextStyle(
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

                        ///Todo: Social login
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: greetingModal.loading
            ? Container(
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
              )
            : greetingModal.allGreetingResponse != null
                ? greetingModal.allGreetingResponse!.greetings != null
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: screenSize.width,
                              // height: screenSize.height * 0.75,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 1,
                                      blurRadius: 8,
                                      offset: Offset(0, 3),
                                    )
                                  ]),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          greetingModal.allGreetingResponse !=
                                                  null
                                              ? dateFormate(
                                                  datefrom: greetingModal
                                                      .allGreetingResponse!
                                                      .greetings
                                                      .createdAt)
                                              : '',
                                          style: const TextStyle(
                                            color: kColorGreyText,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return DeletePopup(
                                                        content: languageModel
                                                                    .languageResponseModel !=
                                                                null
                                                            ? languageModel
                                                                .languageResponseModel!
                                                                .mobileGreetings
                                                                .deleteConfirm
                                                            : 'Are you sure you want to delete this greeting.',
                                                        onDeletePress: () {
                                                          greetingModal
                                                              .deleteGreeting(
                                                            greetingId: greetingModal
                                                                        .allGreetingResponse !=
                                                                    null
                                                                ? greetingModal
                                                                    .allGreetingResponse!
                                                                    .greetings
                                                                    .id
                                                                : '',
                                                            token:
                                                                AppGlobal.token,
                                                            context: context,
                                                          )
                                                              .then((e) {
                                                            // greetingModal.getAllGreetings(
                                                            //     eventId: AppGlobal.eventId, token: AppGlobal.token);
                                                          }).catchError((e) {
                                                            print(
                                                                'error......$e');
                                                          });
                                                        },
                                                      );
                                                    });
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                size: 19,
                                                color: kColorPrimary,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    eventModal.eventResponseModel!.event!
                                        .generalInfo.eventName,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: kColorBrownText,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Text(
                                      greetingModal.allGreetingResponse != null
                                          ? greetingModal.allGreetingResponse!
                                              .greetings.description
                                          : '',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 2,
                                            width: screenSize.width * 0.15,
                                            color: kColorPrimary,
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            height: 2,
                                            width: screenSize.width * 0.18,
                                            color: kColorPrimary,
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            height: 2,
                                            width: screenSize.width * 0.15,
                                            color: kColorPrimary,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 8,
                                            color: kColorPrimary,
                                          ),
                                          const SizedBox(
                                            width: 1,
                                          ),
                                          const Icon(
                                            Icons.star,
                                            size: 9,
                                            color: kColorPrimary,
                                          ),
                                          const SizedBox(
                                            width: 1,
                                          ),
                                          const Icon(
                                            Icons.star,
                                            size: 10,
                                            color: kColorPrimary,
                                          ),
                                          const SizedBox(
                                            width: 1,
                                          ),
                                          const Icon(
                                            Icons.star,
                                            size: 11,
                                            color: kColorPrimary,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              greetingModal
                                                          .allGreetingResponse !=
                                                      null
                                                  ? greetingModal
                                                      .allGreetingResponse!
                                                      .greetings
                                                      .title
                                                  : '',
                                              maxLines: 3,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: kColorPrimary,
                                                  fontSize:
                                                      screenSize.width * 0.033,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                            Icons.star,
                                            size: 11,
                                            color: kColorPrimary,
                                          ),
                                          const SizedBox(
                                            width: 1,
                                          ),
                                          const Icon(
                                            Icons.star,
                                            size: 10,
                                            color: kColorPrimary,
                                          ),
                                          const SizedBox(
                                            width: 1,
                                          ),
                                          const Icon(
                                            Icons.star,
                                            size: 9,
                                            color: kColorPrimary,
                                          ),
                                          const SizedBox(
                                            width: 1,
                                          ),
                                          const Icon(
                                            Icons.star,
                                            size: 8,
                                            color: kColorPrimary,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: 2,
                                            width: screenSize.width * 0.15,
                                            color: kColorPrimary,
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            height: 2,
                                            width: screenSize.width * 0.18,
                                            color: kColorPrimary,
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            height: 2,
                                            width: screenSize.width * 0.15,
                                            color: kColorPrimary,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: GridView.builder(
                                      itemCount:
                                          greetingModal.allGreetingResponse !=
                                                  null
                                              ? greetingModal
                                                  .allGreetingResponse!
                                                  .greetings
                                                  .images
                                                  .length
                                              : 0,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 30 / 30,
                                              crossAxisSpacing: 7,
                                              crossAxisCount: 3),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 5),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          ViewMediaScreen(
                                                            mediaURl: greetingModal
                                                                .allGreetingResponse!
                                                                .greetings
                                                                .images[index]
                                                                .file,
                                                            mediaType: greetingModal
                                                                .allGreetingResponse!
                                                                .greetings
                                                                .images[index]
                                                                .fileType,
                                                          )));
                                            },
                                            child: greetingModal
                                                        .allGreetingResponse!
                                                        .greetings
                                                        .images[index]
                                                        .fileType ==
                                                    'application/mp4'
                                                ? Stack(
                                                    children: [
                                                      Container(
                                                        height:
                                                            screenSize.width *
                                                                0.28,
                                                        width:
                                                            screenSize.width *
                                                                0.28,
                                                        decoration:
                                                            BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color:
                                                                      kColorPrimary,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                color: Colors
                                                                    .black,
                                                                boxShadow: const [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black26,
                                                                spreadRadius: 1,
                                                                blurRadius: 8,
                                                                offset: Offset(
                                                                    0, 3),
                                                              )
                                                            ]),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          17)),
                                                          child: VideoPlayerWidget(
                                                              url: greetingModal
                                                                          .allGreetingResponse !=
                                                                      null
                                                                  ? greetingModal
                                                                      .allGreetingResponse!
                                                                      .greetings
                                                                      .images[
                                                                          index]
                                                                      .file
                                                                  : '',
                                                              mediaTypeisLocalVideo:
                                                                  false),
                                                        ),
                                                      ),
                                                      const Positioned(
                                                          child: Center(
                                                              child: Icon(
                                                        Icons
                                                            .play_circle_outline_outlined,
                                                        color: kColorPrimary,
                                                        size: 35,
                                                      )))
                                                    ],
                                                  )
                                                : Container(
                                                    height:
                                                        screenSize.width * 0.28,
                                                    width:
                                                        screenSize.width * 0.28,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: kColorPrimary,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors.black,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black26,
                                                            spreadRadius: 1,
                                                            blurRadius: 8,
                                                            offset:
                                                                Offset(0, 3),
                                                          )
                                                        ]),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  17)),
                                                      child: CachedNetworkImage(
                                                        // height: 100,
                                                        // width: 100,
                                                        fit: BoxFit.cover,
                                                        imageUrl: greetingModal
                                                            .allGreetingResponse!
                                                            .greetings
                                                            .images[index]
                                                            .file,
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
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Container(
                              child: greetingModal.allGreetingResponse == null
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    const AddMoreGreetingsScreen(
                                                        title:
                                                            'Categories'))).then(
                                            (value) {
                                          if (value == true) {
                                            final greetingModal =
                                                Provider.of<GreetingClass>(
                                                    context,
                                                    listen: false);
                                            greetingModal.getAllGreetings(
                                                context: context,
                                                eventId: AppGlobal.eventId,
                                                token: AppGlobal.token);
                                          }
                                        });
                                      },
                                      child: DottedBorder(
                                        radius: const Radius.circular(100),
                                        dashPattern: const [10, 8],
                                        color: kColorPrimary,
                                        borderType: BorderType.RRect,
                                        child: Container(
                                          height: 40,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                          ),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                languageModel
                                                            .languageResponseModel !=
                                                        null
                                                    ? languageModel
                                                        .languageResponseModel!
                                                        .mobileGreetings
                                                        .addMore
                                                    : 'ADD MORE',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: kColorPrimary),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  "assets/icons/Icon feather-smile.svg",
                                  color: kColorPrimary.withOpacity(0.5),
                                  height: 100,
                                  width: 100,
                                  semanticsLabel: ''),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                languageModel.languageResponseModel != null
                                    ? languageModel.languageResponseModel!
                                        .mobileGreetings.noGreetings
                                    : 'No greeting',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: kColorPrimary.withOpacity(0.5),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      )
                : Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                              "assets/icons/Icon feather-smile.svg",
                              color: kColorPrimary.withOpacity(0.5),
                              height: 100,
                              width: 100,
                              semanticsLabel: ''),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            languageModel.languageResponseModel != null
                                ? languageModel.languageResponseModel!
                                    .mobileGreetings.noGreetings
                                : 'No greetings',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kColorPrimary.withOpacity(0.5),
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
