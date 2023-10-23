import 'package:event_app/Provider/auth_class.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:event_app/Widegts/alert_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/language_class.dart';

class ImagePopup extends StatefulWidget {
  final Function() onCameraPress;
  final Function() onGalleryPress;
  final Function() onVideoPress;

  const ImagePopup({Key? key,
    required this.onCameraPress,
    required this.onGalleryPress,
    required this.onVideoPress,

  }) : super(key: key,);

  @override
  State<ImagePopup> createState() => _ImagePopupState();
}

class _ImagePopupState extends State<ImagePopup> {

  @override
  Widget build(BuildContext context) {
    final authModal = Provider.of<AuthClass>(context);
    final languageModel = Provider.of<LanguageClass>(context);
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
            Text(
              languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.widgetAlerts.imagePicker: 'Image picker',
              textAlign: TextAlign.center,
              style: TextStyle(color:kColorTextField ,fontSize: 20),
            ),
              RaisedButton(
                elevation: 0,
                color: Colors.white,
                highlightElevation: 0,
                highlightColor: kColorBackGround,
                onPressed:((authModal.checksResponseModel?.mediaType=='image')==true||(authModal.checksResponseModel?.mediaType=='image/video')==true)? (){

                  widget.onCameraPress();
                  Navigator.pop(context);


                }:(){
                  showDialog(
                      context: context,
                      builder: (BuildContext context)
                      {
                        return AlertPopup(
                          title: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.generalMessages.sorry: 'Sorry',
                          icon: false,
                          content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.generalMessages.uploadNotAv:'You cannot upload images to this event.',
                        );
                      });
                },
                child: Row(

                  children: [
                    Icon(Icons.camera_alt,color: Colors.black,),
                    SizedBox(width: 4,),
                    Text(
                      languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.widgetAlerts.fromCamera: 'From Camera',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black,),
                    ),

                  ],
                ),
              ),
              RaisedButton(
                elevation: 0,
                highlightElevation: 0,
                highlightColor: kColorBackGround,
                color: Colors.white,
              onPressed:((authModal.checksResponseModel?.mediaType=='image')==true||(authModal.checksResponseModel?.mediaType=='image/video')==true)? (){

                  widget.onGalleryPress();
                  Navigator.pop(context);
                  }:(){
                showDialog(
                    context: context,
                    builder: (BuildContext context)
                    {
                      return AlertPopup(
                        title: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.generalMessages.sorry: 'Sorry',
                        icon: false,
                        content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.generalMessages.uploadNotAv:'You cannot upload images to this event',
                      );
                    });
              },

                child: Row(

                  children: [
                    Icon(Icons.image,color: Colors.black,),
                    SizedBox(width: 4,),
                    Text(
                      languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.widgetAlerts.fromGallery: 'From Gallery',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black,),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                elevation: 0,
                highlightElevation: 0,
                highlightColor: kColorBackGround,
                color: Colors.white,
                onPressed:((authModal.checksResponseModel?.mediaType=='video')==true||(authModal.checksResponseModel?.mediaType=='image/video')==true)? () {
                  print('video.....');
                  widget.onVideoPress();
                  Navigator.pop(context);
                }:(){
                  showDialog(
                      context: context,
                      builder: (BuildContext context)
                      {
                        return AlertPopup(
                          title: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.generalMessages.sorry: 'Sorry',
                          icon: false,
                          content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.generalMessages.vidUploadNotAv: 'You cannot upload videos to this event',
                        );
                      });
                },

                child: Row(

                  children: [
                    Icon(Icons.videocam,color: Colors.black,),
                    SizedBox(width: 4,),
                    Text(
                      languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.widgetAlerts.fromVideo: 'From Video',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black,),
                    ),



                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
