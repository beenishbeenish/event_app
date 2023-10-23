import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeletePopup extends StatefulWidget {
  final String content;
  // final Function() onGalleryPress;
  final Function() onDeletePress;
  const DeletePopup({Key? key,
    required this.onDeletePress,
     this.content='',

  }) : super(key: key,);

  @override
  State<DeletePopup> createState() => _DeletePopupState();
}

class _DeletePopupState extends State<DeletePopup> {
  @override
  Widget build(BuildContext context) {
    final languageModel = Provider.of<LanguageClass>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 160,
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
                style: TextStyle(color:kColorTextField ,fontSize: 20),
              ),
              SizedBox(height: 13,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 230,
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
              SizedBox(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    elevation: 0,
                color: Colors.white,
                    onPressed:(){
                      // widget.onGalleryPress();
                      Navigator.pop(context);
                    },

                    child: Text(
                      languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.infoScreen.cancel: 'Cancel',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: kColorPrimary,fontWeight: FontWeight.w500,fontSize: 18),
                    ),
                  ),
                  RaisedButton(
                    elevation: 0,
                    color: Colors.white,
                    onPressed:(){
                      widget.onDeletePress();
                      Navigator.pop(context);
                    },

                    child: Text(
                      languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.imageView.delete: 'Delete',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: kColorPrimary,fontWeight: FontWeight.w500,fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
