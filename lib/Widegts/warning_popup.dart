import 'dart:ffi';

import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WarningPopup extends StatefulWidget {
  final String content;
  final String title;
  final bool icon;
  final Function() onUpdatePress;
  // final Function() onGalleryPress;

  const WarningPopup({Key? key,
    required this.content,
    this.title="",
    this.icon=false,
    required this.onUpdatePress,


  }) : super(key: key,);

  @override
  State<WarningPopup> createState() => _WarningPopupState();
}

class _WarningPopupState extends State<WarningPopup> {
  @override
  Widget build(BuildContext context) {
    final languageModel = Provider.of<LanguageClass>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20.0)), //this right here
      child: Container(
        // height: 150,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                languageModel.languageResponseModel != null
                    ? '${languageModel.languageResponseModel!.infoScreen.warning}!': 'Warning!',
                textAlign: TextAlign.center,
                style: TextStyle(color:kColorTextField ,fontSize: 20),),
              SizedBox(height: 13,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 210,
                    child: Text(

                      widget.content!=null?widget.content:'',
                      // Please select at least 1  picture \nTo continue.
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),


                ],
              ),
              SizedBox(height: 10,),
              RaisedButton(
                elevation: 0,
                color: Colors.white,
                onPressed:(){
                  Navigator.pop(context);
                  widget.onUpdatePress();
                  //
                },

                child: Text(
                  languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.widgetAlerts.update: 'Update',
                  // "Update",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: kColorPrimary,fontWeight: FontWeight.bold,fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
