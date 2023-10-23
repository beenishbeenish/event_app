import 'package:event_app/DataModelClasses/all_myupload_response_model.dart';
import 'package:event_app/DataModelClasses/all_tasks_completed_response_model.dart';
import 'package:event_app/DataModelClasses/event_info_by_info_id_rfesponse.dart';
import 'package:event_app/DataModelClasses/gallery_images_upload_response_model.dart';
import 'package:event_app/DataModelClasses/greeting_save_response_model.dart';
import 'package:event_app/DataModelClasses/post_response_model.dart';
import 'package:event_app/DataModelClasses/public_gallery_response_model.dart';
import 'package:event_app/Utils/app_global.dart';

import 'package:event_app/Utils/web_services.dart';
import 'package:event_app/Widegts/alert_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Views/first_info_screen.dart';
import '../Views/gallery_screen.dart';
import 'language_class.dart';
// import 'package:play_papa/DataModelClasses/categories_response_model.dart';
// import 'package:play_papa/DataModelClasses/product_detail_response_model.dart';
// import 'package:play_papa/DataModelClasses/product_response_model.dart';
// import 'package:play_papa/DataModelClasses/sub_cat_response_model.dart';
// import 'package:play_papa/Utils/web_services.dart';

class DataClass extends ChangeNotifier {
  PostResponceModel? postResponceModel;
  PublicGalleryResponseModel? publicGalleryResponseModel;
  GalleryUploadImagesResponseModel? galleryUploadImagesResponseModel;
  EventInfoByInfoIdResponse? eventInfoByInfoIdResponse;
  bool loading = false;
  bool uploadloading = false;
  int numberOfProducts = 1;
  int selectedColor = 0;
  int currentPageNo = 0;
  int totalPages = 0;

  bool isPublicGallerySelected = true;

  bool addFloatingButtonIsOpen = false;

  getSubCategoriesData({required String catId}) async {
    loading = true;
    //subCatResponseModel = (await getSubCatData(catId: catId))!;
    notifyListeners();
    loading = false;

    notifyListeners();
  }

  incrementInOrderQuantity() {
    numberOfProducts++;

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
      galleryUploadImagesResponseModel =
          GalleryUploadImagesResponseModel.fromJson(data);
      uploadloading = false;
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
      uploadloading = false;
      notifyListeners();
    }
  }

  getEventInfoByID(
      {required String eventId,
      required int uploadedMediaLength,
      required BuildContext context}) async {
    uploadloading = true;
    notifyListeners();
    eventInfoByInfoIdResponse =
        await getEventInfoByIDWeb(eventId: eventId, context: context);

    uploadloading = false;
    notifyListeners();
  }

  getDeleteImageResponse(
      {required String imageId, required BuildContext context}) async {
    // uploadloading=true;
    // notifyListeners();
    dynamic data = (await getDeleteImageResponseWeb(
      imageId: imageId,
    ))!;
    // print('....................data.....${data['message']}');
    if (data['status'] == true) {
      GreetingSaveResponseModel greetingSaveResponseModel =
          GreetingSaveResponseModel.fromJson(data);
      uploadloading = false;
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

  openAddFloatButton() {
    if (addFloatingButtonIsOpen) {
      addFloatingButtonIsOpen = false;
    } else {
      addFloatingButtonIsOpen = true;
    }
    //print(addFloatingButtonIsOpen);

    notifyListeners();
  }

  selectedPublicGalleryTab(
      {required String selectedTab,
      required String eventId,
      required String pId,
      required String token,
      bool withoutPagination = false,
      int sizeOfNewUploadedMedia = 0,
      required BuildContext context}) async {
    if (selectedTab == "My Uploads") {
      if (currentPageNo == 0) {
        loading = true;
      } else {
        uploadloading = true;
      }

      if (currentPageNo != 0 && withoutPagination) {
        print('>>>>>>Without Pagination 1');
        // currentPageNo = currentPageNo - 1;
        currentPageNo = 0;
      }

      notifyListeners();
      isPublicGallerySelected = false;
      PublicGalleryResponseModel? publicGalleryResponseModelTemp;
      publicGalleryResponseModelTemp = null;
      publicGalleryResponseModelTemp = (await getAllGalleryImagesWeb(
          eventId: eventId,
          type: 'private',
          token: token,
          pageNo: currentPageNo,
          context: context));
      if (currentPageNo == 0) {
        publicGalleryResponseModel = publicGalleryResponseModelTemp;
        uploadloading = false;
        notifyListeners();
      } else {
        // if (withoutPagination) {
        //   print('>>>>>>Without Pagination 2');
        //   publicGalleryResponseModel!.totalMediaCount =
        //       publicGalleryResponseModelTemp!.totalMediaCount;
        //   publicGalleryResponseModel!.status =
        //       publicGalleryResponseModelTemp.status;
        //   publicGalleryResponseModel!.message =
        //       publicGalleryResponseModelTemp.message;
        //   print(
        //       '>>>>>>Initial Length : ${AppGlobal.perPageLimit - sizeOfNewUploadedMedia}');
        //   print(
        //       '>>>>>>New Media Length : ${publicGalleryResponseModelTemp.images.length}');
        //   for (int i = AppGlobal.perPageLimit - sizeOfNewUploadedMedia;
        //       i < publicGalleryResponseModelTemp.images.length;
        //       i++) {
        //     publicGalleryResponseModel!.gal
        //         .add(publicGalleryResponseModelTemp.gal[i]);
        //     publicGalleryResponseModel!.images
        //         .add(publicGalleryResponseModelTemp.images[i]);
        //     print('>>>>>>Stuck in loop');
        //   }
        //   print('>>>>>>Out of loop');
        //   uploadloading = false;
        //   notifyListeners();
        // } else {

        publicGalleryResponseModel!.totalMediaCount =
            publicGalleryResponseModelTemp!.totalMediaCount;
        publicGalleryResponseModel!.status =
            publicGalleryResponseModelTemp.status;
        publicGalleryResponseModel!.message =
            publicGalleryResponseModelTemp.message;

        publicGalleryResponseModel!.gal
            .addAll(publicGalleryResponseModelTemp.gal);
        publicGalleryResponseModel!.images
            .addAll(publicGalleryResponseModelTemp.images);
        uploadloading = false;
        notifyListeners();
        // }
      }

      if (publicGalleryResponseModel != null) {
        if (publicGalleryResponseModel?.message == 'Event is deleted' ||
            publicGalleryResponseModel?.message ==
                'Event is no longer available') {
          final languageModal =
              Provider.of<LanguageClass>(context, listen: false);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const FirstInfoScreen()),
              (Route<dynamic> route) => false);

          if (publicGalleryResponseModel?.message == 'Event is deleted') {
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
        if (currentPageNo == 0) {
          loading = false;
        } else {
          uploadloading = false;
        }

        totalPages = (publicGalleryResponseModel!.totalMediaCount /
                AppGlobal.perPageLimit)
            .ceil();
        if (currentPageNo < totalPages) {
          currentPageNo = currentPageNo + 1;
        }
      }

      notifyListeners();
    } else if (selectedTab == "Public Gallery") {
      if (currentPageNo == 0) {
        loading = true;
      } else {
        uploadloading = true;
      }

      if (currentPageNo != 0 && withoutPagination) {
        print('>>>>>>Without Pagination 1');
        //currentPageNo = currentPageNo - 1;
        currentPageNo = 0;
      }
      notifyListeners();
      isPublicGallerySelected = true;
      PublicGalleryResponseModel? publicGalleryResponseModelTemp;
      publicGalleryResponseModelTemp = null;
      publicGalleryResponseModelTemp = (await getAllGalleryImagesWeb(
          eventId: eventId,
          type: 'public',
          token: token,
          pageNo: currentPageNo,
          context: context));
      if (currentPageNo == 0) {
        publicGalleryResponseModel = publicGalleryResponseModelTemp;
        uploadloading = false;
        notifyListeners();
      } else {
        if (publicGalleryResponseModel != null) {
          // if (withoutPagination) {
          //   print('>>>>>>Without Pagination 2');
          //   publicGalleryResponseModel!.totalMediaCount =
          //       publicGalleryResponseModelTemp!.totalMediaCount;
          //   publicGalleryResponseModel!.status =
          //       publicGalleryResponseModelTemp.status;
          //   publicGalleryResponseModel!.message =
          //       publicGalleryResponseModelTemp.message;
          //   print(
          //       '>>>>>>Initial Length : ${AppGlobal.perPageLimit * currentPageNo - sizeOfNewUploadedMedia}');
          //   print(
          //       '>>>>>>New Media Length : ${publicGalleryResponseModel!.images.length + publicGalleryResponseModelTemp.images.length}');
          //   for (int i = AppGlobal.perPageLimit - sizeOfNewUploadedMedia;
          //       i < publicGalleryResponseModelTemp.images.length;
          //       i++) {
          //     publicGalleryResponseModel!.gal
          //         .add(publicGalleryResponseModelTemp.gal[i]);
          //     publicGalleryResponseModel!.images
          //         .add(publicGalleryResponseModelTemp.images[i]);
          //     print('>>>>>>Stuck in loop');
          //   }
          //   print('>>>>>>Out of loop');
          //   uploadloading = false;
          //   notifyListeners();
          // } else {

          publicGalleryResponseModel!.totalMediaCount =
              publicGalleryResponseModelTemp!.totalMediaCount;
          publicGalleryResponseModel!.status =
              publicGalleryResponseModelTemp.status;
          publicGalleryResponseModel!.message =
              publicGalleryResponseModelTemp.message;

          publicGalleryResponseModel!.gal
              .addAll(publicGalleryResponseModelTemp.gal);
          publicGalleryResponseModel!.images
              .addAll(publicGalleryResponseModelTemp.images);
          uploadloading = false;
          notifyListeners();
        }
        //}
      }

      if (publicGalleryResponseModel != null) {
        if (publicGalleryResponseModel?.message == 'Event is deleted' ||
            publicGalleryResponseModel?.message ==
                'Event is no longer available') {
          final languageModal =
              Provider.of<LanguageClass>(context, listen: false);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const FirstInfoScreen()),
              (Route<dynamic> route) => false);

          if (publicGalleryResponseModel?.message == 'Event is deleted') {
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
        if (currentPageNo == 0) {
          loading = false;
        } else {
          uploadloading = false;
        }
        totalPages = (publicGalleryResponseModel!.totalMediaCount /
                AppGlobal.perPageLimit)
            .ceil();
        if (currentPageNo < totalPages) {
          currentPageNo = currentPageNo + 1;
        }
      }

      notifyListeners();
    }

    // notifyListeners();
  }

  decrementInOrderQuantity() {
    if (numberOfProducts > 1) {
      numberOfProducts--;
    }

    notifyListeners();
  }

  refreshScreenState() {
    notifyListeners();
  }

  selectColor({required int select}) {
    selectedColor = select;

    notifyListeners();
  }
}
