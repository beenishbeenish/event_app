import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/Provider/events_class.dart';
import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Views/data_policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shimmer/shimmer.dart';
import '../Provider/data_class.dart';
import '../Widegts/alert_popup_widget.dart';
import 'event_profile_screen.dart';
import 'first_info_screen.dart';

class EnterUsernameScreen extends StatefulWidget {
  const EnterUsernameScreen({Key? key, required this.title, eventId})
      : super(key: key);

  final String title;

  @override
  State<EnterUsernameScreen> createState() => _EnterUsernameScreenState();
}

class _EnterUsernameScreenState extends State<EnterUsernameScreen> {
  var signUpUserNameController = TextEditingController();
  bool TCChecked = false;
  bool GDRPChecked = false;

  @override
  void initState() {
    super.initState();
    final eventModal = Provider.of<EventClass>(context, listen: false);
  }

  moveToNextScreen(languageModel) async {
    if (signUpUserNameController.text.isNotEmpty) {
      final eventModal = Provider.of<EventClass>(context, listen: false);
      final postModel = Provider.of<DataClass>(context, listen: false);

      if (postModel.publicGalleryResponseModel != null) {
        postModel.publicGalleryResponseModel!.images.clear();
        postModel.publicGalleryResponseModel = null;
      }

      String? deviceId = await PlatformDeviceId.getDeviceId;
      AppGlobal.deviceId = deviceId;
      print('Device id.....: $deviceId');
      await eventModal.setUsername(
          username: signUpUserNameController.text,
          deviceId: deviceId.toString(),
          context: context);
      if (eventModal.usernameSetResponse?.status == true) {
        AppGlobal.userName = signUpUserNameController.text;

        if (TCChecked == true) {
          if (GDRPChecked == true) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const EventProfileScreen(title: '')),
                (Route<dynamic> route) => false);

            // WidgetsBinding.instance.addPostFrameCallback((_) {

            // });
          }
        }
      } else {}
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertPopup(
              title: languageModel.languageResponseModel != null
                  ? languageModel.languageResponseModel!.infoScreen.warning
                  : 'Warning!',
              content: languageModel.languageResponseModel != null
                  ? languageModel.languageResponseModel!.infoScreen.warningMsg
                  : 'Please fill all fields.',
            );
          });
    }
  }

  Future<bool> onBackPress() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.deleteAll();
    AppGlobal.token = '';
    AppGlobal.eventId = '';
    AppGlobal.pId = '';

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const FirstInfoScreen()),
        (Route<dynamic> route) => false);
    print('>>>>>>>.Back');
    //we need to return a future
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final eventModal = Provider.of<EventClass>(context);
    // print('your data....qqq ${eventModal.eventResponseModel?.events[0].id}');
    final languageModel = Provider.of<LanguageClass>(context);

    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            height: screenSize.height < 650
                ? screenSize.height * 1.18
                : screenSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: screenSize.height * 0.07,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              onBackPress();
                            },
                            icon: const Icon(
                              Icons.keyboard_arrow_left_rounded,
                              color: kColorPrimary,
                              size: 35,
                            )),
                        Text(
                          eventModal.eventResponseModel?.event != null
                              ? '${eventModal.eventResponseModel?.event!.generalInfo.eventName.toString()}'
                              : '',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 23, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: screenSize.height * 0.3,
                        width: screenSize.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: kColorPrimary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            color: kColorPrimary,
                            // image:  DecorationImage(
                            //   image: NetworkImage(
                            //    '${
                            //       eventModal
                            //           .eventResponseModel?.event.coverImage
                            //     }',
                            //
                            //   ),
                            //   fit: BoxFit.cover,
                            // ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                          child: CachedNetworkImage(
                            imageUrl: eventModal.eventResponseModel != null
                                ? eventModal.eventResponseModel!.event != null
                                    ? eventModal
                                        .eventResponseModel!.event!.coverImage
                                        .replaceAll('\\', '/')
                                    : ''
                                : '',
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
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
                            errorWidget: (context, url, error) => const Icon(
                              Icons.image_not_supported,
                              color: Colors.black38,
                              size: 45,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        eventModal.eventResponseModel?.event != null
                            ? '${eventModal.eventResponseModel?.event!.generalInfo.description.toString()}'
                            : '',
                        textAlign: TextAlign.center,
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 25,
                          right: 25,
                          top: 15,
                          bottom: MediaQuery.of(context).size.height * 0.015),
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
                            prefixIcon: Icon(Icons.person),
                            labelText:
                                languageModel.languageResponseModel != null
                                    ? languageModel.languageResponseModel!
                                        .infoScreen.username
                                    : 'Enter User Name',
                            // labelStyle: TextStyle(color: kColorPrimary),
                            contentPadding: EdgeInsets.zero,
                            hintText:
                                languageModel.languageResponseModel != null
                                    ? languageModel.languageResponseModel!
                                        .infoScreen.username
                                    : 'Username',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(width: 2, color: kColorPrimary)),
                            focusColor: kColorPrimary),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: kColorPrimary,
                            activeColor: Colors.white,
                            value: TCChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                TCChecked = value!;
                              });
                            },
                          ),
                          Text(languageModel.languageResponseModel != null
                              ? languageModel
                                  .languageResponseModel!.infoScreen.agree
                              : "I agree "),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          DataPolicyScreen()));
                            },
                            child: Text(
                              "Terms & Conditions",
                              style: TextStyle(
                                  color: kColorPrimary,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: kColorPrimary,
                            activeColor: Colors.white,
                            value: GDRPChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                GDRPChecked = value!;
                              });
                            },
                          ),
                          Text(languageModel.languageResponseModel != null
                              ? languageModel
                                  .languageResponseModel!.infoScreen.agree
                              : "I agree "),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          DataPolicyScreen()));
                            },
                            child: Text(
                              "GDRP Terms & Conditions",
                              style: TextStyle(
                                  color: kColorPrimary,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: InkWell(
                        onTap: () {
                          if (signUpUserNameController.text.isNotEmpty &&
                              TCChecked &&
                              GDRPChecked) {
                            moveToNextScreen(languageModel);
                          }
                        },
                        child: Container(
                            padding: const EdgeInsets.all(8.0),
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: signUpUserNameController
                                              .text.isNotEmpty &&
                                          TCChecked &&
                                          GDRPChecked
                                      ? kColorPrimary
                                      : Colors.grey,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(100),
                                color:
                                    signUpUserNameController.text.isNotEmpty &&
                                            TCChecked &&
                                            GDRPChecked
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
                                      languageModel.languageResponseModel !=
                                              null
                                          ? languageModel.languageResponseModel!
                                              .infoScreen.continueBtn
                                          : 'JOIN',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                            )),
                      ),
                    ),
                  ],
                ),
                Image.asset("assets/images/Mask Group 2.png"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
