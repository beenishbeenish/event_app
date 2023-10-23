import 'package:event_app/DataModelClasses/all_checks_response.dart';
import 'package:event_app/DataModelClasses/all_greeting_response_model.dart';
import 'package:event_app/DataModelClasses/all_image_details_response_model.dart';
import 'package:event_app/DataModelClasses/greeting_save_response_model.dart';
import 'package:event_app/DataModelClasses/like_response_model.dart';
import 'package:event_app/DataModelClasses/post_comment_response_model.dart';
import 'package:event_app/DataModelClasses/view_comments_likes_response_model.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Utils/web_services.dart';
import 'package:event_app/Widegts/alert_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Views/first_info_screen.dart';
import 'language_class.dart';

class GreetingClass extends ChangeNotifier {
  GreetingSaveResponseModel? greetingSaveResponseModel;
  AllGreetingResponse? allGreetingResponse;
  AllChecksResponseModel? checksResponseModel;
  bool loading = false;
  bool showAddButton = true;
  List<XFile>? image = [];
  bool isVideoAdded = false;

  getImageAddress(url) {
    image = (image! + url);
    notifyListeners();
  }

  removeImageAddress(index) {
    image!.removeAt(index);
    // image!.addAll(url);
    notifyListeners();
  }

  refreshScreen() {
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

  saveGreeting(
      {required String eventId,
      required List<XFile> imageAdress,
      required String title,
      required String description,
      required String token,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();

    dynamic data = (await getGreetingSaveWeb(
        eventId: eventId,
        title: title,
        description: description,
        imageUri: imageAdress,
        token: token,
        context: context))!;

    if (data['status'] == true) {
      greetingSaveResponseModel = GreetingSaveResponseModel.fromJson(data);
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
              content: '${greetingSaveResponseModel.message}',
            );
          });
      loading = false;
      notifyListeners();
    }
  }

  videoAdded(video) {
    isVideoAdded = video;
  }

  deleteGreeting(
      {required String greetingId,
      required String token,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();
    greetingSaveResponseModel = await getGreetingDeleteWeb(
        token: token, greetingId: greetingId, context: context);
    loading = false;
    allGreetingResponse = null;
    showAddButton = true;
    notifyListeners();
  }

  getAllGreetings(
      {required String eventId,
      required String token,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();
    allGreetingResponse = (await getAllGreetingSaveWeb(
        eventId: eventId, token: token, context: context));
    if (allGreetingResponse != null) {
      if (allGreetingResponse!.message == 'Event is deleted') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const FirstInfoScreen()),
            (Route<dynamic> route) => false);
        final languageModal =
            Provider.of<LanguageClass>(context, listen: false);

        showDialog(
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
      }
      if (allGreetingResponse!.greetings == null) {
        showAddButton = true;
      } else {
        showAddButton = false;
      }
    }
    loading = false;
    notifyListeners();
    // notifyListeners();
  }
}
