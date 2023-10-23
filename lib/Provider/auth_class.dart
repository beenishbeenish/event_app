import 'dart:io';

import 'package:event_app/DataModelClasses/all_checks_response.dart';
import 'package:event_app/DataModelClasses/auth_model_response.dart';
import 'package:event_app/DataModelClasses/greeting_save_response_model.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Utils/web_services.dart';
import 'package:event_app/Widegts/alert_popup_widget.dart';
import 'package:flutter/material.dart';

class AuthClass extends ChangeNotifier {
  AuthModel? authModel;
  AuthModel? authModelWithoutlLogin;
  GreetingSaveResponseModel? authSignupResponse;
  AllChecksResponseModel? checksResponseModel;
  bool loading = false;
  bool uploadloading = false;
  bool signupLoading = false;

  String profileImage = '';
  int numberOfProducts = 1;
  int selectedColor = 0;

  // socialLoginInfo(
  //     {required String name,
  //     required String type,
  //     required String photoUrl,
  //     required String email,
  //     required String token}) async {
  //   loading = true;
  //   notifyListeners();
  //   authModel = (await getPostUserInfoResponse(
  //       email: email,
  //       type: type,
  //       photoUrl: photoUrl,
  //       token: token,
  //       name: name))!;
  //   loading = false;
  //   notifyListeners();
  // }

  getImageAddress(url) {
    //print('image adresss $url');
    profileImage = url;
    notifyListeners();
  }

  getUserInfo({required String token, required context}) async {
    loading = true;
    notifyListeners();
    authModel = (await getUserInfoResponseWeb(token: token, context: context))!;

    AppGlobal.userName = authModel!.user.name!;

    loading = false;
    notifyListeners();
  }

  getlUserInfoWithoutLogin({required String token, required context}) async {
    loading = true;
    notifyListeners();
    authModelWithoutlLogin =
        (await getUserInfoResponseWeb(token: token, context: context))!;
    print('>>>>>>>>>>>>>>>>123');
    AppGlobal.userName = authModelWithoutlLogin!.user.name!;

    loading = false;
    notifyListeners();
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

  signupWeb(
      {required String image,
      required String email,
      required String password,
      required String token,
      required String username,
      required BuildContext context}) async {
    signupLoading = true;
    notifyListeners();
    dynamic data = (await getsignUpResponseWeb(
        imageUri: image,
        username: username,
        password: password,
        token: token,
        email: email,
        context: context))!;
    // loading=false;
    if (data['status'] == true) {
      // print('status..............if');
      authSignupResponse = GreetingSaveResponseModel.fromJson(data);
      signupLoading = false;
      notifyListeners();
    } else {
      //print('status..............else $signupLoading');
      authSignupResponse = GreetingSaveResponseModel.fromJson(data);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertPopup(
              title: 'Sorry',
              icon: false,
              content: '${authSignupResponse?.message}',
            );
          });
      signupLoading = false;
      notifyListeners();
      // print('status..............else $signupLoading');
    }
    // notifyListeners();
  }

  loginWithEmail(
      {required String password,
      required String email,
      required String token,
      required BuildContext context}) async {
    signupLoading = true;
    notifyListeners();
    dynamic data = (await getLoginResponse(
        email: email, password: password, token: token, context: context))!;
    if (data['status'] == true) {
      // print('status..............if');

      signupLoading = false;
      //notifyListeners();
      //print('user.................${data['status']}');

      // authModel=AuthModel.fromJson(data);
      loading = true;
      notifyListeners();
      authModel = (AuthModel.fromJson(data));
      loading = false;
      notifyListeners();
      // getlUserInfo(token: AppGlobal.token);
      //print('user.................${authModel!.user.id}');
      // loading=false;
      // notifyListeners();
    } else {
      //print('status..............else $signupLoading');
      // authModel=GreetingSaveResponseModel.fromJson(data);
      authSignupResponse = GreetingSaveResponseModel.fromJson(data);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertPopup(
              title: 'Sorry',
              icon: false,
              content:
                  '${authSignupResponse?.message == 'Email is not verify.' ? 'Invalid Email' : authSignupResponse?.message}',
            );
          });
      // signupLoading=false;
      // notifyListeners();
      //print('status..............else $signupLoading');
    }
    signupLoading = false;
    notifyListeners();
  }
}
