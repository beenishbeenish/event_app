import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/Provider/auth_class.dart';
import 'package:event_app/Provider/comments_class.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Widegts/alert_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../DataModelClasses/view_comments_likes_response_model.dart';
import '../Provider/language_class.dart';

class CommentsScreen extends StatefulWidget {
  final String imageId;
  final String imageUrl;
  final String userName;
  const CommentsScreen(
      {Key? key,
      required this.title,
      required this.imageId,
      required this.imageUrl,
      required this.userName})
      : super(key: key);

  final String title;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  var _commentTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final commentModel = Provider.of<CommentClass>(context, listen: false);
    commentModel.viewCommentLikesResponseModel = null;
    Future.delayed(Duration.zero, () async {
      commentModel.getCommentS(
          imageId: widget.imageId, token: AppGlobal.token, context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final authModel = Provider.of<AuthClass>(context);
    final commentModel = Provider.of<CommentClass>(context);
    final languageModel = Provider.of<LanguageClass>(context);
    getTimeAgo({
      required String datefrom,
    }) {
      final DateTime docDateTime = DateTime.parse(datefrom);

      return timeago.format(docDateTime);
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kColorBackGround,
      appBar: AppBar(
        // toolbarHeight: 100,
        // centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop(true);
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: Text(
          languageModel.languageResponseModel != null
              ? languageModel.languageResponseModel!.generalMessages.comment
              : 'Comments',
          style: const TextStyle(color: Colors.white),
        ),
        // Column(
        //   children: [
        //     CircleAvatar(
        //       radius: 25.0,
        //       backgroundColor: Colors.white,
        //       child: CachedNetworkImage(
        //         imageUrl: widget.imageUrl,
        //         imageBuilder: (context, imageProvider) => Container(
        //           decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             image: DecorationImage(
        //               image: imageProvider,
        //               fit: BoxFit.fill,
        //             ),
        //           ),
        //         ),
        //         progressIndicatorBuilder: (context, url, downloadProgress) =>
        //           Center(
        //             child: CircularProgressIndicator(
        //               color: kColorPrimary, value: downloadProgress.progress),
        //           ),
        //         errorWidget: (context, url, error) => const Icon(
        //           Icons.error,
        //           color: Colors.black26,
        //           size: 35,
        //         ),
        //       ),
        //     ),
        //     const SizedBox(
        //       height: 5,
        //     ),
        //      Text(
        //        authModel.authModel!=null?authModel.authModel!.user.name!:AppGlobal.userName!,
        //       style: TextStyle(color: Colors.white, fontSize: 14),
        //     ),
        //   ],
        // ),
        backgroundColor: kColorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: commentModel.loading
          ? Center(
              child: Container(
                height: screenSize.height * 0.72,
                alignment: Alignment.center,
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
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        //physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            commentModel.viewCommentLikesResponseModel != null
                                ? commentModel.viewCommentLikesResponseModel!
                                    .image.comments.length
                                : 0,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: kColorPrimary,
                                        child: CachedNetworkImage(
                                          imageUrl: authModel.authModel != null
                                              ? authModel
                                                  .authModel!.user.photoURL!
                                              : '',
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: CircularProgressIndicator(
                                                color: kColorPrimary,
                                                value:
                                                    downloadProgress.progress),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.account_circle_outlined,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            width: screenSize.width * 0.73,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  authModel.authModel != null
                                                      ? authModel
                                                          .authModel!.user.name!
                                                      : commentModel
                                                                  .viewCommentLikesResponseModel !=
                                                              null
                                                          ? AppGlobal.userName!
                                                          : AppGlobal.userName!,
                                                  style: const TextStyle(
                                                      color: kColorBrownText,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  commentModel.viewCommentLikesResponseModel !=
                                                          null
                                                      ? getTimeAgo(
                                                          datefrom: commentModel
                                                                      .viewCommentLikesResponseModel !=
                                                                  null
                                                              ? commentModel
                                                                  .viewCommentLikesResponseModel!
                                                                  .image
                                                                  .comments[
                                                                      index]
                                                                  .createdAt
                                                                  .toString()
                                                              : '')
                                                      : 'Just Now',
                                                  style: const TextStyle(
                                                      color: kColorGreyText,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            width: screenSize.width * 0.73,
                                            child: Text(
                                              commentModel.viewCommentLikesResponseModel !=
                                                      null
                                                  ? commentModel
                                                      .viewCommentLikesResponseModel!
                                                      .image
                                                      .comments[index]
                                                      .comments
                                                  : '',
                                              style: const TextStyle(
                                                  color: kColorBrownText,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider()
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      width: screenSize.width * 0.8,
                      child: TextField(
                        controller: _commentTextController,
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(
                                  color: kColorTextField.withOpacity(0),
                                  width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                  color: kColorTextField, width: 1),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(
                                  color: kColorTextField.withOpacity(0),
                                  width: 1),
                            ),
                            filled: true,
                            hintStyle: const TextStyle(color: kColorGreyButton),
                            hintText:
                                languageModel.languageResponseModel != null
                                    ? languageModel.languageResponseModel!
                                        .generalMessages.addComment
                                    : "Add Comment",
                            fillColor: kColorTextField.withOpacity(0.3)),
                      ),
                    ),
                    commentModel.commentLoading
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
                        : IconButton(
                            icon: Icon(Icons.send),
                            color: kColorPrimary,
                            onPressed: () {
                              commentModel.commentText =
                                  _commentTextController.text.toString();
                              if (commentModel.commentText == null ||
                                  commentModel.commentText.length < 1) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertPopup(
                                        content: languageModel
                                                    .languageResponseModel !=
                                                null
                                            ? languageModel
                                                .languageResponseModel!
                                                .generalMessages
                                                .commentPlaceholder
                                            : 'Please write at least something. \n '
                                                '',
                                      );
                                    });
                              } else {
                                commentModel.commentLoading = true;
                                print(
                                    'Date....${AppGlobal.token} .........${widget.imageId}');
                                commentModel
                                    .postTheComment(
                                        context: context,
                                        imageId: widget.imageId,
                                        token: AppGlobal.token,
                                        commentText: commentModel.commentText)
                                    .then((e) {
                                  final now = DateTime.now().toString();

                                  // commentModel.getCommentS(imageId: widget.imageId, token: AppGlobal.token);
                                  print(
                                      'Date....$now .........${_commentTextController.value.text}');
                                  Comments comment = Comments(
                                    comments: _commentTextController.value.text,
                                    createdAt: now,
                                    id: '1233453535354353453453535',
                                  );
                                  // print('comment....$comment .........${jsonDecode(comment.toString())}');
                                  commentModel.viewCommentLikesResponseModel!
                                      .image.comments
                                      .add(comment);

                                  commentModel.commentText = '';
                                  _commentTextController.clear();
                                  commentModel.commentLoading = false;
                                  commentModel.refreshScreenState();
                                  // commentModel.getCommentS(imageId: widget.imageId, token: AppGlobal.token);
                                }).catchError((e) {
                                  print('eroor....$e');
                                  commentModel.commentLoading = false;
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertPopup(
                                          content: '${e}. \n ' '',
                                        );
                                      });
                                });
                                ;
                              }

                              // eventModel.alertDialogue(
                              //     content:
                              //         'User has not register yet.Please add your details,',
                              //     title: 'Profile Alert',
                              //     context: context,
                              //     onPressOk: () {
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (BuildContext context) =>
                              //               const ProfileScreen()));
                              //     });

                              // if (_formKey.currentState!.validate()) {
                              //
                              // }
                            },
                            iconSize: 34,
                            padding: EdgeInsets.all(8.0),
                            // child: Icon(
                            //   Icons.send,
                            //   color: kColorPrimary,
                            //   size: 35,
                            // ),
                          )
                  ],
                )
              ],
            ),
    );
  }
}
