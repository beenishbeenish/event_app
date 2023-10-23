import 'package:dio/dio.dart';
import 'package:event_app/DataModelClasses/all_checks_response.dart';
import 'package:event_app/DataModelClasses/all_tasks_completed_response_model.dart';
import 'package:event_app/DataModelClasses/check_task_complete_response_model.dart';
import 'package:event_app/DataModelClasses/delete_response.dart';
import 'package:event_app/DataModelClasses/greeting_save_response_model.dart';
import 'package:event_app/DataModelClasses/like_response_model.dart';
import 'package:event_app/DataModelClasses/random_task_response_modal.dart';
import 'package:event_app/DataModelClasses/task_completed_details_response_model.dart';
import 'package:event_app/DataModelClasses/task_completed_response_model.dart';
import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Utils/web_services.dart';
import 'package:event_app/Widegts/alert_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../Views/first_info_screen.dart';

class TaskProvider extends ChangeNotifier {
  bool loading = false;
  bool isClicked = true;
  bool isTaskCompleted = false;
  // bool completedTasksSelected = true;
  AllChecksResponseModel? checksResponseModel;
  TaskCompletedResponseModel? taskCompletedResponseModel;
  TaskCompletedDetailsResponseModel? taskCompletedDetailsResponseModel;
  DeleteResponse? deleteResponse;
  int likesCount = 0;
  LikeResponseModel? likeResponseModel;
  CheckTaskCompleteResponseModel? checkTaskCompleteResponseModel;
  RandomTaskResponseModel? randomTaskResponseModel;
  bool downloading = false;
  double downloadingPercent = 0.0;
  List<bool> isliked = [];
  bool uploadloading = false;
  AllCompletedTaskResponseModel? allCompletedTaskResponseModel;
  checkIsRandomTasksCompleted(
      {required String eventId,
      required String token,
      required BuildContext context}) async {
    loading = true;

    notifyListeners();
    checkTaskCompleteResponseModel = (await checkIsRandomTasksCompletedWeb(
        eventId: eventId, token: token, context: context));
    if (checkTaskCompleteResponseModel != null) {
      if (checkTaskCompleteResponseModel!.message == 'Event is deleted' ||
          checkTaskCompleteResponseModel?.message ==
              'Event is no longer available') {
        final languageModal =
            Provider.of<LanguageClass>(context, listen: false);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const FirstInfoScreen()),
            (Route<dynamic> route) => false);

        if (checkTaskCompleteResponseModel?.message == 'Event is deleted') {
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
  }

  getCompletedTasks(
      {required String eventId,
      required String token,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();
    allCompletedTaskResponseModel = (await getAllCompeletedTaskWeb(
        eventId: eventId, token: token, context: context))!;

    loading = false;
    notifyListeners();
  }
  // getRandomTask({required String eventId,required String token,required BuildContext context}) async {
  //
  //   loading=true;
  //   notifyListeners();
  //   randomTaskResponseModel = (await getRandomTaskDataWeb(eventId: eventId,token: token,context:context));
  //
  //   loading=false;
  //   notifyListeners();
  // }

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

  buttonColorChange() {
    isClicked = false;
    notifyListeners();
  }

  selectedRandomTask(
      {required String eventId,
      required String token,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();
    // print('event id .if...${AppGlobal.eventId}');
    //loading=false;

    //notifyListeners();

    // randomTasksSelected = false;
    randomTaskResponseModel = (await getRandomTaskDataWeb(
        eventId: eventId, token: token, context: context))!;
    if (randomTaskResponseModel!.message == 'Event is deleted' ||
        randomTaskResponseModel?.message == 'Event is no longer available') {
      final languageModal = Provider.of<LanguageClass>(context, listen: false);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const FirstInfoScreen()),
          (Route<dynamic> route) => false);
      if (randomTaskResponseModel?.message == 'Event is deleted') {
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

    loading = false;
    notifyListeners();
  }

  getUploadImageResponse(
      {required String token,
      required List<XFile> imageAdress,
      required String eventId,
      required String pid,
      required BuildContext context}) async {
    uploadloading = true;
    notifyListeners();
    dynamic data = (await getmyUploadUrlWeb(
        imageUri: imageAdress,
        eventId: eventId,
        token: token,
        pid: pid,
        context: context))!;
    // print('....................data.....${data['message']}');
    if (data['status'] == true) {
      // galleryUploadImagesResponseModel=GalleryUploadImagesResponseModel.fromJson(data);
      // uploadloading=false;
      // notifyListeners();
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
    }
    uploadloading = false;
    notifyListeners();
    //   GreetingSaveResponseModel greetingSaveResponseModel=GreetingSaveResponseModel.fromJson(data);
    //
    //   print("GOt ${data.toString().contains("\"status\":'false'")}"==false);

    //
    //
    //
    // }else{
    //   // JoinEventResponseModel joinEventResponseModel = JoinEventResponseModel.fromJson(data);
    //   print("else  ");
    //
    //   // joinEventResponseModel = JoinEventResponseModel.fromJson(data);
    //   loading = false;
    //   notifyListeners();
    // }
    // galleryUploadImagesResponseModel=(await getmyUploadUrlWeb(imageUri: imageAdress,eventId: eventId,token: token,pid:pid,context: context))!;
  }

  updateLikes(index) {
    // print('index is $index and its value before $isliked[index]');
    isliked[index] = !isliked[index];
    notifyListeners();
    // print('index is $index and its value after $isliked[index]');
  }

  completedTaskDetails(
      {required String taskId,
      required String pId,
      required String token,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();
    taskCompletedDetailsResponseModel = (await taskCompletedDetailWeb(
        taskId: taskId, pId: pId, token: token, context: context))!;
    for (int i = 0; i < taskCompletedDetailsResponseModel!.images.length; i++) {
      isliked.add(taskCompletedDetailsResponseModel!.images[i].isLiked);
    }
    loading = false;
    notifyListeners();
  }

  deleteTask({required String taskId, required BuildContext context}) async {
    loading = true;
    notifyListeners();
    deleteResponse =
        (await deleteTaskWebService(taskId: taskId, context: context));
    loading = false;
    notifyListeners();
  }

  getLikeResponse(
      {required String imageId,
      required String token,
      index,
      required BuildContext context}) async {
    //loading = true;
    if (isliked[index] == false) {
      isliked[index] = true;
      //notifyListeners();
    } else {
      isliked[index] = false;
      //notifyListeners();
    }
    notifyListeners();
    likeResponseModel = await getLikeResponseWeb(
        imageId: imageId, token: token, context: context);
    if (likeResponseModel != null) {
      taskCompletedDetailsResponseModel!.images[index].likesCount =
          likeResponseModel!.image.likesCount;
      // notifyListeners();
      if (likeResponseModel!.status == false) {
        if (likeResponseModel!.liked) {
          isliked[index] = true;
          //notifyListeners();
        } else {
          isliked[index] = false;
          //notifyListeners();
        }
      }
    }
    //loading = false;
    notifyListeners();
  }

  Future<void> downloadFile(image,
      {required String type, required var contextVar}) async {
    Dio dio = Dio();
    // final commentModel = Provider.of<CommentClass>(context,listen: false);
    final languageModel = Provider.of<LanguageClass>(contextVar, listen: false);
    var dir = await getTemporaryDirectory();
    String tempTimeStamp = DateTime.now().millisecondsSinceEpoch.toString();

    // Toast.show("Downloading Start.", duration: Toast.lengthLong, gravity:  Toast.bottom);

    String savePath = type == 'application/jpg'
        ? "${dir.path}/event_image_$tempTimeStamp.jpg"
        : "${dir.path}/event_video_$tempTimeStamp.mp4";
    try {
      await dio.download(
        image,
        savePath,
        onReceiveProgress: (actualBytes, totalBytes) {
          final percentage =
              ((actualBytes / totalBytes) * 100).toStringAsFixed(2);

          downloadStart();
          getDownloadPercent(percentage);
          downloading = true;

          print('percentage.......${downloadingPercent}');
        },
      );
      // onProgress: (rec, total) {
      //   print("Rec: $rec , Total: $total");
      //
      //   // setState(() {
      //   //   downloading = true;
      //   //   progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
      //   // });
      // });
    } catch (e) {
      print(e);
      Toast.show("Downloading Started",
          duration: Toast.lengthLong, gravity: Toast.bottom);

      downloadFinis();
      //notifyListeners();
    }

    // setState(() {
    //   downloading = false;
    //   progressString = "Completed";
    // });
    if (type == 'application/jpg') {
      GallerySaver.saveImage(savePath).then((bool? success) {
        //Toast.show("Image Successfully Downloaded", duration: Toast.lengthLong, gravity:  Toast.bottom);
        showDialog(
            context: contextVar,
            builder: (BuildContext context) {
              return AlertPopup(
                title: languageModel.languageResponseModel != null
                    ? languageModel.languageResponseModel!.imageView.downloaded
                    : 'Downloaded',
                content: languageModel.languageResponseModel != null
                    ? languageModel
                        .languageResponseModel!.imageView.downloadSuccess
                    : 'Downloaded Successful',
              );
            });
      });
    } else {
      GallerySaver.saveVideo(savePath).then((bool? success) {
        // Toast.show("Video Successfully Downloaded", duration: Toast.lengthLong, gravity:  Toast.bottom);
        showDialog(
            context: contextVar,
            builder: (BuildContext context) {
              return AlertPopup(
                title: languageModel.languageResponseModel != null
                    ? languageModel.languageResponseModel!.imageView.downloaded
                    : 'Downloaded',
                content: languageModel.languageResponseModel != null
                    ? languageModel
                        .languageResponseModel!.imageView.downloadSuccess
                    : 'Downloaded Successful',
              );
            });
      });
    }
    downloadFinis();
    // Toast.show("Downloading Finished.", duration: Toast.lengthLong, gravity:  Toast.bottom);
  }

  downloadStart() {
    //downloading=true;
    notifyListeners();
  }

  downloadFinis() {
    downloading = false;
    notifyListeners();
  }

  getDownloadPercent(percent) {
    //downloading=true;
    downloadingPercent = double.parse(percent);
    notifyListeners();
  }
}
