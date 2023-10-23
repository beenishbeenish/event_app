// import 'dart:convert';
// import 'dart:ffi';
// import 'dart:io';
//
// import 'package:dotted_border/dotted_border.dart';
// import 'package:event_app/Provider/data_class.dart';
// import 'package:event_app/Provider/events_class.dart';
// import 'package:event_app/Provider/language_class.dart';
// import 'package:event_app/Provider/task_provider.dart';
// import 'package:event_app/Utils/app_colors.dart';
// import 'package:event_app/Utils/app_global.dart';
// import 'package:event_app/Widegts/alert_popup_widget.dart';
// import 'package:event_app/Widegts/image_popup_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
//
// class YourTaskScreen extends StatefulWidget {
//   const YourTaskScreen({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<YourTaskScreen> createState() => _YourTaskScreenState();
// }
//
// class _YourTaskScreenState extends State<YourTaskScreen> {
//   @override
//   void initState() {
//     super.initState();
//     final eventModel = Provider.of<EventClass>(context, listen: false);
//     eventModel.videoAdded(false);
//
//     eventModel.image=[];
//     Future.delayed(Duration.zero, () async {
//       eventModel.deleteAllProviderData();
//     });
//     Future.delayed(Duration.zero, () async {
//
//       eventModel.getlAllChecksInfo(token: AppGlobal.token, eventId: AppGlobal.eventId);
//     });
//
//   }
//   void dispose() {
//     // controller.dispose();
//
//
//     super.dispose();
//   }
//   getGalleryImage(languageModel) async {
//     print('gallery');
//     final eventModal = Provider.of<EventClass>(context, listen: false);
//     //final languageModel = Provider.of<LanguageClass>(context,listen: false);
//
//     List<XFile>? imageFileList = [];
//     if(imageFileList.isNotEmpty){
//       imageFileList.clear();
//     }
//
//     final picker = ImagePicker();
//     imageFileList = await picker.pickMultiImage(imageQuality: 20);
//     // await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
//     // print('image...${pickedFile.toString()}');
//
//      List<XFile>? selectedImages=[];
//     if(selectedImages.isNotEmpty){
//       selectedImages.clear();
//     }
//
//     if (imageFileList!.isNotEmpty ) {
//       selectedImages.add(imageFileList.first);
//       eventModal.videoAdded(false);
//       print("Length: ${selectedImages.length}");
//       if(eventModal.isVideoAdded==false) {
//         if (eventModal.image!.length < 5) {
//
//           if (selectedImages.length <= 5 &&
//               selectedImages.length + eventModal.image!.length <= 5) {
//
//
//             // imageFileList.addAll(selectedImages);
//             eventModal.getImageAddress(selectedImages);
//
//           } else {
//             return showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertPopup(
//                     title:languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.Warning: 'Warning!',
//                     content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.pleaseUpload5imagesAtatime:'Please Select media',
//                   );
//                 });
//           }
//         } else {
//           return showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertPopup(
//                   title:languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.Warning: 'Warning!',
//                   content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.pleaseUpload5imagesAtatime:'Please Select media',
//                 );
//               });
//         }
//       }
//       else{
//         if (eventModal.image!.length < 6) {
//
//           if (selectedImages.length <= 6 &&
//               selectedImages.length + eventModal.image!.length <= 6) {
//
//
//             // imageFileList.addAll(selectedImages);
//             eventModal.getImageAddress(selectedImages);
//
//           } else {
//             return showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertPopup(
//                     title:languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.Warning: 'Warning!',
//                     content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.pleaseUpload5imagesAtatime:'Please Select media',
//                   );
//                 });
//           }
//         } else {
//           return showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertPopup(
//                   title:languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.Warning: 'Warning!',
//                   content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.pleaseUpload5imagesAtatime:'Please Select media',
//                 );
//               });
//         }
//       }
//     } else {
//       print('No image selected.');
//
//     }
//   }
//   getGalleryVideo(languageModel) async {
//     print('gallery');
//     final eventModel = Provider.of<EventClass>(context, listen: false);
//     //final languageModel = Provider.of<LanguageClass>(context,listen: false);
//     // final greetingModel = Provider.of<EventClass>(context, listen: false);
//     List<XFile>? imageFileList = [];
//
//     final picker = ImagePicker();
//     final XFile? video = await picker.pickVideo(source: ImageSource.gallery,maxDuration: Duration(minutes: 3));
//     // await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
//     // print('image...${pickedFile.toString()}');
//     print('videos......${video?.path}');
//     if (video!=null) {
//       if(imageFileList.length <= 5 && imageFileList.length+eventModel.image!.length<=6&&eventModel.isVideoAdded==false)
//       {
//         imageFileList.add(video);
//         print('videos....${video.path}');
//         eventModel.videoAdded(true);
//         eventModel.getImageAddress(imageFileList);
//       }
//       else{
//         return showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertPopup(
//                 title:languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.Warning: 'Warning!',
//                 content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.pleaseUpload5imagesAtatime:'Please Select media',
//               );
//             });
//       }
//
//
//     } else {
//       print('No image selected.');
//
//     }
//     // if (video!=null) {
//     //
//     //   // postModel.uploadloading=true;
//     //   imageFileList.add(video);
//     //
//     //
//     //   // postModel.getUploadImageResponse(token: AppGlobal.token,eventId: AppGlobal.eventId, imageAdress: imageFileList,pid:AppGlobal.pId,context: context).then((value) {
//     //   //   postModel.uploadloading = false;
//     //   // });
//     //   //       postModel.uploadloading=true;
//     //   //       postModel.getUploadImageResponse(token: AppGlobal.token,eventId: AppGlobal.eventId, imageAdress: imageFileList,pid:AppGlobal.pId,context: context).then((value){
//     //   //         postModel.uploadloading=false;
//     //   //
//     //   //       }).catchError((e){
//     //   //         postModel.uploadloading=false;
//     //   //
//     //   //       });
//     //   //
//     //   //       // greetingModel.getImageAddress(imageFileList);
//     //   //       print("Image List Length:" + imageFileList.length.toString());
//     //   //
//     //   //
//     // } else {
//     //   print('No image selected.');
//     //
//     // }
//   }
//   getCameraImage(languageModel) async {
//     List<XFile>? imageFileList = [];
//     final eventModal = Provider.of<EventClass>(context, listen: false);
//     //final languageModel = Provider.of<LanguageClass>(context,listen: false);
//
//     final picker = ImagePicker();
//     final XFile? pickedFile = await picker.pickImage(
//       source: ImageSource.camera,
//       imageQuality: 20,
//     );
//     if (pickedFile != null) {
//       eventModal.videoAdded(false);
//       if(eventModal.isVideoAdded==false) {
//         if (eventModal.image!.length < 5) {
//
//           if (imageFileList.length <= 5 &&
//               imageFileList.length + eventModal.image!.length <= 5) {
//
//             imageFileList.add(pickedFile);
//
//             // imageFileList.add(pickedFile);
//             eventModal.getImageAddress(imageFileList);
//           } else {
//             return showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertPopup(
//                     title:languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.Warning: 'Warning!',
//                     content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.pleaseUpload5imagesAtatime:'Please Select media',
//                   );
//                 });
//           }
//         } else {
//           return showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertPopup(
//                   title:languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.Warning: 'Warning!',
//                   content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.pleaseUpload5imagesAtatime:'Please Select media',
//                 );
//               });
//         }
//       }
//       else{
//         if (eventModal.image!.length < 6) {
//
//
//           if (imageFileList.length <= 6 &&
//               imageFileList.length + eventModal.image!.length <= 6) {
//
//             imageFileList.add(pickedFile);
//             // imageFileList.add(pickedFile);
//             eventModal.getImageAddress(imageFileList);
//
//           } else {
//             return showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertPopup(
//                     title:languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.Warning: 'Warning!',
//                     content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.pleaseUpload5imagesAtatime:'Please Select media',
//                   );
//                 });
//           }
//         } else {
//           return showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertPopup(
//                   title:languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.Warning: 'Warning!',
//                   content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.pleaseUpload5imagesAtatime:'Please Select media',
//                 );
//               });
//         }
//       }
//       // File image = File(pickedFile.path);
//       // List<XFile> stringList =
//       //     (jsonDecode(pickedFile.path) as List<dynamic>).cast<XFile>();
//
//
//     } else {
//
//     }
//     // if (pickedFile != null) {
//     //   if (eventModal.image!.length < 6  && eventModal.image!.length < 5) {
//     //     if(imageFileList.length<=5){
//     //       print(
//     //         'Images.. less than 5',
//     //       );
//     //       imageFileList.add(pickedFile);
//     //       eventModal.getImageAddress(imageFileList);
//     //       print("Image List Length:" + imageFileList.length.toString());
//     //     }
//     //     else{
//     //
//     //       return  showDialog(
//     //           context: context,
//     //           builder: (BuildContext context) {
//     //             return AlertPopup(
//     //               title: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.data[0].attributes.Warning: "Warning!",
//     //               content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.data[0].attributes.maximum5images: 'Please Select maximum 5 images \nat a time.',
//     //             );
//     //           });
//     //     }
//     //
//     //   } else {
//     //     return showDialog(
//     //         context: context,
//     //         builder: (BuildContext context) {
//     //           return AlertPopup(
//     //             title: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.data[0].attributes.Warning: "Warning!",
//     //             content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.data[0].attributes.maximum5images: 'Please Select maximum 5 images \nat a time.',
//     //           );
//     //         });
//     //   }
//     //   // File image = File(pickedFile.path);
//     //   // List<XFile> stringList =
//     //   //     (jsonDecode(pickedFile.path) as List<dynamic>).cast<XFile>();
//     //
//     //
//     //   print('image...${pickedFile}');
//     // } else {
//     //   print('No image selected.');
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//     final eventModel = Provider.of<EventClass>(context);
//     final languageModel = Provider.of<LanguageClass>(context);
//     final taskProvider = Provider.of<TaskProvider>(context);
//
//     return Scaffold(
//       backgroundColor: kColorBackGround,
//       appBar: AppBar(
//         leading: InkWell(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: const Icon(Icons.arrow_back_ios)),
//         title:  Text(
//           languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.yourTask: 'Your Task',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: kColorPrimary,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//         child: Column(
//           children: [
//             Container(
//                 width: screenSize.width * 0.85,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   color: kColorPrimary.withOpacity(0.2),
//                 ),
//                 child: Center(
//                   child: Padding(
//                   padding: EdgeInsets.all(15),
//                   child: Text(
//                     taskProvider.randomTaskResponseModel != null
//                         ? taskProvider.randomTaskResponseModel!.task!=null?taskProvider.randomTaskResponseModel!.task!.name
//                         : '': '',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: kColorBrownText, fontSize: 17),
//                   ),
//                 ))),
//             const SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25),
//               child: Text(
//                 languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.pleasePerformAboveTask: 'Please perform the task above',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.grey.shade500,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: screenSize.height * 0.02,
//             ),
//             eventModel.image!.isEmpty
//                 ? InkWell(
//                     onTap: () {
//                       showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return ImagePopup(
//                               onVideoPress: (){
//                                 getGalleryVideo(languageModel);
//                               },
//                               onCameraPress: () {
//                                 getCameraImage(languageModel);
//                               },
//                               onGalleryPress: () {
//                                 getGalleryImage(languageModel);
//                               },
//                             );
//                           });
//                       // getImage();
//                     },
//                     child: DottedBorder(
//                       radius: const Radius.circular(100),
//                       dashPattern: const [10, 8],
//                       color: kColorPrimary,
//                       borderType: BorderType.RRect,
//                       child: Container(
//                         height: 40,
//                         width: double.maxFinite,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(
//                             100,
//                           ),
//                         ),
//                         clipBehavior: Clip.antiAliasWithSaveLayer,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children:  [
//                             Text(
//                               languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.uploadimagesVideos:  'UPLOAD IMAGE/VIDEO',
//                               textAlign: TextAlign.center,
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   color: kColorPrimary),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 : Container(
//                     height: screenSize.height * 0.40,
//                     child: SingleChildScrollView(
//                       child: GridView.builder(
//                         //itemCount: eventModel.image!.length+1 ,
//                         itemCount: eventModel.image!.length,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         scrollDirection: Axis.vertical,
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                 childAspectRatio: 25 / 26,
//                                 crossAxisSpacing: 8,
//                                 crossAxisCount: 3),
//                         itemBuilder: (BuildContext context, int index) {
//                           return
//                             // index == eventModel.image!.length
//                             //   ? Padding(
//                             //       padding: const EdgeInsets.symmetric(
//                             //           horizontal: 0, vertical: 5),
//                             //       child: InkWell(
//                             //         onTap: () {
//                             //           showDialog(
//                             //               context: context,
//                             //               builder: (BuildContext context) {
//                             //                 return ImagePopup(
//                             //                   onVideoPress: (){},
//                             //                   onCameraPress: () {
//                             //                     getCameraImage(languageModel);
//                             //                   },
//                             //                   onGalleryPress: () {
//                             //                     getGalleryImage(languageModel);
//                             //                   },
//                             //                 );
//                             //               });
//                             //         },
//                             //         child: Container(
//                             //           decoration: BoxDecoration(
//                             //             border: Border.all(
//                             //               color: kColorPrimary,
//                             //               width: 2.0,
//                             //             ),
//                             //             borderRadius: BorderRadius.circular(20),
//                             //             // color: Colors.black,
//                             //           ),
//                             //           child: const Icon(
//                             //             Icons.add,
//                             //             color: kColorPrimary,
//                             //             size: 70,
//                             //           ),
//                             //         ),
//                             //       ),
//                             //     )
//                             //   :
//                             Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 0, vertical: 5),
//                                   child: InkWell(
//                                     onTap: () {},
//                                     child: Stack(
//                                       children: [
//                                         Stack(
//
//                                           children: [
//                                             eventModel.isVideoAdded?Container(
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                     color: kColorPrimary,
//                                                     width: 2.0,
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(20),
//                                                   color: Colors.black,
//                                                   image: DecorationImage(
//                                                     image: FileImage(
//                                                       File(eventModel
//                                                           .image![index].path),
//                                                     ),
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                   // boxShadow: const [
//                                                   //   BoxShadow(
//                                                   //    // color: Colors.black26,
//                                                   //     spreadRadius: 1,
//                                                   //     blurRadius: 8,
//                                                   //     offset: Offset(0, 3),
//                                                   //   )
//                                                   // ]
//                                               ),
//                                             ):Container(
//                                               decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                   color: kColorPrimary,
//                                                   width: 2.0,
//                                                 ),
//                                                 borderRadius:
//                                                 BorderRadius.circular(20),
//                                                 //color: Colors.black,
//                                                 image: DecorationImage(
//                                                   image: FileImage(
//                                                     File(eventModel
//                                                         .image![index].path),
//                                                   ),
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                                 // boxShadow: const [
//                                                 //   BoxShadow(
//                                                 //    // color: Colors.black26,
//                                                 //     spreadRadius: 1,
//                                                 //     blurRadius: 8,
//                                                 //     offset: Offset(0, 3),
//                                                 //   )
//                                                 // ]
//                                               ),
//                                             ),
//                                             eventModel.isVideoAdded?
//                                             const Icon(Icons.play_circle_outline_rounded,size: 24,color: kColorPrimary,):const SizedBox()
//                                           ],
//                                           alignment: Alignment.center,
//                                         ),
//                                         Positioned(
//                                             right: -5,
//                                             top: -4,
//                                             child: IconButton(
//                                                 onPressed: eventModel.loading?(){}:() {
//
//                                                   print('index ${index}');
//                                                   eventModel.removeImageAddress(
//                                                       index);
//                                                 },
//                                                 icon: const Icon(
//                                                   Icons.close,
//                                                   color: kColorPrimary,
//                                                 )))
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                         },
//                       ),
//                     ),
//                   ),
//             SizedBox(
//               height: screenSize.height * 0.1,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
//               child: InkWell(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                     width: screenSize.width,
//                     height: 50,
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                           color:eventModel.image!.isEmpty?kColorGreyButton:kColorPrimary,
//                           width: 2.0,
//                         ),
//                         borderRadius: BorderRadius.circular(100),
//                         color: eventModel.image!.isEmpty?kColorGreyButton:kColorPrimary,
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.black26,
//                             spreadRadius: 1,
//                             blurRadius: 2,
//                             offset: Offset(0, 4),
//                           )
//                         ]),
//                     child: InkWell(
//                       onTap: () async {
//                       // if(eventModel.image!.isEmpty)
//                       //   {
//                       //     ///Todo change the error message from Strapi
//                       //     showDialog(
//                       //         context: context,
//                       //         builder: (BuildContext context) {
//                       //           return AlertPopup(
//                       //             title:languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.Warning: "Warning!",
//                       //             content:languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.pleaseUpload5imagesAtatime:  'Please Select media',
//                       //           );
//                       //         });
//                       //   }
//                       // else{
//                         if(eventModel.image!.isNotEmpty){
//                         await eventModel.getImageUriData(
//                             imageAdress: eventModel.image!,
//                             context: context,
//                             taskId: taskProvider.randomTaskResponseModel!.task!.id,
//                             pid: AppGlobal.pId,
//                             token: AppGlobal.token);
//                         if (eventModel.imageUploadModel!.status == true) {
//                           await eventModel.randomTaskComplete(
//                               pId: AppGlobal.pId,
//                               context: context,
//                               taskId: taskProvider.randomTaskResponseModel!.task!.id,
//                               token: AppGlobal.token);
//                           print('Task completed....');
//                           taskProvider.randomTaskResponseModel = null;
//                           // taskProvider.randomTasksSelected = false;
//                           // Navigator.pop(context);
//                           Navigator.of(context).pop(true);
//                           eventModel.image = [];
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertPopup(
//                                   title:languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.completedTask+'!': 'Task completed!',
//                                   icon: true,
//                                   iconname: Icons.check_circle_rounded,
//                                   content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.TaskCompletedSuccessfully: 'Task completed successfully.',
//                                 );
//                               });
//
//                         }
//                       }
//
//
//                         // eventModel.getImageUriData(
//                         //     imageAdress: eventModel.image!);
//                       },
//                       child:eventModel.loading? Container(
//                         child: SpinKitFadingCircle(
//                           itemBuilder: (BuildContext context, int index) {
//                             return DecoratedBox(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 color: Colors.white,
//                               ),
//                             );
//                           },
//                         ),
//                       ): Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Icon(
//                               Icons.upload,
//                               color: Colors.white,
//                             ),
//                              Center(
//                                 child: Text(
//                                   languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.uploadWithTask:'UPLOAD',
//                               style:
//                                   const TextStyle(color: Colors.white, fontSize: 17),
//                             )),
//                             const Icon(
//                               Icons.upload,
//                               color: Colors.white,
//                             ),
//                           ],
//                         ),
//                       ),
//                     )),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }