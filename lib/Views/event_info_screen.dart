import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/Provider/auth_class.dart';
import 'package:event_app/Provider/events_class.dart';
import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Views/gallery_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shimmer/shimmer.dart';

import '../Widegts/alert_popup_widget.dart';
import 'enter_username_screen.dart';

class EventInfoScreen extends StatefulWidget {
  const EventInfoScreen({Key? key, required this.title, eventId})
      : super(key: key);

  final String title;

  @override
  State<EventInfoScreen> createState() => _EventInfoScreenState();
}

class _EventInfoScreenState extends State<EventInfoScreen> {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    // final eventModal = Provider.of<EventClass>(context, listen: false);
    // eventModal.eventResponseModel = null;

    // Future.delayed(Duration.zero, () async {
    //   eventModal.getEventData(
    //       eventId: '639e0babc10c725bc6ef6423', context: context);
    // });

    ///ToDo: Uncomment this for dynamic
    // Future.delayed(Duration.zero, () async {
    //   eventModal.getEventData(eventId: AppGlobal.eventId, context: context);
    // });
  }

  dateFormat({required String datefrom, required String dateTo}) {
    final DateTime docDateTime = DateTime.parse(datefrom);
    final DateTime docDateTime1 = DateTime.parse(dateTo);
    return '${DateFormat('dd.MM.yyyy').format(docDateTime)}';
    // '${DateFormat('dd').format(docDateTime)}-${DateFormat('dd.MM.yyyy').format(docDateTime1)}';
  }

  moveToNextScreen() async {
    final eventModal = Provider.of<EventClass>(context, listen: false);
    final authModal = Provider.of<AuthClass>(context, listen: false);
    final languageModal = Provider.of<LanguageClass>(context, listen: false);

    if (eventModal.eventResponseModel?.message == 'Event is deleted' ||
        eventModal.eventResponseModel?.message ==
            'Event is no longer available') {
      final languageModal = Provider.of<LanguageClass>(context, listen: false);
      Navigator.pop(context);
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertPopup(
              title: languageModal.languageResponseModel != null
                  ? languageModal.languageResponseModel!.infoScreen.joinError
                  : 'Event is deleted!',
              content: languageModal.languageResponseModel != null
                  ? languageModal
                      .languageResponseModel!.infoScreen.joiningErrMsg
                  : 'Please scan and join another event',
            );
          });
    } else {
      String? deviceId = await PlatformDeviceId.getDeviceId;
      await eventModal.getJoinEventData(
          eventId: eventModal.eventResponseModel!.event!.id,
          deviceId: deviceId.toString(),
          context: context);
      if (eventModal.joinEventResponseModel?.status == true) {
        await storage.write(
            key: 'token', value: eventModal.joinEventResponseModel!.token);
        await storage.write(
            key: 'profile_image',
            value: eventModal.eventResponseModel != null
                ? eventModal.eventResponseModel!.event!.profileImage
                : '');
        await storage.write(
            key: 'cover_image',
            value: eventModal.eventResponseModel != null
                ? eventModal.eventResponseModel!.event!.coverImage
                : '');
        await storage.write(
            key: 'welcome_image',
            value: eventModal.eventResponseModel != null
                ? eventModal.eventResponseModel!.event!.welcomeImage
                : '');
        await storage.write(
            key: 'event_id',
            value: eventModal.eventResponseModel != null
                ? eventModal.eventResponseModel!.event!.id
                : '');
        await storage.write(
            key: 'p_id',
            value: eventModal.joinEventResponseModel != null
                ? eventModal.joinEventResponseModel!.jointEvent.id
                : '');

        AppGlobal.welcomeImage = eventModal.eventResponseModel != null
            ? eventModal.eventResponseModel!.event!.welcomeImage
            : '';
        AppGlobal.coverImage = eventModal.eventResponseModel != null
            ? eventModal.eventResponseModel!.event!.coverImage
            : '';
        AppGlobal.profileImage = eventModal.eventResponseModel != null
            ? eventModal.eventResponseModel!.event!.profileImage
            : '';
        AppGlobal.token = eventModal.joinEventResponseModel!.token;
        AppGlobal.eventId = eventModal.eventResponseModel != null
            ? eventModal.eventResponseModel!.event!.id
            : '';

        AppGlobal.pId = eventModal.joinEventResponseModel != null
            ? eventModal.joinEventResponseModel!.jointEvent.id
            : '';

        authModal
            .getlAllChecksInfo(
                token: AppGlobal.token,
                eventId: AppGlobal.eventId,
                context: context)
            .then((e) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const EnterUsernameScreen(
                        title: ' ',
                      )),
              (Route<dynamic> route) => false);

          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          // const GalleryScreen(title: 'Categories')), (Route<dynamic> route) => false);
        });
        // WidgetsBinding.instance.addPostFrameCallback((_) {

        // });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final eventModal = Provider.of<EventClass>(context);
    // print('your data....qqq ${eventModal.eventResponseModel?.events[0].id}');
    final languageModel = Provider.of<LanguageClass>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset("assets/images/Mask Group 2.png"),
          Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.09,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_left_rounded,
                        color: kColorPrimary,
                        size: 35,
                      )),
                  Container(
                    width: screenSize.width * 0.7,
                    child: Text(
                      eventModal.eventResponseModel?.event != null
                          ? '${eventModal.eventResponseModel?.event!.generalInfo.eventName.toString()}'
                          : '',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 23, color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
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
                    borderRadius: BorderRadius.all(const Radius.circular(18)),
                    child: CachedNetworkImage(
                      imageUrl: eventModal.eventResponseModel != null
                          ? eventModal.eventResponseModel!.event != null
                              ? eventModal.eventResponseModel!.event!.coverImage
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
              const SizedBox(
                height: 20,
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
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset(
                          "assets/icons/Icon material-date-range.svg",
                          color: kColorPrimary,
                          height: 20,
                          width: 20,
                          semanticsLabel: ''),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(eventModal.eventResponseModel?.event != null
                          ? '${dateFormat(datefrom: '${eventModal.eventResponseModel?.event!.generalInfo.dateFrom.toString()}', dateTo: '${eventModal.eventResponseModel?.event!.generalInfo.dateTo.toString()}')}'
                          : '00:00')
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     SvgPicture.asset("assets/icons/Icon ionic-md-time.svg",
                  //         color: kColorPrimary,
                  //         height: 20,
                  //         width: 20,
                  //         semanticsLabel: ''),
                  //     const SizedBox(
                  //       height: 5,
                  //     ),
                  //     Text(eventModal.eventResponseModel?.event != null
                  //         ? '${eventModal.eventResponseModel?.event!.generalInfo.timeFrom.toString()} - ${eventModal.eventResponseModel?.event!.generalInfo.timeTo.toString()}'
                  //         : '')
                  //   ],
                  // ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: InkWell(
                  onTap: () {
                    moveToNextScreen();
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: kColorPrimary,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(100),
                          color: kColorPrimary,
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
                                itemBuilder: (BuildContext context, int index) {
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              )
                            : Text(
                                languageModel.languageResponseModel != null
                                    ? languageModel.languageResponseModel!
                                        .infoScreen.joinEventBtn
                                    : 'JOIN EVENT',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                      )),
                ),
              ),
            ],
          ),
          // SizedBox(height:screenSize.height*0.134,),
        ],
      ),
    );
  }
}
