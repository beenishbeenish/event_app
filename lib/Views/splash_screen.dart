import 'dart:async';
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:event_app/Provider/auth_class.dart';
import 'package:event_app/Provider/events_class.dart';
import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Views/enter_username_screen.dart';
import 'package:event_app/Views/first_info_screen.dart';
import 'package:event_app/Views/gallery_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';

import '../Provider/comments_class.dart';
import '../Provider/data_class.dart';
import '../Provider/greeting_class.dart';
import '../Provider/task_provider.dart';
import 'event_profile_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AnimationController _animationController;
  late Animation<double> _animation;

  getEventData() async {
    // AppGlobal.token= eventModal.joinEventResponseModel!.token;

    final eventModal = Provider.of<EventClass>(context, listen: false);
    final authModal = Provider.of<AuthClass>(context, listen: false);
    final languageModel = Provider.of<LanguageClass>(context, listen: false);
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? deviceId = await PlatformDeviceId.getDeviceId;

    // final String? eventId =  prefs.getString('event_id');
    // final String? token =  prefs.getString('token');
    // final String? profileImage =  prefs.getString('profile_image');
    // final String? coverImage =  prefs.getString('cover_image');
    // final String? welcomeImage =  prefs.getString('welcome_image');
    // final String? pId=prefs.getString('p_id');
    // final String? startedLanguage=prefs.getString('started_lang');
    // final String? lastUpdateApi=prefs.getString('last_updated_api');
    // final String? signtype=prefs.getString('sign_type');

    final String? eventId = await storage.read(key: 'event_id');
    final String? token = await storage.read(key: 'token');
    final String? profileImage = await storage.read(key: 'profile_image');
    final String? coverImage = await storage.read(key: 'cover_image');
    final String? welcomeImage = await storage.read(key: 'welcome_image');
    final String? pId = await storage.read(key: 'p_id');
    final String? startedLanguage = await storage.read(key: 'started_lang');
    final String? lastUpdateApi = await storage.read(key: 'last_updated_api');
    final String? signtype = await storage.read(key: 'sign_type');

    if (token != null) {
      try {
        await eventModal
            .getEventData(
                eventId: eventId.toString(),
                contextEventD: context,
                withoutPop: true,
                languageModal: languageModel)
            .then((value) async {
          if (eventModal.eventResponseModel?.status == true &&
              (eventModal.eventResponseModel?.message != 'Event is deleted' ||
                  eventModal.eventResponseModel?.message !=
                      'Event is no longer available')) {
            if (signtype != null) {
              authModal.getUserInfo(token: token, context: context);

              AppGlobal.sign_type = signtype.toString();
            } else {
              authModal.getlUserInfoWithoutLogin(
                  token: token, context: context);
              AppGlobal.sign_type = '';

              // authModal.authModel!.user=null;
              // authModal.authModel=null;
              //  print('>>>>>>>>>>>>>${jsonEncode( authModal.authModel!.user)}');
            }
            await storage.write(key: 'event_id', value: eventId);
            await storage.write(
                key: 'event_code',
                value: eventModal.eventResponseModel?.event!.eventCode);

            AppGlobal.eventCode =
                eventModal.eventResponseModel?.event!.eventCode ?? '';
            AppGlobal.eventId = eventId.toString();
            AppGlobal.token = token.toString();
            AppGlobal.pId = pId.toString();
            AppGlobal.profileImage = profileImage.toString();
            AppGlobal.welcomeImage = welcomeImage.toString();
            AppGlobal.coverImage = coverImage.toString();

            AppGlobal.startedLanguage =
                startedLanguage != null ? startedLanguage.toString() : 'ger';
            if (AppGlobal.startedLanguage == 'eng') {
              languageModel
                  .getOnlineLanguageResponse(
                      languagename: AppGlobal.startedLanguage,
                      contextVar: context)
                  .then((e) {
                if (languageModel.loading == false) {
                  languageModel.selectLanguage(
                      value: AppGlobal.startedLanguage);
                  print(
                      'Language set ................................................');
                }
                authModal
                    .getlAllChecksInfo(
                        token: AppGlobal.token,
                        eventId: AppGlobal.eventId,
                        context: context)
                    .then((e) {
                  if (AppGlobal.userName == '' || AppGlobal.userName == null) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) =>
                                const EnterUsernameScreen(title: 'Categories')),
                        (Route<dynamic> route) => false);
                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) =>
                                const EventProfileScreen(title: '')),
                        (Route<dynamic> route) => false);
                  }
                });
              });

              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              // const FirstInfoScreen()), (Route<dynamic> route) => false);

            } else {
              {
                languageModel
                    .getOnlineLanguageResponse(
                        languagename: 'ger', contextVar: context)
                    .then((e) {
                  if (languageModel.loading == false) {
                    languageModel.selectLanguage(
                        value: AppGlobal.startedLanguage);
                    print(
                        'Language set ................................................');
                  }
                  authModal
                      .getlAllChecksInfo(
                          token: AppGlobal.token,
                          eventId: AppGlobal.eventId,
                          context: context)
                      .then((e) {
                    if (AppGlobal.userName == '' ||
                        AppGlobal.userName == null) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const EnterUsernameScreen(
                                  title: 'Categories')),
                          (Route<dynamic> route) => false);
                    } else {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const EventProfileScreen(title: '')),
                          (Route<dynamic> route) => false);
                    }
                  });
                });

                // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                // const FirstInfoScreen()), (Route<dynamic> route) => false);

              }
            }
          } else {
            final String? startedLanguage =
                await storage.read(key: 'started_lang');
            AppGlobal.startedLanguage =
                startedLanguage != null ? startedLanguage.toString() : 'ger';
            if (AppGlobal.startedLanguage == 'eng') {
              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              // const FirstInfoScreen()), (Route<dynamic> route) => false);
              languageModel
                  .getOnlineLanguageResponse(
                      languagename: AppGlobal.startedLanguage,
                      contextVar: context)
                  .then((e) {
                if (languageModel.loading == false) {
                  languageModel.selectLanguage(
                      value: AppGlobal.startedLanguage);
                  print(
                      'Language set ................................................');
                }
                authModal
                    .getlAllChecksInfo(
                        token: AppGlobal.token,
                        eventId: AppGlobal.eventId,
                        context: context)
                    .then((e) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const FirstInfoScreen()),
                      (Route<dynamic> route) => false);
                });
              });
            } else {
              {
                // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                // const FirstInfoScreen()), (Route<dynamic> route) => false);
                languageModel
                    .getOnlineLanguageResponse(
                        languagename: 'ger', contextVar: context)
                    .then((e) {
                  if (languageModel.loading == false) {
                    languageModel.selectLanguage(
                        value: AppGlobal.startedLanguage);
                    print(
                        'Language set ................................................');
                  }
                  authModal
                      .getlAllChecksInfo(
                          token: AppGlobal.token,
                          eventId: AppGlobal.eventId,
                          context: context)
                      .then((e) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const FirstInfoScreen()),
                        (Route<dynamic> route) => false);
                  });
                });
              }
            }
          }
        });
      } catch (e) {
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        // const FirstInfoScreen()), (Route<dynamic> route) => false);
        final String? startedLanguage = await storage.read(key: 'started_lang');
        AppGlobal.startedLanguage =
            startedLanguage != null ? startedLanguage.toString() : 'ger';
        if (AppGlobal.startedLanguage == 'eng') {
          languageModel
              .getOnlineLanguageResponse(
                  languagename: AppGlobal.startedLanguage, contextVar: context)
              .then((e) {
            if (languageModel.loading == false) {
              languageModel.selectLanguage(value: AppGlobal.startedLanguage);
              print(
                  'Language set ................................................');
            }
            authModal
                .getlAllChecksInfo(
                    token: AppGlobal.token,
                    eventId: AppGlobal.eventId,
                    context: context)
                .then((e) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const FirstInfoScreen()),
                  (Route<dynamic> route) => false);
            });
          });
        } else {
          {
            languageModel
                .getOnlineLanguageResponse(
                    languagename: 'ger', contextVar: context)
                .then((e) {
              if (languageModel.loading == false) {
                languageModel.selectLanguage(value: AppGlobal.startedLanguage);
                print(
                    'Language set ................................................');
              }
              authModal
                  .getlAllChecksInfo(
                      token: AppGlobal.token,
                      eventId: AppGlobal.eventId,
                      context: context)
                  .then((e) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const FirstInfoScreen()),
                    (Route<dynamic> route) => false);
              });
            });
            // Navigator.pop(context);

          }
        }
      }
    } else {
      final String? startedLanguage = await storage.read(key: 'started_lang');
      AppGlobal.startedLanguage =
          startedLanguage != null ? startedLanguage.toString() : 'ger';

      if (AppGlobal.startedLanguage == 'eng') {
        languageModel
            .getOnlineLanguageResponse(
                languagename: AppGlobal.startedLanguage, contextVar: context)
            .then((e) {
          if (languageModel.loading == false) {
            languageModel.selectLanguage(value: AppGlobal.startedLanguage);
            print(
                'Language set ................................................');
          }
          authModal
              .getlAllChecksInfo(
                  token: AppGlobal.token,
                  eventId: AppGlobal.eventId,
                  context: context)
              .then((e) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const FirstInfoScreen()),
                (Route<dynamic> route) => false);
          });
        });
      } else {
        {
          languageModel
              .getOnlineLanguageResponse(
                  languagename: 'ger', contextVar: context)
              .then((e) {
            if (languageModel.loading == false) {
              languageModel.selectLanguage(value: AppGlobal.startedLanguage);
              print(
                  'Language set ................................................');
            }
            authModal
                .getlAllChecksInfo(
                    token: AppGlobal.token,
                    eventId: AppGlobal.eventId,
                    context: context)
                .then((e) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const FirstInfoScreen()),
                  (Route<dynamic> route) => false);
            });
          });
          // Navigator.pop(context);

        }
      }
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      // const FirstInfoScreen()), (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    super.initState();

    clearPreviousData();
    Timer(const Duration(seconds: 4), () async {
      getEventData();
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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final languageModal = Provider.of<LanguageClass>(context);

    return Scaffold(
      backgroundColor: kColorPrimary,
      body: Stack(
        children: [
          Container(
            width: screenSize.width,
            child: Image.asset(
              'assets/images/jstprty_splash_bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 20, horizontal: screenSize.width * 0.21),
                  child: DefaultTextStyle(
                    style: const TextStyle(
                        fontSize: 35.0, fontWeight: FontWeight.bold),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/Brush mark 1@4x.png',
                        ),
                        Image.asset(
                          'assets/icons/jstprty_logo_temp.png',
                          color: kColorPrimary,
                        ),
                      ],
                    ),
                  )

                  // Text(
                  //   'Event Management',
                  //   maxLines: 2,
                  //   textAlign: TextAlign.center,
                  //   style:
                  //       TextStyle(fontSize: _animation.value * 30, color: Colors.white),
                  // ),

                  ),
              SpinKitFadingCircle(
                size: 50,
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
