import 'package:event_app/Provider/auth_class.dart';
import 'package:event_app/Provider/data_class.dart';
import 'package:event_app/Provider/events_class.dart';
import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Provider/task_provider.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Views/task_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class TasksCompleteScreen extends StatefulWidget {
  const TasksCompleteScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TasksCompleteScreen> createState() => _TasksCompleteScreenState();
}

class _TasksCompleteScreenState extends State<TasksCompleteScreen> {
  @override
  void initState() {
    super.initState();
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    taskProvider.checkTaskCompleteResponseModel = null;
    taskProvider.allCompletedTaskResponseModel = null;
    Future.delayed(Duration.zero, () async {
      taskProvider.checkIsRandomTasksCompleted(
          eventId: AppGlobal.eventId, token: AppGlobal.token, context: context);
    });
    // postModel.getPostsDetails();
    // Future.delayed(Duration.zero, () async {
    //
    // taskProvider.selectedRandomTask(
    //     eventId: AppGlobal.eventId,
    //     context: context,
    //     token: AppGlobal.token);}
    // );
    Future.delayed(Duration.zero, () async {
      taskProvider.getCompletedTasks(
          context: context, eventId: AppGlobal.eventId, token: AppGlobal.token);
    });
  }

  dateFormate({
    required String datefrom,
  }) {
    final DateTime docDateTime = DateTime.parse(datefrom);

    return '${DateFormat('dd.MM.yyyy').format(docDateTime)}';
  }

  getGalleryImage(languageModel) async {
    print('gallery');
    final eventModal = Provider.of<EventClass>(context, listen: false);
    //final languageModel = Provider.of<LanguageClass>(context,listen: false);

    List<XFile>? imageFileList = [];

    final picker = ImagePicker();
    final List<XFile>? selectedImages = await picker.pickMultiImage();
    // await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    // print('image...${pickedFile.toString()}');

    if (selectedImages!.isNotEmpty) {
      if (eventModal.image!.length < 5) {
        if (selectedImages.length <= 4 && eventModal.image!.length < 5) {
          print(
            'Images.. less than 5',
          );
          imageFileList.addAll(selectedImages);
          eventModal.getImageAddress(imageFileList);
          print("Image List Length:" + imageFileList.length.toString());
        } else {
          // return  showDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return AlertPopup(
          //         title: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.Warning: "Warning!",
          //         content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.pleaseUpload5imagesAtatime: 'Please Select maximum 5 images \nat a time.',
          //       );
          //     });
        }
      } else {
        // return showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertPopup(
        //         title: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.Warning: "Warning!",
        //         content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.pleaseUpload5imagesAtatime: 'Please Select maximum 5 images \nat a time.',
        //       );
        //     });
      }
    } else {
      print('No image selected.');
    }
  }

  getGalleryVideo() async {
    print('gallery');
    final postModel = Provider.of<DataClass>(context, listen: false);

    final greetingModel = Provider.of<EventClass>(context, listen: false);
    List<XFile>? imageFileList = [];

    final picker = ImagePicker();
    final XFile? video = await picker.pickVideo(
        source: ImageSource.gallery, maxDuration: Duration(minutes: 3));
    // await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    // print('image...${pickedFile.toString()}');
    print('videos......${video?.path}');
    if (video != null) {
      // postModel.uploadloading=true;
      imageFileList.add(video);

      // postModel.getUploadImageResponse(token: AppGlobal.token,eventId: AppGlobal.eventId, imageAdress: imageFileList,pid:AppGlobal.pId,context: context).then((value) {
      //   postModel.uploadloading = false;
      // });
      //       postModel.uploadloading=true;
      //       postModel.getUploadImageResponse(token: AppGlobal.token,eventId: AppGlobal.eventId, imageAdress: imageFileList,pid:AppGlobal.pId,context: context).then((value){
      //         postModel.uploadloading=false;
      //
      //       }).catchError((e){
      //         postModel.uploadloading=false;
      //
      //       });
      //
      //       // greetingModel.getImageAddress(imageFileList);
      //       print("Image List Length:" + imageFileList.length.toString());
      //
      //
    } else {
      print('No image selected.');
    }
  }

  getCameraImage(languageModel) async {
    List<XFile>? imageFileList = [];
    final eventModal = Provider.of<EventClass>(context, listen: false);
    //final languageModel = Provider.of<LanguageClass>(context,listen: false);

    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 20,
    );
    if (pickedFile != null) {
      if (eventModal.image!.length < 6 && eventModal.image!.length < 5) {
        if (imageFileList.length <= 5) {
          print(
            'Images.. less than 5',
          );
          imageFileList.add(pickedFile);
          eventModal.getImageAddress(imageFileList);
          print("Image List Length:" + imageFileList.length.toString());
        } else {
          // return  showDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return AlertPopup(
          //         title: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.Warning: "Warning!",
          //         content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.pleaseUpload5imagesAtatime: 'Please Select maximum 5 images \nat a time.',
          //       );
          //     });
        }
      } else {
        // return showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertPopup(
        //         title: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.Warning: "Warning!",
        //         content: languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.pleaseUpload5imagesAtatime: 'Please Select maximum 5 images \nat a time.',
        //       );
        //     });
      }
      // File image = File(pickedFile.path);
      // List<XFile> stringList =
      //     (jsonDecode(pickedFile.path) as List<dynamic>).cast<XFile>();

      print('image...${pickedFile}');
    } else {
      print('No image selected.');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final eventModel = Provider.of<EventClass>(context);
    final authModal = Provider.of<AuthClass>(context);
    final taskProvider = Provider.of<TaskProvider>(context);
    final postModel = Provider.of<DataClass>(context);
    final languageModel = Provider.of<LanguageClass>(context);
    return Scaffold(
      backgroundColor: kColorBackGround,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              taskProvider
                  .checkIsRandomTasksCompleted(
                      eventId: AppGlobal.eventId,
                      context: context,
                      token: AppGlobal.token)
                  .then((value) {
                if (taskProvider
                    .checkTaskCompleteResponseModel!.tasksAvailable) {
                  taskProvider
                      .selectedRandomTask(
                        context: context,
                        token: AppGlobal.token,
                        eventId: AppGlobal.eventId,
                      )
                      .then((value) {});
                }
              });
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        title: Text(
          languageModel.languageResponseModel != null
              ? languageModel.languageResponseModel!.mobileTasks.tasksCompleted
              : 'Completed Tasks',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: kColorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // floatingActionButton: taskProvider.checkTaskCompleteResponseModel!=null?taskProvider.checkTaskCompleteResponseModel!.tasksAvailable?FloatingActionButton.extended(
      //   backgroundColor: kColorPrimary,
      //   onPressed: (){
      //     taskProvider.checkIsRandomTasksCompleted(
      //         eventId: AppGlobal.eventId,
      //         context: context,
      //         token: AppGlobal.token).then((value){
      //           if(taskProvider.checkTaskCompleteResponseModel!.tasksAvailable){
      //               taskProvider.selectedRandomTask(
      //                 context: context,
      //                 token: AppGlobal.token,
      //                 eventId: AppGlobal.eventId,).then((value){
      //
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (BuildContext context) =>
      //                         const YourTaskScreen(
      //                             title: 'Categories'))).then(
      //                         (value) {
      //                       if (value == true){
      //                         taskProvider.getCompletedTasks(
      //                             context: context,
      //                             eventId: AppGlobal.eventId, token: AppGlobal.token);
      //                       }
      //                     });
      //               });
      //             }
      //     });
      //
      //   },
      //   label: Row(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.only(right: 4.0),
      //         child:  Container(
      //           margin: EdgeInsets.only(right: 5),
      //           child: SvgPicture.asset(
      //               "assets/icons/awesome-random.svg", height: 18,
      //               width: 20,
      //               color: Colors.white,
      //               semanticsLabel: ''),
      //         ),
      //       ),
      //       const Text("Random Task",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16
      //       ),)
      //     ],
      //   ),
      // ):SizedBox():SizedBox(),
      // drawer: Drawer(
      //     child: Column(
      //   children: [
      //     InkWell(
      //       onTap: () {
      //         // Navigator.push(
      //         //     context,
      //         //     MaterialPageRoute(
      //         //         builder: (BuildContext context) =>
      //         //             const EventProfileScreen(title: 'Categories')));
      //         Navigator.pop(context);
      //         Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (BuildContext context) =>
      //                     const EventProfileScreen(title: 'Categories')));
      //       },
      //       child: Container(
      //         height: screenSize.height * 0.2,
      //         width: screenSize.width,
      //         color: kColorPrimary,
      //         child: Padding(
      //           padding: const EdgeInsets.only(right: 10),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Row(
      //                 children: [
      //                   const SizedBox(
      //                     width: 15,
      //                   ),
      //                   CircleAvatar(
      //                     radius: 35.0,
      //                     backgroundColor: Colors.white,
      //                     child: CachedNetworkImage(
      //                       imageUrl: AppGlobal.profileImage,
      //                       imageBuilder: (context, imageProvider) => Container(
      //                         decoration: BoxDecoration(
      //                           shape: BoxShape.circle,
      //                           image: DecorationImage(
      //                             image: imageProvider,
      //                             fit: BoxFit.fill,
      //                           ),
      //                         ),
      //                       ),
      //                       progressIndicatorBuilder:
      //                           (context, url, downloadProgress) =>    ClipRRect(
      //                             borderRadius: BorderRadius.circular(35),
      //                             child: Container(
      //                               width: 100.0,
      //                               height: 100.0,
      //                               decoration: BoxDecoration(borderRadius: BorderRadius.circular( 35.0,)),
      //                               child: Shimmer.fromColors(
      //                                 direction:ShimmerDirection.ttb ,
      //                                 baseColor: Colors.grey.shade300,
      //                                 highlightColor: Colors.grey.shade100,
      //                                 enabled: true,
      //                                 child:Container(
      //                                   color: Colors.grey.shade200,
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                       errorWidget: (context, url, error) => const Icon(
      //                         Icons.image_not_supported,
      //                         color: Colors.grey,
      //                         size: 35,
      //                       ),
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     width: 15,
      //                   ),
      //                   Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       SizedBox(
      //                         height: screenSize.height * 0.06,
      //                       ),
      //                       Container(
      //                         child: Text(
      //                           eventModel.eventResponseModel != null
      //                               ? eventModel.eventResponseModel!.event!
      //                                   .generalInfo.eventName
      //                               : '',
      //                           style: const TextStyle(
      //                               color: Colors.white, fontSize: 24),
      //                         ),
      //                         width: screenSize.width * 0.4,
      //                       ),
      //                       const SizedBox(
      //                         height: 10,
      //                       ),
      //                       Text(
      //                         eventModel.eventResponseModel != null
      //                             ? dateFormate(
      //                                 datefrom:
      //                                     eventModel.eventResponseModel!.event!.generalInfo.dateFrom)
      //                             : '',
      //                         style: const TextStyle(
      //                           fontSize: 12,
      //                           color: Colors.white,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //               const Icon(
      //                 Icons.arrow_forward_ios_outlined,
      //                 color: Colors.white,
      //                 size: 13,
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     Container(
      //       height: screenSize.height * 0.8,
      //       width: screenSize.width,
      //       color: kColorBackGround,
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Column(
      //             children: [
      //               Container(
      //                 child: ListTile(
      //                   leading: SvgPicture.asset(
      //                       "assets/icons/gallery_icon.svg",
      //                       color: kColorPrimary,
      //                       height: 18,
      //                       width: 18,
      //                       semanticsLabel: ''),
      //                   title:  Text(
      //                     languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.homeTitle: 'Gallery',
      //                     style: const TextStyle(
      //                         color: kColorPrimary,
      //                         fontWeight: FontWeight.w600),
      //                   ),
      //                   onTap: () {
      //                     Navigator.pop(context);
      //                     Navigator.pushReplacement(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (BuildContext context) =>
      //                                 const GalleryScreen(
      //                                     title: 'Categories')));
      //                   },
      //                 ),
      //               ),
      //               Divider(
      //                 height: 1,
      //                 color: Colors.grey.shade300,
      //               ),
      //               Container(
      //                 color: kColorPrimary.withOpacity(0.3),
      //                 child: ListTile(
      //                   leading: SvgPicture.asset(
      //                       "assets/icons/Icon open-task.svg",
      //                       color: kColorPrimary,
      //                       height: 18,
      //                       width: 18,
      //                       semanticsLabel: ''),
      //                   title:  Text(
      //                     languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.tasksTitle:'Tasks',
      //
      //                     style: const TextStyle(
      //                         color: kColorPrimary,
      //                         fontWeight: FontWeight.w600),
      //                   ),
      //                   onTap: () {
      //                     //
      //                     // Navigator.pop(context);
      //                     // Navigator.pushReplacement(
      //                     //     context,
      //                     //     MaterialPageRoute(
      //                     //         builder: (BuildContext context) =>
      //                     //             const TasksScreen(title: 'Categories')));
      //                   },
      //                 ),
      //               ),
      //               Divider(
      //                 height: 1,
      //                 color: Colors.grey.shade300,
      //               ),
      //               // ListTile(
      //               //   leading: SvgPicture.asset(
      //               //       "assets/icons/Icon material-event.svg",
      //               //       color: kColorPrimary,
      //               //       height: 18,
      //               //       width: 18,
      //               //       semanticsLabel: ''),
      //               //   title:  Text(
      //               //     languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.EventPageTitle:'Event Page',
      //               //     style: const TextStyle(
      //               //         color: kColorPrimary, fontWeight: FontWeight.w600),
      //               //   ),
      //               //   onTap: () {
      //               //     Navigator.pop(context);
      //               //     Navigator.pushReplacement(
      //               //         context,
      //               //         MaterialPageRoute(
      //               //             builder: (BuildContext context) =>
      //               //                 const EventProfileScreen(
      //               //                     title: 'Categories')));
      //               //   },
      //               // ),
      //               // Divider(
      //               //   height: 1,
      //               //   color: Colors.grey.shade300,
      //               // ),
      //               ListTile(
      //                 leading: SvgPicture.asset(
      //                     "assets/icons/Icon feather-smile.svg",
      //                     color: kColorPrimary,
      //                     height: 18,
      //                     width: 18,
      //                     semanticsLabel: ''),
      //                 title:  Text(
      //                   languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.GreetingsTitle: 'Greetings',
      //                   style: const TextStyle(
      //                       color: kColorPrimary, fontWeight: FontWeight.w600),
      //                 ),
      //                 onTap: () {
      //                   Navigator.pop(context);
      //                   Navigator.pushReplacement(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (BuildContext context) =>
      //                               const GreetingsScreen(
      //                                   title: 'Categories')));
      //                 },
      //               ),
      //               Divider(
      //                 height: 1,
      //                 color: Colors.grey.shade300,
      //               ),
      //               ListTile(
      //                 leading: SvgPicture.asset(
      //                     "assets/icons/Icon feather-smile.svg",
      //                     color: kColorPrimary,
      //                     height: 18,
      //                     width: 18,
      //                     semanticsLabel: ''),
      //                 title:  Text(
      //                   languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.AppLanguageTitle :'App Language',
      //                   style: const TextStyle(
      //                       color: kColorPrimary,
      //                       fontWeight: FontWeight.w600),
      //                 ),
      //                 onTap: () {
      //                   Navigator.pop(context);
      //                   showDialog(
      //                       context: context,
      //                       builder: (BuildContext context) {
      //                         return LanguagePopup(
      //                           onGalleryPress: (){},
      //
      //                         );
      //                       });
      //                   // Navigator.pushReplacement(
      //                   //     context,
      //                   //     MaterialPageRoute(
      //                   //         builder: (BuildContext context) =>
      //                   //         const GreetingsScreen(
      //                   //             title: 'Categories')));
      //                 },
      //               ),
      //               Divider(
      //                 height: 1,
      //                 color: Colors.grey.shade300,
      //               ),
      //               ListTile(
      //                 leading: SvgPicture.asset("assets/icons/Path 6659.svg",
      //                     color: kColorPrimary,
      //                     height: 18,
      //                     width: 18,
      //                     semanticsLabel: ''),
      //                 title:  Text(
      //                   languageModel.languageResponseModel!=null?languageModel.languageResponseModel!.AppLanguage.ProfileTitle:  'Profile',
      //                   style: const TextStyle(
      //                     color: kColorPrimary,
      //                     fontWeight: FontWeight.w600,
      //
      //                   ),
      //                 ),
      //                 onTap: () {
      //                   Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (BuildContext context) =>
      //                           const ProfileScreen(
      //                           )));
      //                 },
      //               ),
      //             ],
      //           ),
      //           Column(
      //             children: [
      //               ListTile(
      //                 leading: Icon(Icons.share,color: kColorPrimary,),
      //                 title:  Text(
      //                   'Share',
      //                   style: TextStyle(
      //                     color: kColorPrimary,
      //                     fontWeight: FontWeight.w600,
      //                     decoration: TextDecoration.underline,
      //                   ),
      //                 ),
      //                 onTap: () {
      //                   Share.share('check out my website https://example.com', subject: 'Look what I made!');
      //                 },
      //               ),
      //               ListTile(
      //                 leading: SvgPicture.asset("assets/icons/Group 7693.svg",
      //                     color: kColorPrimary,
      //                     height: 18,
      //                     width: 18,
      //                     semanticsLabel: ''),
      //                 title:  Text(
      //                   languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.DatapolicyTitle:'Data Policy',
      //                   style: TextStyle(
      //                     color: kColorPrimary,
      //                     fontWeight: FontWeight.w600,
      //                     decoration: TextDecoration.underline,
      //                   ),
      //                 ),
      //                 onTap: () {
      //                   Navigator.pop(context);
      //                   Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (BuildContext context) =>
      //                               DataPolicyScreen(
      //                               )));
      //                 },
      //               ),
      //               // ListTile(
      //               //   leading: SvgPicture.asset("assets/icons/Path 6659.svg",
      //               //       color: kColorPrimary,
      //               //       height: 18,
      //               //       width: 18,
      //               //       semanticsLabel: ''),
      //               //   title:  Text(
      //               //     languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.data[0].attributes.imprintTitle:'Imprint',
      //               //
      //               //     style: TextStyle(
      //               //       color: kColorPrimary,
      //               //       fontWeight: FontWeight.w600,
      //               //       decoration: TextDecoration.underline,
      //               //     ),
      //               //   ),
      //               //   onTap: () {},
      //               // ),
      //               ListTile(
      //                 leading: SvgPicture.asset(
      //                     "assets/icons/Icon open-account-logout.svg",
      //                     color: kColorPrimary,
      //                     height: 18,
      //                     width: 18,
      //                     semanticsLabel: ''),
      //                 title:  Text(
      //                   languageModel.languageResponseModel!=null? languageModel.languageResponseModel!.AppLanguage.Logout : 'Logout',
      //                   style: const TextStyle(
      //                       color: kColorPrimary, fontWeight: FontWeight.w600),
      //                 ),
      //                 onTap: () async {
      //
      //                   FlutterSecureStorage storage = const FlutterSecureStorage();
      //                   final String? type= await storage.read(key: 'sign_type');
      //                   if(type=='google')
      //                   {
      //                     await FirebaseAuth.instance.signOut().then((value){
      //                       print('Signout Succesfull');
      //                     }).catchError((e){
      //                       print('Signout error....$e');
      //
      //                     });
      //
      //                   }
      //                   await storage.deleteAll();
      //                   AppGlobal.token='';
      //                   AppGlobal.eventId='';
      //                   AppGlobal.pId='';
      //                   authModal.authModel=null;
      //                   taskProvider.taskCompletedDetailsResponseModel=null;
      //                   taskProvider.taskCompletedResponseModel=null;
      //                   taskProvider.randomTaskResponseModel=null;
      //
      //                   Navigator.pop(context);
      //                   Navigator.pushReplacement(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (BuildContext context) =>
      //                               const FirstInfoScreen()));
      //                 },
      //               ),
      //
      //             ],
      //           ),
      //         ],
      //       ),
      //     )
      //   ],
      // )),
      body: taskProvider.loading
          ? Center(
              child: Container(
                child: SpinKitFadingCircle(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kColorPrimary,
                      ),
                    );
                  },
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       InkWell(
                //         onTap: () {
                //           taskProvider.getCompletedTasks(
                //             context: context,
                //               eventId: AppGlobal.eventId, token: AppGlobal.token);
                //         },
                //         child: Container(
                //           width: screenSize.width * 0.35,
                //           height: 50,
                //           decoration: BoxDecoration(
                //             border: Border.all(
                //               color: !taskProvider.completedTasksSelected
                //                   ? kColorPrimary
                //                   : kColorTransparentButton,
                //               width: 2.0,
                //             ),
                //             borderRadius: BorderRadius.circular(100),
                //             color: !taskProvider.completedTasksSelected
                //                 ? kColorPrimary
                //                 : kColorPrimary.withOpacity(0.2),
                //           ),
                //           child: Center(
                //             child: SvgPicture.asset(
                //                 "assets/icons/Icon feather-clipboard.svg",
                //                 color: !taskProvider.completedTasksSelected
                //                     ? Colors.white
                //                     : Colors.blueGrey,
                //                 height: 20,
                //                 width: 20,
                //                 semanticsLabel: ''),
                //           ),
                //         ),
                //       ),
                //       InkWell(
                //         onTap: () {
                //           taskProvider.getCompletedTasks(
                //             context: context,
                //               eventId: AppGlobal.eventId, token: AppGlobal.token);
                //         },
                //         child: Container(
                //           width: screenSize.width * 0.35,
                //           height: 50,
                //           decoration: BoxDecoration(
                //             border: Border.all(
                //               color: taskProvider.completedTasksSelected
                //                   ? kColorPrimary
                //                   : kColorTransparentButton,
                //               width: 2.0,
                //             ),
                //             borderRadius: BorderRadius.circular(100),
                //             color: taskProvider.completedTasksSelected
                //                 ? kColorPrimary
                //                 : kColorPrimary.withOpacity(0.2),
                //           ),
                //           child: Center(
                //             child: Icon(
                //               Icons.check,
                //               color: taskProvider.completedTasksSelected
                //                   ? Colors.white
                //                   : Colors.blueGrey,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                taskProvider.allCompletedTaskResponseModel != null
                    ? taskProvider
                                .allCompletedTaskResponseModel!.task.isEmpty ||
                            taskProvider
                                    .allCompletedTaskResponseModel!.status ==
                                false
                        ? Container(
                            height: screenSize.height * 0.85,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 4,
                                    shadowColor: kColorPrimary,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      height: screenSize.height * 0.20,
                                      width: screenSize.width * 0.95,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SimpleCircularProgressBar(
                                            valueNotifier: ValueNotifier(0),
                                            backColor: kColorBackGround,
                                            backStrokeWidth: 17,
                                            size: screenSize.height * 0.14,
                                            progressColors: const [
                                              kColorPrimary
                                            ],
                                            fullProgressColor: kColorPrimary,
                                            progressStrokeWidth: 17,
                                            mergeMode: true,
                                            onGetText: (double value) {
                                              return Text('0 %');
                                            },
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                languageModel
                                                            .languageResponseModel !=
                                                        null
                                                    ? languageModel
                                                        .languageResponseModel!
                                                        .mobileTasks
                                                        .tasksProgress
                                                    : 'Tasks Progress',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 15,
                                                    width: 15,
                                                    decoration: BoxDecoration(
                                                      color: kColorPrimary,
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade200,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text('0' +
                                                      ' ${languageModel.languageResponseModel != null ? languageModel.languageResponseModel!.mobileTasks.tasksCompleted : 'Tasks Completed'}')
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 15,
                                                    width: 15,
                                                    decoration: BoxDecoration(
                                                      color: kColorBackGround,
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade200,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text('${taskProvider.allCompletedTaskResponseModel != null ? taskProvider.allCompletedTaskResponseModel!.randomCount : 0}' +
                                                      ' ${languageModel.languageResponseModel != null ? languageModel.languageResponseModel!.mobileTasks.tastsPending : 'Tasks Pending'}')
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: taskProvider
                                                  .allCompletedTaskResponseModel !=
                                              null
                                          ? taskProvider
                                              .allCompletedTaskResponseModel!
                                              .task
                                              .length
                                          : 0,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        TaskDetailsScreen(
                                                            taskId: taskProvider
                                                                .allCompletedTaskResponseModel!
                                                                .task[index]
                                                                .id,
                                                            title: taskProvider
                                                                        .allCompletedTaskResponseModel !=
                                                                    null
                                                                ? taskProvider
                                                                    .allCompletedTaskResponseModel!
                                                                    .task[index]
                                                                    .name
                                                                : ''))).then(
                                                (value) async {
                                              if (value == true) {
                                                await taskProvider
                                                    .checkIsRandomTasksCompleted(
                                                        eventId:
                                                            AppGlobal.eventId,
                                                        token: AppGlobal.token,
                                                        context: context);
                                                print('Task completed....');
                                                taskProvider.getCompletedTasks(
                                                    context: context,
                                                    eventId: AppGlobal.eventId,
                                                    token: AppGlobal.token);
                                              }
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${languageModel.languageResponseModel != null ? languageModel.languageResponseModel!.mobileTasks.task : 'Task'} ${index + 1}',
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color:
                                                                  kColorGreyText),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          taskProvider.allCompletedTaskResponseModel !=
                                                                  null
                                                              ? taskProvider
                                                                  .allCompletedTaskResponseModel!
                                                                  .task[index]
                                                                  .name
                                                              : '',
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color:
                                                                  kColorGreyText),
                                                        ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        width:
                                                            screenSize.width *
                                                                0.15,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color:
                                                                kColorPrimary,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: kColorPrimary,
                                                        ),
                                                        child: const Center(
                                                          child: Icon(
                                                            Icons.check,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider()
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                  SizedBox(
                                    height: screenSize.height * 0.1,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            height: screenSize.height * 0.85,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 4,
                                    shadowColor: kColorPrimary,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      height: screenSize.height * 0.20,
                                      width: screenSize.width * 0.95,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SimpleCircularProgressBar(
                                            valueNotifier: ValueNotifier(((taskProvider
                                                                .allCompletedTaskResponseModel !=
                                                            null
                                                        ? taskProvider
                                                                .allCompletedTaskResponseModel!
                                                                .completeCount! /
                                                            taskProvider
                                                                .allCompletedTaskResponseModel!
                                                                .randomCount!
                                                        : 0.0) *
                                                    100)
                                                .toDouble()),
                                            backColor: kColorBackGround,
                                            backStrokeWidth: 17,
                                            size: screenSize.height * 0.14,
                                            progressColors: const [
                                              kColorPrimary
                                            ],
                                            fullProgressColor: kColorPrimary,
                                            progressStrokeWidth: 17,
                                            mergeMode: true,
                                            onGetText: (double value) {
                                              return Text(
                                                  '${((taskProvider.allCompletedTaskResponseModel != null ? taskProvider.allCompletedTaskResponseModel!.completeCount! / taskProvider.allCompletedTaskResponseModel!.randomCount! : 0.0) * 100).toInt()}%');
                                            },
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                languageModel
                                                            .languageResponseModel !=
                                                        null
                                                    ? languageModel
                                                        .languageResponseModel!
                                                        .mobileTasks
                                                        .tasksProgress
                                                    : 'Tasks Progress',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 15,
                                                    width: 15,
                                                    decoration: BoxDecoration(
                                                      color: kColorPrimary,
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade200,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text('${taskProvider.allCompletedTaskResponseModel != null ? taskProvider.allCompletedTaskResponseModel!.completeCount.toString() : 0}' +
                                                      ' ${languageModel.languageResponseModel != null ? languageModel.languageResponseModel!.mobileTasks.tasksCompleted : 'Tasks Completed'}')
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 15,
                                                    width: 15,
                                                    decoration: BoxDecoration(
                                                      color: kColorBackGround,
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade200,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text('${taskProvider.allCompletedTaskResponseModel != null ? taskProvider.allCompletedTaskResponseModel!.randomCount! - taskProvider.allCompletedTaskResponseModel!.completeCount! : ''} ' +
                                                      ' ${languageModel.languageResponseModel != null ? languageModel.languageResponseModel!.mobileTasks.tastsPending : 'Tasks Pending'}')
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: taskProvider
                                                  .allCompletedTaskResponseModel !=
                                              null
                                          ? taskProvider
                                              .allCompletedTaskResponseModel!
                                              .task
                                              .length
                                          : 0,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        TaskDetailsScreen(
                                                            taskId: taskProvider
                                                                .allCompletedTaskResponseModel!
                                                                .task[index]
                                                                .id,
                                                            title: taskProvider
                                                                        .allCompletedTaskResponseModel !=
                                                                    null
                                                                ? taskProvider
                                                                    .allCompletedTaskResponseModel!
                                                                    .task[index]
                                                                    .name
                                                                : ''))).then(
                                                (value) async {
                                              if (value == true) {
                                                await taskProvider
                                                    .checkIsRandomTasksCompleted(
                                                        eventId:
                                                            AppGlobal.eventId,
                                                        token: AppGlobal.token,
                                                        context: context);
                                                print('Task completed....');
                                                taskProvider.getCompletedTasks(
                                                    context: context,
                                                    eventId: AppGlobal.eventId,
                                                    token: AppGlobal.token);
                                              }
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${languageModel.languageResponseModel != null ? languageModel.languageResponseModel!.mobileTasks.task : 'Task'} ${index + 1}',
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color:
                                                                  kColorGreyText),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          taskProvider.allCompletedTaskResponseModel !=
                                                                  null
                                                              ? taskProvider
                                                                  .allCompletedTaskResponseModel!
                                                                  .task[index]
                                                                  .name
                                                              : '',
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color:
                                                                  kColorGreyText),
                                                        ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        width:
                                                            screenSize.width *
                                                                0.15,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color:
                                                                kColorPrimary,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: kColorPrimary,
                                                        ),
                                                        child: const Center(
                                                          child: Icon(
                                                            Icons.check,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider()
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                  SizedBox(
                                    height: screenSize.height * 0.1,
                                  ),
                                ],
                              ),
                            ),
                          )
                    : Container(
                        height: screenSize.height * 0.85,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Card(
                                elevation: 4,
                                shadowColor: kColorPrimary,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  height: screenSize.height * 0.20,
                                  width: screenSize.width * 0.95,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SimpleCircularProgressBar(
                                            valueNotifier: ValueNotifier(((taskProvider
                                                                .allCompletedTaskResponseModel !=
                                                            null
                                                        ? taskProvider
                                                                .allCompletedTaskResponseModel!
                                                                .completeCount! /
                                                            taskProvider
                                                                .allCompletedTaskResponseModel!
                                                                .randomCount!
                                                        : 0.0) *
                                                    100)
                                                .toDouble()),
                                            backColor: kColorBackGround,
                                            backStrokeWidth: 17,
                                            progressColors: const [
                                              kColorPrimary
                                            ],
                                            fullProgressColor: kColorPrimary,
                                            progressStrokeWidth: 17,
                                            size: screenSize.height * 0.14,
                                            mergeMode: true,
                                            onGetText: (double value) {
                                              return Text(
                                                  '${((taskProvider.allCompletedTaskResponseModel != null ? taskProvider.allCompletedTaskResponseModel!.completeCount! / taskProvider.allCompletedTaskResponseModel!.randomCount! : 0.0) * 100).toInt()}%');
                                            },
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            languageModel
                                                        .languageResponseModel !=
                                                    null
                                                ? languageModel
                                                    .languageResponseModel!
                                                    .mobileTasks
                                                    .tasksProgress
                                                : 'Tasks Progress',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                  color: kColorPrimary,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade200,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text('${taskProvider.allCompletedTaskResponseModel != null ? taskProvider.allCompletedTaskResponseModel!.completeCount.toString() : 0}' +
                                                  ' ${languageModel.languageResponseModel != null ? languageModel.languageResponseModel!.mobileTasks.tasksCompleted : 'Tasks Completed'}')
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                  color: kColorBackGround,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade200,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text('${taskProvider.allCompletedTaskResponseModel != null ? taskProvider.allCompletedTaskResponseModel!.randomCount! - taskProvider.allCompletedTaskResponseModel!.completeCount! : ''} ' +
                                                  ' ${languageModel.languageResponseModel != null ? languageModel.languageResponseModel!.mobileTasks.tastsPending : 'Tasks Pending'}')
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: taskProvider
                                              .allCompletedTaskResponseModel !=
                                          null
                                      ? taskProvider
                                          .allCompletedTaskResponseModel!
                                          .task
                                          .length
                                      : 0,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    TaskDetailsScreen(
                                                        taskId: taskProvider
                                                            .allCompletedTaskResponseModel!
                                                            .task[index]
                                                            .id,
                                                        title: taskProvider
                                                                    .allCompletedTaskResponseModel !=
                                                                null
                                                            ? taskProvider
                                                                .allCompletedTaskResponseModel!
                                                                .task[index]
                                                                .name
                                                            : ''))).then(
                                            (value) async {
                                          if (value == true) {
                                            await taskProvider
                                                .checkIsRandomTasksCompleted(
                                                    eventId: AppGlobal.eventId,
                                                    token: AppGlobal.token,
                                                    context: context);
                                            print('Task completed....');
                                            taskProvider.getCompletedTasks(
                                                context: context,
                                                eventId: AppGlobal.eventId,
                                                token: AppGlobal.token);
                                          }
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${languageModel.languageResponseModel != null ? languageModel.languageResponseModel!.mobileTasks.task : 'Task'} ${index + 1}',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color:
                                                              kColorGreyText),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      taskProvider.allCompletedTaskResponseModel !=
                                                              null
                                                          ? taskProvider
                                                              .allCompletedTaskResponseModel!
                                                              .task[index]
                                                              .name
                                                          : '',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color:
                                                              kColorGreyText),
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    width:
                                                        screenSize.width * 0.15,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: kColorPrimary,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: kColorPrimary,
                                                    ),
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider()
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
    );
  }
}
