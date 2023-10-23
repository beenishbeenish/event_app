import 'package:event_app/Provider/events_class.dart';
import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:event_app/Views/event_info_screen.dart';
import 'package:event_app/Views/qr_scan_screen.dart';

///Todo: Uncomment firebase and implement socail login's
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///Todo: Uncomment firebase and implement socail login's
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
///Todo: Uncomment firebase and implement socail login's
// import 'package:google_sign_in/google_sign_in.dart';

import 'package:provider/provider.dart';
// import 'package:platform_device_id/platform_device_id.dart';

import '../Provider/auth_class.dart';
import '../Provider/comments_class.dart';
import '../Provider/data_class.dart';
import '../Provider/greeting_class.dart';
import '../Provider/task_provider.dart';
import '../Utils/app_global.dart';
import '../Widegts/alert_popup_widget.dart';

class FirstInfoScreen extends StatefulWidget {
  const FirstInfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FirstInfoScreen> createState() => _FirstInfoScreenState();
}

class _FirstInfoScreenState extends State<FirstInfoScreen> {
  var deviceId = '';
  var signUpUserNameController = TextEditingController();
  @override
  void initState() {
    clearPreviousData();
    super.initState();
  }

  ///Todo: Uncomment firebase and implement socail login's
  // signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;
  //   print('credential................${googleAuth?.idToken}');
  //   // Create a new credential
  //   ///Todo: Uncomment firebase and implement socail login's
  //   // final credential = GoogleAuthProvider.credential(
  //   //   accessToken: googleAuth?.accessToken,
  //   //   idToken: googleAuth?.idToken,
  //   // );
  //
  //   // Once signed in, return the UserCredential
  //   ///Todo: Uncomment firebase and implement socail login's
  //   // var data = await FirebaseAuth.instance
  //   //     .signInWithCredential(credential)
  //   //     .then((value) => {print('respomse................${value}')});
  //   // print('data................${data}');
  // }

  ///Todo: Uncomment firebase and implement socail login's
  // signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //   print('credential................${facebookAuthCredential}');
  //
  //   // Once signed in, return the UserCredential
  //   var data = FirebaseAuth.instance
  //       .signInWithCredential(facebookAuthCredential)
  //       .then((value) => {print('respomse................${value}')});
  //   print('data................${data}');
  //   ;
  // }

  ///Todo : Need to translate
  showPopUp() {
    final languageModal = Provider.of<LanguageClass>(context, listen: false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: languageModal.languageResponseModel != null
                ? languageModal.languageResponseModel!.widgetAlerts.notAvailable
                : 'Not Available',
            content: languageModal.languageResponseModel != null
                ? languageModal
                    .languageResponseModel!.widgetAlerts.featureAvailabilty
                : 'This feature will be available soon.',
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final languageModal = Provider.of<LanguageClass>(context);
    final eventModal = Provider.of<EventClass>(context);
    // print(screenSize.height);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: screenSize.height < 650
              ? screenSize.height * 1.25
              : screenSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: screenSize.height * 0.09,
                  ),
                  Text(
                    // languageModal.languageResponseModel!=null? languageModal.languageResponseModel!.AppLanguage.eventManagementTitle:'Event Management',
                    'JSTPRTY',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.005,
                  ),
                  Text(
                    languageModal.languageResponseModel != null
                        ? languageModal
                            .languageResponseModel!.infoScreen.welcomeText
                        : 'All the memories from your events',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, color: Colors.grey.shade500),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.011,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Image.asset("assets/images/Mask Group 1.png"),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: screenSize.width * 0.5,
                                height: screenSize.width * 0.5,
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  //
                                  // radius: screenSize.width * 0.35,
                                  // backgroundColor: kColorPrimary,
                                  child: Image.asset(
                                    "assets/images/event_pic.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenSize.height * 0.03,
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ScanQrScreen()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kColorPrimary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: kColorPrimary,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 1,
                                      blurRadius: 8,
                                      offset: Offset(0, 3),
                                    )
                                  ]),
                              child: Icon(
                                Icons.qr_code,
                                color: Colors.white,
                                size: screenSize.height * 0.07,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    languageModal.languageResponseModel != null
                        ? languageModal.languageResponseModel!.infoScreen.scanQr
                        : 'SCAN QR CODE TO JOIN',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: screenSize.width * 0.2,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(
                        width: screenSize.width * 0.01,
                      ),
                      Container(
                        height: screenSize.height * 0.001,
                        width: screenSize.width * 0.01,
                        color: Colors.grey.shade500,
                      ),
                      Text(
                        languageModal.languageResponseModel != null
                            ? '  ${languageModal.languageResponseModel!.infoScreen.or}  '
                            : '  OR  ',
                        style: const TextStyle(
                            color: kColorPrimary, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        height: screenSize.height * 0.001,
                        width: screenSize.width * 0.01,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(
                        width: screenSize.width * 0.01,
                      ),
                      Container(
                        height: 1,
                        width: screenSize.width * 0.2,
                        color: Colors.grey.shade500,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 15,
                        bottom: MediaQuery.of(context).size.height * 0.006),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.text,
                      controller: signUpUserNameController,
                      //focusNode: fObservation,

                      // maxLength: 200,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      onChanged: (value) {
                        //print('$value,$charLength');
                      },
                      maxLines: 1,
                      cursorColor: kColorPrimary,

                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.code_outlined),
                          labelText: languageModal.languageResponseModel != null
                              ? languageModal.languageResponseModel!
                                  .generalMessages.enterEvCode
                              : 'Enter Event Code',
                          // labelStyle: TextStyle(color: kColorPrimary),
                          contentPadding: EdgeInsets.zero,
                          hintText: languageModal.languageResponseModel != null
                              ? languageModal.languageResponseModel!
                                  .generalMessages.enterCode
                              : 'Event Code',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 2, color: kColorPrimary)),
                          focusColor: kColorPrimary),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //             const EventInfoScreen(title: '')));
                      if (signUpUserNameController.text.isNotEmpty) {
                        moveToNextScreen(
                            eventId: signUpUserNameController.text);
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertPopup(
                                title:
                                    languageModal.languageResponseModel != null
                                        ? languageModal.languageResponseModel!
                                            .infoScreen.warning
                                        : 'Warning!',
                                content:
                                    languageModal.languageResponseModel != null
                                        ? languageModal.languageResponseModel!
                                            .infoScreen.warningMsg
                                        : 'Please fill all fields.',
                              );
                            });
                      }

                      // showPopUp();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            // width: screenSize.width * 0.65,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: screenSize.width * 0.12,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      signUpUserNameController.text.isNotEmpty
                                          ? kColorPrimary
                                          : Colors.grey,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(100),
                                color: signUpUserNameController.text.isNotEmpty
                                    ? kColorPrimary
                                    : Colors.grey,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  )
                                ]),
                            child: Center(
                                child: eventModal.loading
                                    ? SpinKitFadingCircle(
                                        size: 20,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                      )
                                    : Text(
                                        languageModal.languageResponseModel !=
                                                null
                                            ? languageModal
                                                .languageResponseModel!
                                                .infoScreen
                                                .joinEventBtn
                                            : 'JOIN EVENT',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ))),
                      ],
                    ),
                  ),
                ],
              ),
              Image.asset("assets/images/Mask Group 2.png"),
            ],
          ),
        ),
      ),
    );
  }

  FlutterSecureStorage storage = const FlutterSecureStorage();
  moveToNextScreen({required String eventId}) async {
    final languageModal = Provider.of<LanguageClass>(context, listen: false);
    final eventModal = Provider.of<EventClass>(context, listen: false);
    eventModal
        .getEventDataOnJoinWithCode(eventId: eventId, context: context)
        .then((value) async {
      if (eventModal.eventResponseModel?.status == true) {
        signUpUserNameController.clear();

        await storage.write(
            key: 'event_id', value: eventModal.eventResponseModel?.event!.id);
        await storage.write(
            key: 'event_code',
            value: eventModal.eventResponseModel?.event!.eventCode);

        AppGlobal.eventId = eventModal.eventResponseModel?.event!.id ?? '';

        AppGlobal.eventCode =
            eventModal.eventResponseModel?.event!.eventCode ?? '';

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    const EventInfoScreen(title: '')));
      } else {}
    });
  }

  void clearPreviousData() {
    final languageModal = Provider.of<LanguageClass>(context, listen: false);
    final authModal = Provider.of<AuthClass>(context, listen: false);
    final commentModal = Provider.of<CommentClass>(context, listen: false);
    final dataModal = Provider.of<DataClass>(context, listen: false);
    final eventModal = Provider.of<EventClass>(context, listen: false);
    final greetingModal = Provider.of<GreetingClass>(context, listen: false);
    final taskModal = Provider.of<TaskProvider>(context, listen: false);

    languageModal.loading = false;
    authModal.loading = false;
    authModal.signupLoading = false;
    authModal.uploadloading = false;
    commentModal.loading = false;
    commentModal.commentLoading = false;
    commentModal.downloading = false;
    dataModal.loading = false;
    dataModal.uploadloading = false;
    eventModal.loading = false;
    greetingModal.loading = false;
    taskModal.loading = false;
    taskModal.uploadloading = false;
    taskModal.downloading = false;
  }
}
