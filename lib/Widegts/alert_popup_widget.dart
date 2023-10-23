import 'dart:ffi';

import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertPopup extends StatefulWidget {
  String content;
  String title;
  final bool icon;
  final IconData iconname;
  // final Function() onGalleryPress;

  AlertPopup(
      {Key? key,
      this.content = '',
      this.title = "",
      this.icon = false,
      this.iconname = Icons.wifi_off_sharp})
      : super(
          key: key,
        );

  @override
  State<AlertPopup> createState() => _AlertPopupState();
}

class _AlertPopupState extends State<AlertPopup> {
  @override
  void initState() {
    super.initState();
    final languageModel = Provider.of<LanguageClass>(context, listen: false);
    if (widget.title == "") {
      widget.title = languageModel.languageResponseModel != null
          ? '${languageModel.languageResponseModel!.infoScreen.warning}!'
          : 'Warning!';
    }
    if (widget.icon == true && widget.iconname == Icons.wifi_off_sharp) {
      widget.title = languageModel.languageResponseModel != null
          ? languageModel.languageResponseModel!.widgetAlerts.noInternet
          : 'No internet';

      widget.content = languageModel.languageResponseModel != null
          ? languageModel.languageResponseModel!.widgetAlerts.checkConnection
          : 'Please Check your internet connection.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageModel = Provider.of<LanguageClass>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
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
                widget.title,
                // widget.title!=null?widget.title.toString():'Warning!',
                textAlign: TextAlign.center,
                style: TextStyle(color: kColorTextField, fontSize: 20),
              ),
              SizedBox(
                height: 13,
              ),
              widget.icon
                  ? Icon(
                      widget.iconname,
                      color: kColorPrimary,
                      size: 80,
                    )
                  : Text(''),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 210,
                    child: Text(
                      widget.content != null ? widget.content : '',
                      // Please select at least 1  picture \nTo continue.
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),
              RaisedButton(
                elevation: 0,
                color: Colors.white,
                onPressed: () {
                  // widget.onGalleryPress();
                  Navigator.pop(context);
                },
                child: Text(
                  languageModel.languageResponseModel != null
                      ? languageModel.languageResponseModel!.widgetAlerts.okay
                      : 'OK',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: kColorPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
