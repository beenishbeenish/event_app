import 'dart:convert';
import 'dart:io';

import 'package:better_video_player/better_video_player.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:event_app/Provider/data_class.dart';
import 'package:event_app/Provider/events_class.dart';
import 'package:event_app/Provider/greeting_class.dart';
import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Widegts/alert_popup_widget.dart';
import 'package:event_app/Widegts/image_popup_widget.dart';
import 'package:event_app/Widegts/submit_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddMoreGreetingsScreen extends StatefulWidget {
  const AddMoreGreetingsScreen({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<AddMoreGreetingsScreen> createState() => _AddMoreGreetingsScreenState();
}

class _AddMoreGreetingsScreenState extends State<AddMoreGreetingsScreen> {
  TextEditingController highLightController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late BetterVideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = BetterVideoPlayerController();

    final greetingModel = Provider.of<GreetingClass>(context, listen: false);
    greetingModel.videoAdded(false);
    // print(',,,,,,,,,,,,,,,,,,,,,sks...................');
    greetingModel.image = [];
    Future.delayed(Duration.zero, () async {
      greetingModel.deleteAllProviderData();
    });
    Future.delayed(Duration.zero, () async {
      greetingModel.getlAllChecksInfo(
          token: AppGlobal.token, eventId: AppGlobal.eventId, context: context);
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  getGalleryVideo(languageModel) async {
    print('gallery');

    final greetingModel = Provider.of<GreetingClass>(context, listen: false);
    //final languageModel = Provider.of<LanguageClass>(context);
    List<XFile>? imageFileList = [];
    final picker = ImagePicker();
    final XFile? video = await picker.pickVideo(
      source: ImageSource.gallery,
    );
    // await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    // print('image...${pickedFile.toString()}');

    if (video != null) {
      if (imageFileList.length <= 5 &&
          imageFileList.length + greetingModel.image!.length <= 6 &&
          greetingModel.isVideoAdded == false) {
        imageFileList.add(video);
        print('videos....${video.path}');
        greetingModel.videoAdded(true);
        greetingModel.getImageAddress(imageFileList);
      } else {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertPopup(
                title: languageModel.languageResponseModel != null
                    ? languageModel.languageResponseModel!.infoScreen.warning
                    : 'Warning!',
                content: languageModel.languageResponseModel != null
                    ? languageModel
                        .languageResponseModel!.mobileGreetings.maxVideos
                    : 'You can only add 1 video.',
              );
            });
      }
    } else {
      print('No image selected.');
    }
  }

  getGalleryImage(languageModel) async {
    print('gallery');
    final greetingModel = Provider.of<GreetingClass>(context, listen: false);
    // final languageModel = Provider.of<LanguageClass>(context);
    final picker = ImagePicker();
    final List<XFile>? selectedImages =
        await picker.pickMultiImage(imageQuality: 50);
    // await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    // print('image...${pickedFile.toString()}');

    if (selectedImages!.isNotEmpty) {
      if (greetingModel.isVideoAdded == false) {
        if (greetingModel.image!.length < 5) {
          print('gallery if........');
          if (selectedImages.length <= 5 &&
              selectedImages.length + greetingModel.image!.length <= 5) {
            print('gallery if..... if........');

            // imageFileList.addAll(selectedImages);
            greetingModel.getImageAddress(selectedImages);
            print("Image List Length:" + selectedImages.length.toString());
          } else {
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertPopup(
                    title: languageModel.languageResponseModel != null
                        ? '${languageModel.languageResponseModel!.infoScreen.warning}!'
                        : 'Warning!',
                    content: languageModel.languageResponseModel != null
                        ? languageModel
                            .languageResponseModel!.mobileGreetings.maxImages
                        : 'Please Select maximum 5 images \nat a time.',
                  );
                });
          }
        } else {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertPopup(
                  title: languageModel.languageResponseModel != null
                      ? languageModel.languageResponseModel!.infoScreen.warning
                      : 'Warning!',
                  content: languageModel.languageResponseModel != null
                      ? languageModel
                          .languageResponseModel!.mobileGreetings.maxImages
                      : 'Please Select maximum 5 images \nat a time.',
                );
              });
        }
      } else {
        if (greetingModel.image!.length < 6) {
          print('gallery if........');
          if (selectedImages.length <= 6 &&
              selectedImages.length + greetingModel.image!.length <= 6) {
            print('gallery if..... if........');

            // imageFileList.addAll(selectedImages);
            greetingModel.getImageAddress(selectedImages);
            print("Image List Length:" + selectedImages.length.toString());
          } else {
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertPopup(
                    title: languageModel.languageResponseModel != null
                        ? languageModel
                            .languageResponseModel!.infoScreen.warning
                        : 'Warning!',
                    content: languageModel.languageResponseModel != null
                        ? languageModel
                            .languageResponseModel!.mobileGreetings.maxImages
                        : 'Please Select maximum 5 images \nat a time.',
                  );
                });
          }
        } else {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertPopup(
                  title: languageModel.languageResponseModel != null
                      ? languageModel.languageResponseModel!.infoScreen.warning
                      : 'Warning!',
                  content: languageModel.languageResponseModel != null
                      ? languageModel
                          .languageResponseModel!.widgetAlerts.selectMax
                      : 'Please Select maximum 5 images \nat a time.',
                );
              });
        }
      }
    } else {
      print('No image selected.');
    }
  }

  getCameraImage(languageModel) async {
    List<XFile>? imageFileList = [];
    final greetingModel = Provider.of<GreetingClass>(context, listen: false);
    // final languageModel = Provider.of<LanguageClass>(context);
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      if (greetingModel.isVideoAdded == false) {
        if (greetingModel.image!.length < 5) {
          print('gallery if........');

          if (imageFileList.length <= 5 &&
              imageFileList.length + greetingModel.image!.length <= 5) {
            print(
              'Images.. less than 5',
            );
            imageFileList.add(pickedFile);
            // imageFileList.add(pickedFile);
            greetingModel.getImageAddress(imageFileList);
            print("Image List Length:" + imageFileList.length.toString());
          } else {
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertPopup(
                    title: languageModel.languageResponseModel != null
                        ? languageModel
                            .languageResponseModel!.infoScreen.warning
                        : 'Warning!',
                    content: languageModel.languageResponseModel != null
                        ? languageModel
                            .languageResponseModel!.mobileGreetings.maxImages
                        : 'Please Select maximum 5 images \nat a time.',
                  );
                });
          }
        } else {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertPopup(
                  title: languageModel.languageResponseModel != null
                      ? languageModel.languageResponseModel!.infoScreen.warning
                      : 'Warning!',
                  content: languageModel.languageResponseModel != null
                      ? languageModel
                          .languageResponseModel!.mobileGreetings.maxImages
                      : 'Please Select maximum 5 images \nat a time.',
                );
              });
        }
      } else {
        if (greetingModel.image!.length < 6) {
          print('gallery if........');

          if (imageFileList.length <= 6 &&
              imageFileList.length + greetingModel.image!.length <= 6) {
            print(
              'Images.. less than 5',
            );
            imageFileList.add(pickedFile);
            // imageFileList.add(pickedFile);
            greetingModel.getImageAddress(imageFileList);
            print("Image List Length:" + imageFileList.length.toString());
          } else {
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertPopup(
                    title: languageModel.languageResponseModel != null
                        ? languageModel
                            .languageResponseModel!.infoScreen.warning
                        : 'Warning!',
                    content: languageModel.languageResponseModel != null
                        ? languageModel
                            .languageResponseModel!.mobileGreetings.maxImages
                        : 'Please Select maximum 5 images \nat a time.',
                  );
                });
          }
        } else {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertPopup(
                  title: languageModel.languageResponseModel != null
                      ? languageModel.languageResponseModel!.infoScreen.warning
                      : 'Warning!',
                  content: languageModel.languageResponseModel != null
                      ? languageModel
                          .languageResponseModel!.mobileGreetings.maxImages
                      : 'Please Select maximum 5 images \nat a time.',
                );
              });
        }
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
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final eventModel = Provider.of<EventClass>(context);
    final greetingModel = Provider.of<GreetingClass>(context);
    final languageModel = Provider.of<LanguageClass>(context);
    return Scaffold(
      backgroundColor: kColorBackGround,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
          languageModel.languageResponseModel != null
              ? languageModel.languageResponseModel!.mobileGreetings.addGreeting
              : 'Add Greeting',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kColorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                eventModel.eventResponseModel != null
                    ? eventModel
                        .eventResponseModel!.event!.generalInfo.eventName
                    : '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: kColorBrownText,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                languageModel.languageResponseModel != null
                    ? languageModel
                        .languageResponseModel!.mobileGreetings.highlightQuote
                    : 'Highlight quote',
                style: const TextStyle(
                  color: kColorGreyText,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: screenSize.width,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    controller: highLightController,
                    //focusNode: fObservation,
                    maxLength: 30,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (value) {
                      setState(() {
                        //charLength = value.length;
                      });
                      //print('$value,$charLength');
                    },
                    maxLines: 1,
                    cursorColor: kColorPrimary,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      // hintText: getTranslated(context,
                      //     'typeherestartdictation'),
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 20, 40, 0),
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                languageModel.languageResponseModel != null
                    ? languageModel
                        .languageResponseModel!.mobileGreetings.description
                    : 'Description',
                style: const TextStyle(
                  color: kColorGreyText,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: screenSize.height * 0.2,
                width: screenSize.width,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    controller: descriptionController,
                    //focusNode: fObservation,
                    // maxLength: 200,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (value) {
                      setState(() {
                        //charLength = value.length;
                      });
                      //print('$value,$charLength');
                    },
                    maxLines: 8,
                    cursorColor: kColorPrimary,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      // hintText: getTranslated(context,
                      //     'typeherestartdictation'),
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 20, 40, 0),
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            greetingModel.image!.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ImagePopup(
                                onVideoPress: () {
                                  getGalleryVideo(languageModel);
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
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                languageModel.languageResponseModel != null
                                    ? languageModel.languageResponseModel!
                                        .mobileGreetings.upload
                                    : 'UPLOAD IMAGES/VIDEOS',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: kColorPrimary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      child: SingleChildScrollView(
                        child: GridView.builder(
                          itemCount: greetingModel.image!.length + 1,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 25 / 26,
                                  crossAxisSpacing: 8,
                                  crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int index) {
                            return index == greetingModel.image!.length
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 5),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ImagePopup(
                                                onVideoPress: () {
                                                  getGalleryVideo(
                                                      languageModel);
                                                },
                                                onCameraPress: () {
                                                  getCameraImage(languageModel);
                                                },
                                                onGalleryPress: () {
                                                  getGalleryImage(
                                                      languageModel);
                                                },
                                              );
                                            });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: kColorPrimary,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          // color: Colors.black,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: kColorPrimary,
                                          size: 70,
                                        ),
                                      ),
                                    ),
                                  )
                                : greetingModel.image![index].path
                                            .contains('.mp4') ||
                                        greetingModel.image![index].path
                                            .contains('.MOV')
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Stack(
                                          children: [
                                            Container(
                                              // padding: EdgeInsets.symmetric(vertical: 10),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: kColorPrimary,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: BetterVideoPlayer(
                                                  controller: controller,
                                                  configuration:
                                                      BetterVideoPlayerConfiguration(
                                                          autoPlay: false,
                                                          looping: false,
                                                          controls:
                                                              BetterVideoPlayerControls(
                                                            isFullScreen: false,
                                                          )
                                                          // controls: const _CustomVideoPlayerControls(),
                                                          ),
                                                  dataSource:
                                                      BetterVideoPlayerDataSource(
                                                          BetterVideoPlayerDataSourceType
                                                              .file,
                                                          greetingModel
                                                              .image![index]
                                                              .path),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                right: -5,
                                                top: -4,
                                                child: IconButton(
                                                    onPressed: () {
                                                      if (greetingModel
                                                              .image![index]
                                                              .path
                                                              .contains(
                                                                  '.mp4') ||
                                                          greetingModel
                                                              .image![index]
                                                              .path
                                                              .contains(
                                                                  '.MOV')) {
                                                        controller =
                                                            BetterVideoPlayerController();
                                                        greetingModel
                                                            .videoAdded(false);
                                                        greetingModel
                                                            .removeImageAddress(
                                                                index);
                                                      } else {
                                                        greetingModel
                                                            .removeImageAddress(
                                                                index);
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      Icons.close,
                                                      color: kColorPrimary,
                                                    )))
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 5),
                                        child: InkWell(
                                          onTap: () {},
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: kColorPrimary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  // color: Colors.black,
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                      File(greetingModel
                                                          .image![index].path),
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  right: -5,
                                                  top: -4,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        greetingModel
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
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                languageModel.languageResponseModel != null
                    ? languageModel.languageResponseModel!.mobileGreetings.note
                    : 'Note',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, color: kColorPrimary),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Text(
                  eventModel.eventResponseModel != null
                      ? eventModel
                          .eventResponseModel!.event!.generalInfo.description
                      : '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: InkWell(
                onTap: eventModel.loading
                    ? () {}
                    : () async {
                        if (highLightController.text.isEmpty ||
                            descriptionController.text.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertPopup(
                                  title: languageModel.languageResponseModel !=
                                          null
                                      ? languageModel.languageResponseModel!
                                          .infoScreen.warning
                                      : 'Warning!',
                                  content:
                                      languageModel.languageResponseModel !=
                                              null
                                          ? languageModel.languageResponseModel!
                                              .infoScreen.warningMsg
                                          : 'Please Fill all fields \n ',
                                );

                                ///info screen
                              });
                        } else if (greetingModel.image!.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertPopup(
                                  title: languageModel.languageResponseModel !=
                                          null
                                      ? languageModel.languageResponseModel!
                                          .infoScreen.warning
                                      : 'Warning!',
                                  content:
                                      languageModel.languageResponseModel !=
                                              null
                                          ? languageModel.languageResponseModel!
                                              .mobileGreetings.minMedia
                                          : 'Please upload at least one image.',
                                );
                              });
                        } else {
                          greetingModel.loading = true;
                          final postModel =
                              Provider.of<DataClass>(context, listen: false);
                          postModel
                              .getEventInfoByID(
                            eventId: AppGlobal.eventId,
                            uploadedMediaLength: greetingModel.image!.length,
                            context: context,
                          )
                              .then((value) {
                            if (checkMediaMaxLimit(
                                greetingModel.image!.length)) {
                              greetingModel
                                  .saveGreeting(
                                      imageAdress: greetingModel.image!,
                                      context: context,
                                      eventId: AppGlobal.eventId,
                                      description:
                                          descriptionController.text.toString(),
                                      title:
                                          highLightController.text.toString(),
                                      token: AppGlobal.token)
                                  .then((e) {
                                greetingModel.loading = false;
                                highLightController.clear();
                                descriptionController.clear();
                                greetingModel.image = [];
                                Navigator.of(context).pop(true);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SubmitPopup(
                                        title: languageModel
                                                    .languageResponseModel !=
                                                null
                                            ? languageModel
                                                .languageResponseModel!
                                                .mobileGreetings
                                                .greetingCreated
                                            : 'Greeting created!',
                                        icon: true,
                                        iconname: Icons.check_circle_rounded,
                                        content: languageModel
                                                    .languageResponseModel !=
                                                null
                                            ? languageModel
                                                .languageResponseModel!
                                                .mobileGreetings
                                                .successMsg
                                            : 'Greeting created successfully.',
                                      );
                                    });
                              }).catchError((e) {
                                greetingModel.loading = false;
                              });
                            } else {
                              greetingModel.loading = false;
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertPopup(
                                      content:
                                          languageModel.languageResponseModel !=
                                                  null
                                              ? languageModel
                                                  .languageResponseModel!
                                                  .mobileGreetings
                                                  .successMsg
                                              : 'Media limit exceeded',
                                    );
                                  });
                            }
                          });
                        }
                      },
                child: Container(
                    width: screenSize.width,
                    height: 50,
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
                            blurRadius: 2,
                            offset: Offset(0, 4),
                          )
                        ]),
                    child: greetingModel.loading
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
                        : Center(
                            child: Text(
                            languageModel.languageResponseModel != null
                                ? languageModel.languageResponseModel!
                                    .mobileGreetings.submit
                                : 'SUBMIT',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ))),
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
