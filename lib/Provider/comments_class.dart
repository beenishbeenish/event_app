import 'package:dio/dio.dart';
import 'package:event_app/DataModelClasses/all_checks_response.dart';
import 'package:event_app/DataModelClasses/all_image_details_response_model.dart';
import 'package:event_app/DataModelClasses/greeting_save_response_model.dart';
import 'package:event_app/DataModelClasses/like_response_model.dart';
import 'package:event_app/DataModelClasses/post_comment_response_model.dart';
import 'package:event_app/DataModelClasses/view_comments_likes_response_model.dart';
import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Utils/web_services.dart';
import 'package:event_app/Widegts/alert_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../DataModelClasses/language_reponse_model.dart';
import '../DataModelClasses/language_reponse_model.dart';

class CommentClass extends ChangeNotifier {
  PostCommentResponseModel? postCommentResponseModel;
  ViewCommentLikesResponseModel? viewCommentLikesResponseModel;
  ImageDetailsResponseModel? imageDetailsResponseModel;
  GreetingSaveResponseModel? greetingSaveResponseModel;
  AllChecksResponseModel? checksResponseModel;

  bool loading = false;
  String commentText = '';
  bool commentLoading = false;

  int likesCount = 0;
  bool alreadyLiked = false;
  bool downloading = false;
  double downloadingPercent = 0.0;
  LikeResponseModel? likeResponseModel;

  String currentImageURl = '';

  postTheComment(
      {required String imageId,
      required String token,
      required BuildContext context,
      required String commentText}) async {
    // loading=true;
    notifyListeners();
    postCommentResponseModel = (await PostCommentWeb(
        imageId: imageId, token: token, commentText: commentText))!;

    // loading=false;
    notifyListeners();
  }

  getCommentS({
    required String imageId,
    required String token,
    required BuildContext context,
  }) async {
    loading = true;
    notifyListeners();
    viewCommentLikesResponseModel = await getCommentWeb(
      imageId: imageId,
      token: token,
      context: context,
    );
    loading = false;
    notifyListeners();
  }

  refreshScreenState() {
    notifyListeners();
  }

  Future<void> getDeleteImageResponse(
      {required String imageId, required BuildContext context}) async {
    // uploadloading=true;
    // notifyListeners();
    dynamic data = (await getDeleteImageResponseWeb(
      imageId: imageId,
    ))!;

    if (data['message'] == 'Data fetched successfully') {
      greetingSaveResponseModel = GreetingSaveResponseModel.fromJson(data);

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
      return;
    }
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

  getLikeResponse(
      {required String imageId,
      required String token,
      required BuildContext context}) async {
    notifyListeners();
    likeResponseModel = await getLikeResponseWeb(
        imageId: imageId, token: token, context: context);
    if (likeResponseModel != null) {
      imageDetailsResponseModel!.gal.likesCount =
          likeResponseModel!.image.likesCount;
    }

    notifyListeners();
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

  getImageDetail(
      {required String imageId,
      required String token,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();
    imageDetailsResponseModel = await getImageDetailsWeb(
        imageId: imageId, token: token, context: context);

    loading = false;
    notifyListeners();
  }

  getImageDetailByIndex(
      {required String imageId,
      required String token,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();
    imageDetailsResponseModel = (await getImageDetailsWeb(
        imageId: imageId, token: token, context: context))!;

    currentImageURl = imageDetailsResponseModel!.image[0].imageUrl.toString();
    loading = false;
    notifyListeners();
  }

  Future<void> downloadFile(image,
      {required String type,
      required var contextVar,
      required var languageModel}) async {
    Dio dio = Dio();
    // final commentModel = Provider.of<CommentClass>(context,listen: false);
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

          print('percentage.......>>${downloadingPercent}');
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
      Toast.show(
          languageModel.languageResponseModel != null
              ? languageModel.languageResponseModel!.imageView.downloading
              : 'Downloading Started',
          duration: Toast.lengthLong,
          gravity: Toast.bottom);

      downloadFinis();
      //notifyListeners();
    }

    // setState(() {
    //   downloading = false;
    //   progressString = "Completed";
    // });
    if (type == 'application/jpg') {
      GallerySaver.saveImage(savePath).then((bool? success) {
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
}
