import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class LanguagePopup extends StatefulWidget {
  final String content = '';
  // final Function() onGalleryPress;
  final Function() onGalleryPress;
  const LanguagePopup({
    Key? key,
    required this.onGalleryPress,
  }) : super(
          key: key,
        );

  @override
  State<LanguagePopup> createState() => _LanguagePopupState();
}

class _LanguagePopupState extends State<LanguagePopup> {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    final languageModel = Provider.of<LanguageClass>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 205,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                languageModel.languageResponseModel != null
                    ? languageModel
                        .languageResponseModel!.widgetAlerts.appLanguage
                    : 'App Language!',
                textAlign: TextAlign.center,
                style: TextStyle(color: kColorTextField, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                elevation: 0,
                color: Colors.white,
                highlightElevation: 0,
                highlightColor: kColorBackGround,
                onPressed: () {
                  // widget.onCameraPress();
                  languageModel.selectLanguage(value: 'eng');
                  // Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(
                      languageModel.languageEngSelected
                          ? Icons.circle
                          : Icons.circle_outlined,
                      color: languageModel.languageEngSelected
                          ? kColorPrimary
                          : Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      languageModel.languageResponseModel != null
                          ? languageModel
                              .languageResponseModel!.widgetAlerts.english
                          : "ENGLISH",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: languageModel.languageEngSelected
                            ? kColorPrimary
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                elevation: 0,
                highlightElevation: 0,
                highlightColor: kColorBackGround,
                color: Colors.white,
                onPressed: () {
                  languageModel.selectLanguage(value: 'ger');
                  // widget.onGalleryPress();
                  // Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(
                      languageModel.languageGermSelected
                          ? Icons.circle
                          : Icons.circle_outlined,
                      color: languageModel.languageGermSelected
                          ? kColorPrimary
                          : Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      languageModel.languageResponseModel != null
                          ? languageModel
                              .languageResponseModel!.widgetAlerts.german
                          : 'GERMAN',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: languageModel.languageGermSelected
                            ? kColorPrimary
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       widget.content!=null?widget.content:'',
              //       // Please select at least 1  picture \nTo continue.
              //       textAlign: TextAlign.center,
              //       maxLines: 2,
              //       style: TextStyle(color: Colors.black, fontSize: 16),
              //     ),
              //
              //   ],
              // ),
              // Row(
              //   children: [
              //     RaisedButton(
              //       elevation: 0,
              //       color: Colors.white,
              //       onPressed:(){
              //         // widget.onGalleryPress();
              //         Navigator.pop(context);
              //       },
              //
              //       child: Text(
              //         "OK",
              //         textAlign: TextAlign.start,
              //         style: TextStyle(color: kColorPrimary,fontWeight: FontWeight.bold,fontSize: 18),
              //       ),
              //     ),
              RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: kColorPrimary,
                onPressed: () {
                  // widget.onGalleryPress();
                  if (languageModel.languageEngSelected) {
                    languageModel
                        .getOnlineLanguageResponse(
                            languagename: 'eng', contextVar: context)
                        .then((e) async {
                      if (languageModel.loading == false) {
                        await storage.write(key: 'started_lang', value: 'eng');
                        print(
                            'Language set ................................................');
                      }
                      Navigator.pop(context);
                    });
                  } else {
                    {
                      languageModel
                          .getOnlineLanguageResponse(
                              languagename: 'ger', contextVar: context)
                          .then((e) async {
                        if (languageModel.loading == false) {
                          await storage.write(
                              key: 'started_lang', value: 'ger');

                          print(
                              'Language set ................................................');
                        }
                        Navigator.pop(context);
                      });
                      // Navigator.pop(context);

                    }
                  }
                },
                child: languageModel.loading
                    ? Container(
                        width: 50,
                        child: SpinKitFadingCircle(
                          size: 20,
                          itemBuilder: (BuildContext context, int index) {
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      )
                    : Text(
                        languageModel.languageResponseModel != null
                            ? languageModel
                                .languageResponseModel!.widgetAlerts.done
                            : "Done",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
              ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
