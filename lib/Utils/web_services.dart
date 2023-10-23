import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'package:event_app/DataModelClasses/all_checks_response.dart';
import 'package:event_app/DataModelClasses/delete_response.dart';
import 'package:http_parser/http_parser.dart';

import 'package:event_app/DataModelClasses/all_greeting_response_model.dart';
import 'package:event_app/DataModelClasses/all_image_details_response_model.dart';
import 'package:event_app/DataModelClasses/all_myupload_response_model.dart';
import 'package:event_app/DataModelClasses/all_tasks_completed_response_model.dart';
import 'package:event_app/DataModelClasses/auth_model_response.dart';
import 'package:event_app/DataModelClasses/check_task_complete_response_model.dart';
import 'package:event_app/DataModelClasses/event_response_modal.dart';
import 'package:event_app/DataModelClasses/greeting_save_response_model.dart';
import 'package:event_app/DataModelClasses/guest_response_modal.dart';
import 'package:event_app/DataModelClasses/language_reponse_model.dart';
import 'package:event_app/DataModelClasses/like_response_model.dart';
import 'package:event_app/DataModelClasses/post_comment_response_model.dart';
import 'package:event_app/DataModelClasses/public_gallery_response_model.dart';
import 'package:event_app/DataModelClasses/random_task_response_modal.dart';
import 'package:event_app/DataModelClasses/task_completed_details_response_model.dart';
import 'package:event_app/DataModelClasses/task_completed_response_model.dart';
import 'package:event_app/DataModelClasses/view_comments_likes_response_model.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Utils/internet_checker.dart';
import 'package:event_app/Utils/json_file_manage.dart';
import 'package:event_app/Widegts/alert_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../DataModelClasses/event_info_by_info_id_rfesponse.dart';

Future<EventResponseModel?> getEventDataWeb(
    {required String eventId, var context}) async {
  EventResponseModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}events/qrScan');
      final response =
          await http.post(Uri.parse("${AppGlobal.baseUrl}events/qrScan"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Accept': 'application/json',
              },
              body: jsonEncode({"event_id": eventId}));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item.12...${item}');
        result = EventResponseModel.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<EventResponseModel?> getEventDataOnJoinWithCodeApi(
    {required String eventId, var context}) async {
  EventResponseModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}events/join-by-code');
      final response =
          await http.post(Uri.parse("${AppGlobal.baseUrl}events/join-by-code"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Accept': 'application/json',
              },
              body: jsonEncode({"event_code": eventId}));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item.12...${item}');
        result = EventResponseModel.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<dynamic> getJoinEventDataWeb(
    {required String eventId, required String deviceId, context}) async {
  dynamic result;

  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}joint-events');
      print('Event id: $eventId');
      print('Device id: $deviceId');
      final response =
          await http.post(Uri.parse("${AppGlobal.baseUrl}joint-events"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Accept': 'application/json',

                // 'Authorization': 'Bearer ${AppGlobal.token}',
              },
              body: jsonEncode({"deviceId": deviceId, "EventId": eventId}));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item..23....${item}');
        result = item;
        return result;
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<dynamic> setUserNameWebService(
    {required String username, required String deviceId, context}) async {
  dynamic result;

  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}events/save-user-name');
      print('User Name: $username');
      print('Device id: $deviceId');
      final response = await http.post(
          Uri.parse("${AppGlobal.baseUrl}events/save-user-name"),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'Accept': 'application/json',
            'Authorization': 'Bearer ${AppGlobal.token}',
          },
          body: jsonEncode({"device_id": deviceId, "user_name": username}));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item3......${item}');
        result = item;
        return result;
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

//....................Tasks..............................
Future<RandomTaskResponseModel?> getRandomTaskDataWeb(
    {required String eventId, required String token, context}) async {
  RandomTaskResponseModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}tasks/randomTask/$eventId/$token');
      final response =
          await http.post(Uri.parse("${AppGlobal.baseUrl}tasks/randomTask"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Accept': 'application/json',
                'Authorization': 'Bearer ${token}',
              },
              body: jsonEncode({"event_id": eventId}));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item....${item}');
        result = RandomTaskResponseModel.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<CheckTaskCompleteResponseModel?> checkIsRandomTasksCompletedWeb(
    {required String eventId, required String token, context}) async {
  CheckTaskCompleteResponseModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      final response =
          await http.post(Uri.parse("${AppGlobal.baseUrl}tasks/tasks-check"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Accept': 'application/json',
                'Authorization': 'Bearer ${token}',
              },
              body: jsonEncode({"event_id": eventId}));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('${AppGlobal.baseUrl}tasks/tasks-check/${eventId}/${token}');
        print('item123....${item}');
        result = CheckTaskCompleteResponseModel.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<TaskCompletedDetailsResponseModel?> taskCompletedDetailWeb(
    {required String taskId,
    required String pId,
    required String token,
    context}) async {
  TaskCompletedDetailsResponseModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      // print(
      //     '${AppGlobal.baseUrl}tasks/details-for-current-user/$taskId/$pId/$token');
      final response = await http.post(
          Uri.parse("${AppGlobal.baseUrl}tasks/details-for-current-user"),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({"task_id": taskId, "participant_id": pId}));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item....${item}');
        result = TaskCompletedDetailsResponseModel.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<DeleteResponse?> deleteTaskWebService(
    {required String taskId, context}) async {
  DeleteResponse? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}tasks/task-delete');
      print('task_id: $taskId, Participant Id: ${AppGlobal.pId}');
      print('token ${AppGlobal.token}');
      final response = await http.post(
          Uri.parse("${AppGlobal.baseUrl}tasks/task-delete"),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'Accept': 'application/json',
            'Authorization': 'Bearer ${AppGlobal.token}',
          },
          body:
              jsonEncode({"task_id": taskId, "participant_id": AppGlobal.pId}));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item....${item}');
        result = DeleteResponse.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<TaskCompletedResponseModel?> taskCompletedResponseWeb(
    {required String pId,
    required String taskId,
    required String token,
    context}) async {
  TaskCompletedResponseModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}tasks/taskComplete/$taskId');
      final response =
          await http.post(Uri.parse("${AppGlobal.baseUrl}tasks/taskComplete"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Accept': 'application/json',
                'Authorization': 'Bearer ${token}',
              },
              body: jsonEncode({"pid": pId, "taskId": taskId}));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item....${item}');
        result = TaskCompletedResponseModel.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<AllCompletedTaskResponseModel?> getAllCompeletedTaskWeb(
    {required String eventId, required String token, context}) async {
  AllCompletedTaskResponseModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      final response = await http.get(
        Uri.parse("${AppGlobal.baseUrl}tasks/taskComplete/${eventId}"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('${AppGlobal.baseUrl}tasks/taskComplete/${eventId}');
        print('item>>>>....${item}');
        result = AllCompletedTaskResponseModel.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

//.........................Image Upload........................

Future<dynamic> getImageUrlWeb(
    {required List<XFile> imageUri,
    required String pid,
    required String taskId,
    required String token,
    context}) async {
  dynamic? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      //print('${AppGlobal.baseUrl}gallery/${imageUri.length}');
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}',
      };

      print(">>>> ${AppGlobal.baseUrl}gallery");

      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${AppGlobal.baseUrl}gallery"),
      );
      request.headers.addAll(headers);
      //add text field
      request.fields["taskId"] = taskId;
      request.fields["pid"] = pid;
      request.fields["event_id"] = AppGlobal.eventId;
      for (int i = 0; i < imageUri.length; i++) {
        print("$i");
        var pic = await http.MultipartFile.fromBytes(
            'galleryImage',
            contentType: MediaType(
                'application',
                (imageUri[i].path.contains('.jpg') ||
                        imageUri[i].path.contains('.png'))
                    ? 'jpg'
                    : 'mp4'),
            File(imageUri[i].path.toString()).readAsBytesSync(),
            filename: imageUri[i].path.split("/").last);
        // var pic = await http.MultipartFile.fromPath(
        //     "galleryImage", imageUri[i].path.toString());
        request.files.add(pic);
      }
      http.Response response =
          await http.Response.fromStream(await request.send());

      print('item....${response.body}');
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        //
        result = item;
        return result;
        // result =
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<dynamic> getmyUploadUrlWeb(
    {required List<XFile> imageUri,
    required String eventId,
    required String token,
    required String pid,
    context}) async {
  dynamic result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print(
          '${AppGlobal.baseUrl}gallery/upload-event-images/${imageUri.length}/$eventId');
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}',
      };

      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${AppGlobal.baseUrl}gallery/upload-event-images"),
      );
      request.headers.addAll(headers);
      //add text field

      request.fields["event_id"] = eventId;
      request.fields["pid"] = pid;
      for (int i = 0; i < imageUri.length; i++) {
        print('pic...${imageUri[i].path}');
        // var pic = await http.MultipartFile.fromPath("galleryImage", imageUri[i].path.toString());
        var pic = await http.MultipartFile.fromBytes(
            'galleryImage',
            contentType: MediaType(
                'application',
                (imageUri[i].path.contains('.jpg') ||
                        imageUri[i].path.contains('.png'))
                    ? 'jpg'
                    : 'mp4'),
            File(imageUri[i].path.toString()).readAsBytesSync(),
            filename: imageUri[i].path.split("/").last);

        request.files.add(pic);
      }
      var response = await http.Response.fromStream(await request.send());

      print('item....${response.body}');
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        //
        // print('iten.........$item');
        result = item;
        return result;
        // result = GalleryUploadImagesResponseModel.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<EventInfoByInfoIdResponse?> getEventInfoByIDWeb(
    {required String eventId, context}) async {
  EventInfoByInfoIdResponse? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print("${AppGlobal.baseUrl}events/by-id");

      final response =
          await http.post(Uri.parse("${AppGlobal.baseUrl}events/by-id"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Accept': 'application/json',
                'Authorization': 'Bearer ${AppGlobal.token}',
              },
              body: jsonEncode({"event_id": eventId}));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        log('item....${item}');
        result = EventInfoByInfoIdResponse.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<AllMyUploadResponseModel?> getAllMyUploadWeb(
    {required String pId, required String token, context}) async {
  AllMyUploadResponseModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}gallery/$pId');

      final response = await http.get(
        Uri.parse("${AppGlobal.baseUrl}gallery/$pId"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item....${item}');
        result = AllMyUploadResponseModel.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<PublicGalleryResponseModel?> getAllGalleryImagesWeb(
    {required String eventId,
    required String type,
    required String token,
    required int pageNo,
    context}) async {
  PublicGalleryResponseModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}gallery/public');

      print("Skip : $pageNo");
      print("Type : $type");
      print("Pid : ${AppGlobal.pId}");

      final response =
          await http.post(Uri.parse("${AppGlobal.baseUrl}gallery/public"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode({
                "event_id": eventId,
                "type": type,
                "pid": AppGlobal.pId,
                "limit": AppGlobal.perPageLimit,
                "skip": pageNo
              }));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item....${item}');
        result = PublicGalleryResponseModel.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

// ...............Guest.........................
Future<GuestCountResponseModel?> getGuestCountWeb(
    {required String eventId, required String token, context}) async {
  GuestCountResponseModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}events/get-images-count');
      final response = await http.post(
          Uri.parse("${AppGlobal.baseUrl}events/get-images-count"),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({"_id": eventId}));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item....${item}');
        result = GuestCountResponseModel.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

//....................Image Details..........................
Future<ImageDetailsResponseModel?> getImageDetailsWeb(
    {required String imageId, required String token, context}) async {
  ImageDetailsResponseModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}gallery/allDetails/$imageId');
      final response = await http.get(
        Uri.parse("${AppGlobal.baseUrl}gallery/allDetails/$imageId"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item....${item}');
        result = ImageDetailsResponseModel.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

//.................Comments............................
Future<PostCommentResponseModel?> PostCommentWeb(
    {required String imageId,
    required String token,
    required String commentText,
    context}) async {
  PostCommentResponseModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}gallery/comments/${imageId}/${token}');
      final response =
          await http.post(Uri.parse("${AppGlobal.baseUrl}gallery/comments"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Accept': 'application/json',
                'Authorization': 'Bearer ${token}',
              },
              body: jsonEncode({"comments": commentText, "id": imageId}));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        log('your comment....${item}');
        result = PostCommentResponseModel.fromJson(item);
        print('>>>>>>>>>>>Error Comment');
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<ViewCommentLikesResponseModel?> getCommentWeb(
    {context, required String imageId, required String token}) async {
  ViewCommentLikesResponseModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}gallery/view-likes/${imageId}/${token}');
      final response =
          await http.post(Uri.parse("${AppGlobal.baseUrl}gallery/view-likes"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Accept': 'application/json',
                'Authorization': 'Bearer ${token}',
              },
              body: jsonEncode({"gallery_id": imageId}));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item....${item}');
        result = ViewCommentLikesResponseModel.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<LikeResponseModel?> getLikeResponseWeb(
    {required String imageId, required String token, context}) async {
  LikeResponseModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}gallery/like/${imageId}/${token}');
      final response =
          await http.post(Uri.parse("${AppGlobal.baseUrl}gallery/like"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Accept': 'application/json',
                'Authorization': 'Bearer ${token}',
              },
              body: jsonEncode({"gallery_id": imageId}));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item....${item}');
        result = LikeResponseModel.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

//.....................Greetings.............................

Future<dynamic> getGreetingSaveWeb(
    {required String eventId,
    required String title,
    required List<XFile> imageUri,
    required String description,
    required String token,
    context}) async {
  dynamic? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}greetings/save/${imageUri.length}');
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}',
      };

      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${AppGlobal.baseUrl}greetings/save"),
      );
      request.headers.addAll(headers);
      //add text field
      request.fields["event_id"] = eventId;
      request.fields["title"] = title;
      request.fields["description"] = description;

      for (int i = 0; i < imageUri.length; i++) {
        print("$i");
        var pic = await http.MultipartFile.fromBytes(
            'images',
            contentType: MediaType(
                'application',
                (imageUri[i].path.contains('.jpg') ||
                        imageUri[i].path.contains('.png'))
                    ? 'jpg'
                    : 'mp4'),
            File(imageUri[i].path.toString()).readAsBytesSync(),
            filename: imageUri[i].path.split("/").last);
        // var pic = await http.MultipartFile.fromPath(
        //     "images", imageUri[i].path.toString());
        request.files.add(pic);
      }
      http.Response response =
          await http.Response.fromStream(await request.send());

      print('item....${response.body}');
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        //

        result = item;
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<GreetingSaveResponseModel?> getGreetingDeleteWeb(
    {required String greetingId, required String token, context}) async {
  GreetingSaveResponseModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}greetings/delete/${greetingId}');

      final response =
          await http.post(Uri.parse("${AppGlobal.baseUrl}greetings/delete"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Accept': 'application/json',
                'Authorization': 'Bearer ${token}',
              },
              body: jsonEncode({"greeting_id": greetingId}));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item....${item}');
        result = GreetingSaveResponseModel.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<AllGreetingResponse?> getAllGreetingSaveWeb(
    {required String eventId, required String token, context}) async {
  AllGreetingResponse? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}greetings/view/$token/');

      final response =
          await http.post(Uri.parse("${AppGlobal.baseUrl}greetings/view"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode({"event_id": eventId}));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item....${item}');
        result = AllGreetingResponse.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}
//.......................Languages.............................

Future<LanguageResponseModel?> getOnlineLanguageWeb({
  required String languagename,
  required var contextVar,
}) async {
  LanguageResponseModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('language name,.........$languagename');
      final String url = languagename == 'eng'
          ? '${AppGlobal.baseUrl}strapi/mobile/eng'
          : '${AppGlobal.baseUrl}strapi/mobile/ger';
      print('language $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'Accept': 'application/json',
          // 'Authorization': 'Bearer ${token}',
        },
      );

      if (response.statusCode == 200) {
        print("item ${response.body}");
        final item = json.decode(response.body);
        result = LanguageResponseModel.fromJson(item);
        StatesStorage statesStorage = new StatesStorage(fileNameSelect: 1);
        statesStorage.writeStates(response.body);
      } else {
        print("error $response.body");
      }
    } catch (e) {
      print('Language eror............$e');

      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: contextVar,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}
//............................User Info...............................

// Future<AuthModel?> getPostUserInfoResponse(
//     {required String email,
//     required String token,
//     required String name,
//     required String type,
//     required String photoUrl}) async {
//   AuthModel? result;
//   try {
//     print('${AppGlobal.baseUrl}user/update-social-profile${token}/');
//
//     final response = await http.post(
//         Uri.parse("${AppGlobal.baseUrl}user/update-social-profile"),
//         headers: {
//           HttpHeaders.contentTypeHeader: "application/json",
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${token}',
//         },
//         body: jsonEncode({
//           "photoURL": photoUrl,
//           "type": type,
//           "name": name,
//           "socialEmail": email
//         }));
//     if (response.statusCode == 200) {
//       final item = json.decode(response.body);
//       print('item....${item}');
//       result = AuthModel.fromJson(item);
//     } else {
//       print("error");
//     }
//   } catch (e) {
//     log(e.toString());
//   }
//   return result;
// }

Future<AllChecksResponseModel?> getAllCheckResponseWeb(
    {required String token, required String eventId, required context}) async {
  AllChecksResponseModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      final response =
          await http.post(Uri.parse("${AppGlobal.baseUrl}gallery/all-checks"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode({"id": eventId}));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        //print('item44....${item}');
        result = AllChecksResponseModel.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<AuthModel?> getUserInfoResponseWeb(
    {required String token, required context}) async {
  AuthModel? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();
  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}user/get-user-info${token}/');

      final response = await http.get(
        Uri.parse("${AppGlobal.baseUrl}user/get-user-info"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item55....${item}');
        result = AuthModel.fromJson(item);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}
// .............................SignUpp..........................

Future<dynamic> getLoginResponse(
    {required String email,
    required String token,
    required String password,
    required context}) async {
  dynamic? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();
  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}user/login$token/');

      final response =
          await http.post(Uri.parse("${AppGlobal.baseUrl}user/login"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode({
                "email": email,
                "password": password,
              }));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item....${item}');
        result = item;
      } else {
        print("error");
        result = json.decode(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}

Future<dynamic> getsignUpResponseWeb(
    {required String imageUri,
    required String username,
    required String password,
    required String token,
    required String email,
    context}) async {
  dynamic? result;
  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}user/guest-sign-up');
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}',
      };

      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${AppGlobal.baseUrl}user/guest-sign-up"),
      );
      request.headers.addAll(headers);
      //add text field

      request.fields["email"] = email;
      request.fields["password"] = password;
      request.fields["username"] = username;
      if (imageUri != '') {
        var pic = await http.MultipartFile.fromPath("image", imageUri);
        request.files.add(pic);
      }

      http.Response response =
          await http.Response.fromStream(await request.send());

      print('item....${response.body}');
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        //
        print('iten.........$item');
        result = item;
      } else {
        return json.decode(response.body);
        print("error");
      }
    } catch (e) {
      log('sign' + e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}
//........................delete..............

Future<dynamic> getDeleteImageResponseWeb({
  required String imageId,
  context,
}) async {
  dynamic result;

  bool isInternetAvailable = await CommonUtil().checkInternetConnection();

  if (isInternetAvailable) {
    try {
      print('${AppGlobal.baseUrl}gallery/gallery-delete');
      final response = await http.post(
          Uri.parse("${AppGlobal.baseUrl}gallery/gallery-delete"),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'Accept': 'application/json',
            'Authorization': 'Bearer ${AppGlobal.token}',
          },
          body: jsonEncode({
            "id": imageId,
          }));
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        print('item......${item}');
        result = item;
        return result;
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertPopup(
            title: 'No internet',
            icon: true,
            content: 'Please Check your internet connection.',
          );
        });
    return result;
  }
}
