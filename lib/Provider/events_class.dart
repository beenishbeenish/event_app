import 'dart:convert';
import 'dart:io';

import 'package:event_app/DataModelClasses/all_image_details_response_model.dart';
import 'package:event_app/DataModelClasses/check_task_complete_response_model.dart';
import 'package:event_app/DataModelClasses/event_response_modal.dart';
import 'package:event_app/DataModelClasses/greeting_save_response_model.dart';
import 'package:event_app/DataModelClasses/guest_response_modal.dart';
import 'package:event_app/DataModelClasses/image_upload_response_model.dart';
import 'package:event_app/DataModelClasses/join_event_response_model.dart';
import 'package:event_app/DataModelClasses/like_response_model.dart';
import 'package:event_app/DataModelClasses/post_comment_response_model.dart';
import 'package:event_app/DataModelClasses/random_task_response_modal.dart';
import 'package:event_app/DataModelClasses/task_completed_details_response_model.dart';
import 'package:event_app/DataModelClasses/task_completed_response_model.dart';
import 'package:event_app/DataModelClasses/view_comments_likes_response_model.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Utils/web_services.dart';
import 'package:event_app/Views/first_info_screen.dart';
import 'package:event_app/Widegts/alert_popup_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../DataModelClasses/all_checks_response.dart';
import '../DataModelClasses/username_set_response.dart';
import 'language_class.dart';

class EventClass extends ChangeNotifier {
  EventResponseModel? eventResponseModel;
  JoinEventResponseModel? joinEventResponseModel;
  UsernameSetResponse? usernameSetResponse;
  ImageUploadModel? imageUploadModel;
  TaskCompletedResponseModel? taskCompletedResponseModel;
  GuestCountResponseModel? guestCountResponseModel;
  TaskCompletedDetailsResponseModel? taskCompletedDetailsResponseModel;
  PostCommentResponseModel? postCommentResponseModel;
  ViewCommentLikesResponseModel? viewCommentLikesResponseModel;
  bool loading = false;
  int currentPage = 0;
  String commentText = '';
  bool clickLike = false;
  int likesCount = 0;
  bool isVideoAdded = false;
  bool alreadyLiked = false;
  LikeResponseModel? likeResponseModel;
  bool randomTasksSelected = false;
  AllChecksResponseModel? checksResponseModel;

  // XFile? image=[];
  List<XFile>? image = [];

  getEventData(
      {required String eventId,
      var contextEventD,
      bool withoutPop = false,
      required LanguageClass languageModal}) async {
    loading = true;
    notifyListeners();
    eventResponseModel =
        await getEventDataWeb(eventId: eventId, context: contextEventD);
    if (eventResponseModel != null) {
      if (eventResponseModel!.event != null) {
        AppGlobal.profileImage = eventResponseModel!.event!.profileImage;
      }
    }
    loading = false;
    if (contextEventD != null) {
      if (eventResponseModel?.message == 'Event is deleted' ||
          eventResponseModel?.message == 'Event is no longer available') {
        // final languageModal =
        //     Provider.of<LanguageClass>(context, listen: false);
        if (withoutPop == false) {
          loading = false;
          notifyListeners();
          Navigator.pop(contextEventD);
        }
        if (eventResponseModel?.message == 'Event is deleted') {
          return showDialog(
              context: contextEventD,
              builder: (BuildContext context) {
                return AlertPopup(
                  title: languageModal.languageResponseModel != null
                      ? languageModal
                          .languageResponseModel!.infoScreen.joinError
                      : 'Event is deleted!',
                  content: languageModal.languageResponseModel != null
                      ? languageModal
                          .languageResponseModel!.infoScreen.joiningErrMsg
                      : 'Please scan and join another event',
                );
              });
        } else {
          return showDialog(
              context: contextEventD,
              builder: (BuildContext context) {
                return AlertPopup(
                  title: languageModal.languageResponseModel != null
                      ? languageModal
                          .languageResponseModel!.generalMessages.notAvailable
                      : 'Event is no longer available!',
                  content: languageModal.languageResponseModel != null
                      ? languageModal
                          .languageResponseModel!.infoScreen.joiningErrMsg
                      : 'Please scan and join another event',
                );
              });
        }
      }
    }
    loading = false;
    notifyListeners();

    // notifyListeners();
  }

  getEventDataOnJoinWithCode({required String eventId, var context}) async {
    loading = true;
    notifyListeners();
    eventResponseModel =
        await getEventDataOnJoinWithCodeApi(eventId: eventId, context: context);
    if (eventResponseModel != null) {
      if (eventResponseModel!.event != null) {
        AppGlobal.profileImage = eventResponseModel!.event!.profileImage;
      }
    }
    loading = false;
    if (context != null) {
      if (eventResponseModel?.message == 'Event is deleted' ||
          eventResponseModel?.message == 'Event is no longer available') {
        final languageModal =
            Provider.of<LanguageClass>(context, listen: false);
        if (eventResponseModel?.message == 'Event is deleted') {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertPopup(
                  title: languageModal.languageResponseModel != null
                      ? languageModal
                          .languageResponseModel!.infoScreen.joinError
                      : 'Event is deleted!',
                  content: languageModal.languageResponseModel != null
                      ? languageModal
                          .languageResponseModel!.infoScreen.joiningErrMsg
                      : 'Please scan and join another event',
                );
              });
        } else {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertPopup(
                  title: languageModal.languageResponseModel != null
                      ? languageModal
                          .languageResponseModel!.generalMessages.notAvailable
                      : 'Event is no longer available!',
                  content: languageModal.languageResponseModel != null
                      ? languageModal
                          .languageResponseModel!.infoScreen.joiningErrMsg
                      : 'Please scan and join another event',
                );
              });
        }
      }
    }
    loading = false;
    notifyListeners();

    // notifyListeners();
  }

  getJoinEventData(
      {required String eventId,
      required String deviceId,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();
    dynamic data = (await getJoinEventDataWeb(
        eventId: eventId, deviceId: deviceId, context: context))!;
//if(jsonDecode(data.status)==false)
    if (data['status'] == false) {
      GreetingSaveResponseModel greetingSaveResponseModel =
          GreetingSaveResponseModel.fromJson(data);

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertPopup(
              title: 'Sorry',
              icon: false,
              content: greetingSaveResponseModel.message,
            );
          });
      loading = false;
      notifyListeners();
    } else {
      joinEventResponseModel = JoinEventResponseModel.fromJson(data);
      loading = false;
      notifyListeners();
    }

    loading = false;
    notifyListeners();
  }

  setUsername(
      {required String username,
      required String deviceId,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();
    dynamic data = await setUserNameWebService(
        username: username, deviceId: deviceId, context: context);

    if (data != null) {
      usernameSetResponse = UsernameSetResponse.fromJson(data);
    }
    loading = false;
    notifyListeners();
  }

  postTheComment(
      {required String imageId,
      required String token,
      required BuildContext context,
      required String commentText}) async {
    // loading=true;
    notifyListeners();
    postCommentResponseModel = (await PostCommentWeb(
        context: context,
        imageId: imageId,
        token: token,
        commentText: commentText))!;

    loading = false;
    notifyListeners();
  }

  updatePageIndex(index) {
    currentPage = index;
    notifyListeners();
  }

  deleteAllProviderData() {
    image = [];
    isVideoAdded = false;
  }

  getlAllChecksInfo(
      {required String token,
      required String eventId,
      required context}) async {
    loading = true;
    notifyListeners();
    checksResponseModel = await getAllCheckResponseWeb(
        token: token, eventId: eventId, context: context);
    loading = false;
    notifyListeners();
  }

  videoAdded(video) {
    isVideoAdded = video;
  }

  getLikeResponse(
      {required String imageId,
      required String token,
      required BuildContext context}) async {
    clickLike = false;
    notifyListeners();
    likeResponseModel = await getLikeResponseWeb(
        imageId: imageId, token: token, context: context);

    if (likeResponseModel != null) {
      if (likeResponseModel!.liked) {
        clickLike = true;
      } else {
        clickLike = false;
      }
    }
    clickLike = false;
    notifyListeners();
  }

  refreshScreenState() {
    notifyListeners();
  }

//..............................Tasks...........................

  randomTaskComplete(
      {required String pId,
      required String taskId,
      required String token,
      required BuildContext context}) async {
    loading = true;
    taskCompletedResponseModel = (await taskCompletedResponseWeb(
        pId: pId, taskId: taskId, token: token, context: context))!;
    loading = false;
    notifyListeners();
  }

  getCommentS({
    required String imageId,
    required String token,
    required BuildContext context,
  }) async {
    loading = true;
    notifyListeners();
    viewCommentLikesResponseModel = (await getCommentWeb(
      imageId: imageId,
      context: context,
      token: token,
    ))!;
    notifyListeners();
    loading = false;
    notifyListeners();
  }

  alertDialogue({context, title, onPressOk, content}) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              FlatButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    onPressOk();
                    Navigator.of(context).pop();
                  })
            ],
            // AlertDialogAction(
            //   child: Text('ok'),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // )
          );
        });
    notifyListeners();
  }

  //........................Image Upload...........................

  getImageAddress(url) {
    image = (image! + url);
    // image!.addAll(url);
    print('images lenght,,,,,,,,,,,1,,${image}');
    notifyListeners();
  }

  removeImageAddress(index) {
    image!.removeAt(index);
    notifyListeners();
  }

  getImageUriData(
      {required List<XFile> imageAdress,
      required String pid,
      required String taskId,
      required String token,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();

    dynamic data = (await getImageUrlWeb(
        imageUri: imageAdress,
        pid: pid,
        taskId: taskId,
        token: token,
        context: context));
    print('data................$data');
    if (data['status'] == true) {
      imageUploadModel = ImageUploadModel.fromJson(data);
      loading = false;
      notifyListeners();
    } else {
      GreetingSaveResponseModel greetingSaveResponseModel =
          GreetingSaveResponseModel.fromJson(data);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertPopup(
              title: 'Sorry',
              icon: false,
              content: greetingSaveResponseModel.message,
            );
          });
      loading = false;
      notifyListeners();
    }
  }

  //...............Guests..................
  getGuestCount(
      {required String eventId,
      required String token,
      required BuildContext context}) async {
    loading = true;
    guestCountResponseModel = (await getGuestCountWeb(
        eventId: eventId, token: token, context: context));
    if (guestCountResponseModel != null) {
      AppGlobal.profileImage = guestCountResponseModel!.profileImage!;
    }
    loading = false;
    notifyListeners();
  }
//....................Image Detail..............................

}
