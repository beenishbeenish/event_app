
  class LikeResponseModel {
    LikeResponseModel({
  required this.status,
  required this.image,
  required this.liked,
  required this.message,
  });
  late final bool status;
  late final Image image;
  late final bool liked;
  late final String message;

    LikeResponseModel.fromJson(Map<String, dynamic> json){
  status = json['status'];
  image = Image.fromJson(json['image']);
  liked = json['liked'];
  message = json['message'];
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['status'] = status;
  _data['image'] = image.toJson();
  _data['liked'] = liked;
  _data['message'] = message;
  return _data;
  }
  }

  class Image {
  Image({
  required this.id,
  required this.image,
  required this.uid,
  required this.pid,
  required this.likesCount,
  required this.commentsCount,
  required this.isPrivate,
  required this.comments,
  required this.likes,
  required this.V,
  required this.createdAt,
  required this.updatedAt,
  });
  late final String id;
  late final String image;
  late final String uid;
  late final String pid;
  late final int likesCount;
  late final int commentsCount;
  late final bool isPrivate;
  late final List<Comments> comments;
  late final List<Likes> likes;
  late final int V;
  late final String createdAt;
  late final String updatedAt;

  Image.fromJson(Map<String, dynamic> json){
  id = json['_id'];
  image = json['image'];
  uid = json['uid'];
  pid = json['pid'];
  likesCount = json['likes_count'];
  commentsCount = json['commentsCount'];
  isPrivate = json['isPrivate'];
  comments = List.from(json['comments']).map((e)=>Comments.fromJson(e)).toList();
  likes = List.from(json['likes']).map((e)=>Likes.fromJson(e)).toList();
  V = json['__v'];
  createdAt = json['createdAt'];
  updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['_id'] = id;
  _data['image'] = image;
  _data['uid'] = uid;
  _data['pid'] = pid;
  _data['likes_count'] = likesCount;
  _data['commentsCount'] = commentsCount;
  _data['isPrivate'] = isPrivate;
  _data['comments'] = comments.map((e)=>e.toJson()).toList();
  _data['likes'] = likes.map((e)=>e.toJson()).toList();
  _data['__v'] = V;
  _data['createdAt'] = createdAt;
  _data['updatedAt'] = updatedAt;
  return _data;
  }
  }

  class Comments {
  Comments({
  required this.comments,
  required this.id,
  });
  late final String comments;
  late final String id;

  Comments.fromJson(Map<String, dynamic> json){
  comments = json['comments'];
  id = json['_id'];
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['comments'] = comments;
  _data['_id'] = id;
  return _data;
  }
  }

  class Likes {
  Likes({
  required this.id,
  });
  late final String id;

  Likes.fromJson(Map<String, dynamic> json){
  id = json['_id'];
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['_id'] = id;
  return _data;
  }
  }