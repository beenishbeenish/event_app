import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/Provider/auth_class.dart';
import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Views/login_with_email.dart';
import 'package:event_app/Widegts/alert_popup_widget.dart';
import 'package:event_app/Widegts/email_warning_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'package:email_validator/email_validator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // String _errorMessage = '';

  final _formKey = GlobalKey<FormState>();

  var signUpUserNameController = TextEditingController();
  var signUpUserEmailController = TextEditingController();
  var signUpUserPasswordController = TextEditingController();
  String image = '';
  bool isLoading = false;

  bool isValid = false;
  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
    signUpUserNameController.text = AppGlobal.userName!;
  }

  @override
  Widget build(BuildContext context) {
    final authModal = Provider.of<AuthClass>(context);

    // signInWithGoogle() async {
    //   // Trigger the authentication flow
    //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    //
    //   // Obtain the auth details from the request
    //   final GoogleSignInAuthentication? googleAuth =
    //   await googleUser?.authentication;
    //   print('credential................${googleAuth?.idToken}');
    //   // Create a new credential
    //   final credential = GoogleAuthProvider.credential(
    //     accessToken: googleAuth?.accessToken,
    //     idToken: googleAuth?.idToken,
    //   );
    //
    //   // Once signed in, return the UserCredential
    //   var data = await FirebaseAuth.instance
    //       .signInWithCredential(credential)
    //       .then((value) => {
    //     // print('respomse................${value.user}')
    //     authModal
    //         .socialLoginInfo(
    //         token: AppGlobal.token,
    //         email: value.user!.email.toString(),
    //         name: value.user!.displayName.toString(),
    //         photoUrl: value.user!.photoURL.toString(),
    //         type: 'google')
    //         .then((e) async {
    //       FlutterSecureStorage storage = const FlutterSecureStorage();
    //       await storage.write(key: 'sign_type', value: 'sign_type');
    //     }).catchError((e) {
    //       print('login catchError,,,,,,,,,,,,,,,,,,,,$e');
    //     })
    //   });
    //   // print('data................${data}');
    // }

    // signInWithFacebook() async {
    //   // Trigger the sign-in flow
    //   final LoginResult loginResult = await FacebookAuth.instance.login();
    //
    //   // Create a credential from the access token
    //   final OAuthCredential facebookAuthCredential =
    //   FacebookAuthProvider.credential(loginResult.accessToken!.token);
    //   // print('credential................${facebookAuthCredential}');
    //
    //   // Once signed in, return the UserCredential
    //   var data = FirebaseAuth.instance
    //       .signInWithCredential(facebookAuthCredential)
    //       .then((value) => {
    //     authModal
    //         .socialLoginInfo(
    //         token: AppGlobal.token,
    //         email: value.user!.email.toString(),
    //         name: value.user!.displayName.toString(),
    //         photoUrl: value.user!.photoURL.toString(),
    //         type: 'google')
    //         .then((e) async {
    //       FlutterSecureStorage storage = const FlutterSecureStorage();
    //       await storage.write(key: 'sign_type', value: 'facebook');
    //     }).catchError((e) {
    //       print('login catchError,,,,,,,,,,$e');
    //     })
    //   });
    //   print('data................${data}');
    //   ;
    // }

    signUpBtn(languageModel) {
      // final languageModel = Provider.of<LanguageClass>(context);
      //if (authModal.profileImage != '') {
      if (signUpUserEmailController.text != '' &&
          signUpUserNameController.text != '' &&
          signUpUserPasswordController.text != '') {
        // setState(() {
        //   isLoading=true;
        // });

        authModal
            .signupWeb(
                image: authModal.profileImage,
                email: signUpUserEmailController.text,
                password: signUpUserPasswordController.text,
                token: AppGlobal.token,
                username: signUpUserNameController.text,
                context: context)
            .then((e) {
          if (authModal.authSignupResponse?.status == false) {
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const LoginWithEmailScreen()));
          }
        });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertPopup(
                title: languageModel.languageResponseModel != null
                    ? languageModel.languageResponseModel!.infoScreen.warning
                    : 'Warning!',
                content: languageModel.languageResponseModel != null
                    ? languageModel.languageResponseModel!.infoScreen.warningMsg
                    : 'Please fill all fields.',
              );
            });
      }
      // } else {
      //   showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertPopup(
      //           title: languageModel.languageResponseModel != null
      //               ? languageModel.languageResponseModel!.infoScreen.warning
      //               : 'Warning!',
      //           content: languageModel.languageResponseModel != null
      //               ? languageModel.languageResponseModel!.eventProfile.uploadMsg
      //               : 'Please upload your profile picture.',
      //         );
      //       });
      // }
    }

    var screenSize = MediaQuery.of(context).size;
    final languageModel = Provider.of<LanguageClass>(context);
    var nameController = TextEditingController(
        text: authModal.authModel != null
            ? authModal.authModel!.user.name
            : AppGlobal.userName);
    var emailController = TextEditingController(
        text: authModal.authModel != null
            ? authModal.authModel!.user.socialEmail
            : '');
    getImage() async {
      final authModel = Provider.of<AuthClass>(context, listen: false);

      final picker = ImagePicker();
      final pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 20);
      if (pickedFile != null) {
        setState(() {
          image = pickedFile.path;
        });
        authModel.getImageAddress(pickedFile.path);
      } else {
        print('No image selected.');
      }
    }

    return Scaffold(
        backgroundColor: kColorBackGround,
        appBar: AppBar(
          title: Text(
            languageModel.languageResponseModel != null
                ? languageModel
                    .languageResponseModel!.mobileGallery.sidebarProfile
                : 'Profile',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: kColorPrimary,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: authModal.loading
              ? Center(
                  child: SpinKitFadingCircle(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: kColorTextField,
                        ),
                      );
                    },
                  ),
                )
              : SingleChildScrollView(
                  child: authModal.authModel == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisSize: MainAxisSize.max,
                            children: [
                              // SizedBox(height: 200,),
                              Container(
                                alignment: Alignment.center,

                                // height: screenSize.height,
                                margin: const EdgeInsets.only(top: 30),
                                // width: 220,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    image == ''
                                        ? InkWell(
                                            onTap: () {
                                              getImage();
                                            },
                                            child: Container(
                                                width: 100,
                                                alignment: Alignment.center,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    color: kColorPrimary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: const Icon(
                                                    Icons.camera_alt)),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              getImage();
                                            },
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image.file(
                                                    File(
                                                        authModal.profileImage),
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextField(
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      keyboardType: TextInputType.text,
                                      controller: signUpUserNameController,
                                      //focusNode: fObservation,

                                      // maxLength: 200,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      onChanged: (value) {
                                        //print('$value,$charLength');
                                      },
                                      maxLines: 1,
                                      cursorColor: kColorPrimary,

                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          prefixIcon: const Icon(Icons.person),
                                          labelText: languageModel
                                                      .languageResponseModel !=
                                                  null
                                              ? languageModel
                                                  .languageResponseModel!
                                                  .eventProfile
                                                  .username
                                              : 'Enter Username',
                                          // labelStyle: TextStyle(color: kColorPrimary),
                                          contentPadding: EdgeInsets.zero,
                                          hintText: languageModel
                                                      .languageResponseModel !=
                                                  null
                                              ? languageModel
                                                  .languageResponseModel!
                                                  .eventProfile
                                                  .username
                                              : 'Username',
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400]),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: kColorPrimary)),
                                          focusColor: kColorPrimary),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      keyboardType: TextInputType.emailAddress,
                                      // controller: highLightController,
                                      //focusNode: fObservation,
                                      // maxLength: 200,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      onChanged: (value) {
                                        print(value);
                                        //print('$value,$charLength');
                                      },
                                      maxLines: 1,
                                      cursorColor: kColorPrimary,
                                      controller: signUpUserEmailController,
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          prefixIcon: const Icon(Icons.email),
                                          labelText: languageModel
                                                      .languageResponseModel !=
                                                  null
                                              ? languageModel
                                                  .languageResponseModel!
                                                  .eventProfile
                                                  .enterEmail
                                              : 'Enter Email',
                                          // labelStyle: TextStyle(color: kColorPrimary),
                                          contentPadding: EdgeInsets.zero,
                                          hintText: languageModel
                                                      .languageResponseModel !=
                                                  null
                                              ? languageModel
                                                  .languageResponseModel!
                                                  .eventProfile
                                                  .email
                                              : 'Email',
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400]),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: kColorPrimary)),
                                          focusColor: kColorPrimary),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      keyboardType: TextInputType.text,
                                      // controller: highLightController,
                                      controller: signUpUserPasswordController,
                                      //focusNode: fObservation,
                                      obscureText: true,
                                      // maxLength: 200,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      onChanged: (value) {
                                        //print('$value,$charLength');
                                      },
                                      maxLines: 1,
                                      cursorColor: kColorPrimary,

                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          prefixIcon: const Icon(Icons.lock),
                                          labelText: languageModel
                                                      .languageResponseModel !=
                                                  null
                                              ? languageModel
                                                  .languageResponseModel!
                                                  .eventProfile
                                                  .enterPass
                                              : 'Enter Password',
                                          // labelStyle: TextStyle(color: kColorPrimary),
                                          contentPadding: EdgeInsets.zero,
                                          hintText: languageModel
                                                      .languageResponseModel !=
                                                  null
                                              ? languageModel
                                                  .languageResponseModel!
                                                  .eventProfile
                                                  .pass
                                              : 'Password',
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400]),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: kColorPrimary)),
                                          focusColor: kColorPrimary),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                const EdgeInsets.all(8)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(kColorPrimary)),
                                        onPressed: () {
                                          // signInWithGoogle();
                                          isValid = EmailValidator.validate(
                                              signUpUserEmailController.text);
                                          print(isValid);
                                          if (isValid) {
                                            signUpBtn(languageModel);
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return EmailWarningPopup(
                                                    title: languageModel
                                                                .languageResponseModel !=
                                                            null
                                                        ? languageModel
                                                                .languageResponseModel!
                                                                .generalMessages
                                                                .invalidEmail +
                                                            '!'
                                                        : 'Invalid Email!',
                                                    icon: true,
                                                    iconname:
                                                        Icons.warning_amber,
                                                    content: languageModel
                                                                .languageResponseModel !=
                                                            null
                                                        ? languageModel
                                                            .languageResponseModel!
                                                            .generalMessages
                                                            .invalidEmail
                                                        : 'Invalid Email',
                                                  );
                                                });
                                            print("Email is not valid");
                                          }
                                          // Navigator.pushNamed(context, PhoneAuthScreen.id);
                                        },
                                        child: authModal.signupLoading
                                            ? Container(
                                                width: 80,
                                                child: SpinKitFadingCircle(
                                                  size: 20,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return DecoratedBox(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: Colors.white,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            : Text(
                                                '   ${languageModel.languageResponseModel != null ? languageModel.languageResponseModel!.eventProfile.signup : 'Sign Up'}   ')),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    const LoginWithEmailScreen()));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            languageModel
                                                        .languageResponseModel !=
                                                    null
                                                ? languageModel
                                                    .languageResponseModel!
                                                    .eventProfile
                                                    .haveAccount
                                                : 'Already have account?',
                                            style: const TextStyle(
                                                color: kColorPrimary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Container(
                                    //   width: screenSize.width * 0.65,
                                    //   margin: EdgeInsets.only(top: 40),
                                    //   child: Row(
                                    //     crossAxisAlignment:
                                    //     CrossAxisAlignment.center,
                                    //     mainAxisAlignment:
                                    //     MainAxisAlignment.spaceAround,
                                    //     children: [
                                    //       ElevatedButton(
                                    //           style: ButtonStyle(
                                    //               padding:
                                    //               MaterialStateProperty.all(
                                    //                   EdgeInsets.all(8)),
                                    //               backgroundColor:
                                    //               MaterialStateProperty.all<
                                    //                   Color>(
                                    //                   kColorPrimary)),
                                    //           onPressed: () {
                                    //             signInWithGoogle();
                                    //             // Navigator.pushNamed(context, PhoneAuthScreen.id);
                                    //           },
                                    //           child: Icon(
                                    //             LineIcons.googleLogo,
                                    //             color: Colors.white,
                                    //           )),
                                    //       // ElevatedButton(
                                    //       //     style: ButtonStyle(
                                    //       //         padding:
                                    //       //             MaterialStateProperty.all(
                                    //       //                 EdgeInsets.all(8)),
                                    //       //         backgroundColor:
                                    //       //             MaterialStateProperty.all<
                                    //       //                     Color>(
                                    //       //                 kColorPrimary)),
                                    //       //     onPressed: () {
                                    //       //       signInWithFacebook();
                                    //       //     },
                                    //       //     child: Icon(
                                    //       //       LineIcons.facebook,
                                    //       //       color: Colors.white,
                                    //       //     )),
                                    //       ElevatedButton(
                                    //         style: ButtonStyle(
                                    //             padding:
                                    //             MaterialStateProperty.all(
                                    //                 EdgeInsets.all(8)),
                                    //             backgroundColor:
                                    //             MaterialStateProperty.all<
                                    //                 Color>(kColorPrimary)),
                                    //         onPressed: () async {},
                                    //         child: Icon(
                                    //           LineIcons.apple,
                                    //           color: Colors.white,
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                width: 100,
                                height: 100,
                                imageUrl: authModal.authModel != null
                                    ? authModal.authModel!.user.photoURL!
                                    : '',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                      35.0,
                                    )),
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
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                  size: 35,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                Text(
                                  languageModel.languageResponseModel != null
                                      ? languageModel.languageResponseModel!
                                          .eventProfile.name
                                      : 'Name',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: kColorGreyText,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: screenSize.width * 1,
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(1, 3),
                                  )
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  keyboardType: TextInputType.text,
                                  controller: nameController,
                                  //focusNode: fObservation,
                                  // maxLength: 200,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),

                                  onChanged: (value) {
                                    //print('$value,$charLength');
                                  },
                                  maxLines: 1,
                                  cursorColor: kColorPrimary,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    // hintText: getTranslated(context,
                                    //     'typeherestartdictation'),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        10, 20, 40, 0),
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade400),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                Text(
                                  languageModel.languageResponseModel != null
                                      ? languageModel.languageResponseModel!
                                          .eventProfile.email
                                      : 'Email',
                                  style: const TextStyle(
                                    color: kColorGreyText,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: screenSize.width * 1,
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(1, 3),
                                  )
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  keyboardType: TextInputType.text,
                                  controller: emailController,
                                  //focusNode: fObservation,
                                  // maxLength: 200,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),

                                  onChanged: (value) {
                                    //print('$value,$charLength');
                                  },
                                  maxLines: 1,
                                  cursorColor: kColorPrimary,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    // hintText: getTranslated(context,
                                    //     'typeherestartdictation'),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        10, 20, 40, 0),
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade400),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                ),
        ));
  }
//   void validateEmail(String val) {
//     if(val.isEmpty){
//       setState(() {
//         _errorMessage = "Email can not be empty";
//       });
//     }else if(!EmailValidator.validate(val, true)){
//       setState(() {
//         _errorMessage = "Invalid Email Address";
//       });
//     }else{
//       setState(() {
//         _errorMessage = "";
//       });
//     }
//   }
}
