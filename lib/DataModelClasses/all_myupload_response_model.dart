class AllMyUploadResponseModel {
  AllMyUploadResponseModel({
    required this.status,
    required this.gal,
    required this.message,
  });
  late final bool status;
  late final List<Gal> gal;
  late final String message;

  AllMyUploadResponseModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    gal = List.from(json['gal']).map((e)=>Gal.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['gal'] = gal.map((e)=>e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class Gal {
  Gal({
    required this.id,
    required this.image,
    required this.uid,
    required this.pid,
    required this.likesCount,
    required this.commentsCount,
    required this.isPrivate,
    required this.type,
    required this.isDeleted,
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
  late final String type;
  late final bool isDeleted;
  late final List<dynamic> comments;
  late final List<dynamic> likes;
  late final int V;
  late final String createdAt;
  late final String updatedAt;

  Gal.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    image = json['image'];
    uid = json['uid'];
    pid = json['pid'];
    likesCount = json['likes_count'];
    commentsCount = json['commentsCount'];
    isPrivate = json['isPrivate'];
    type = json['type'];
    isDeleted = json['isDeleted'];
    comments = List.castFrom<dynamic, dynamic>(json['comments']);
    likes = List.castFrom<dynamic, dynamic>(json['likes']);
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
    _data['type'] = type;
    _data['isDeleted'] = isDeleted;
    _data['comments'] = comments;
    _data['likes'] = likes;
    _data['__v'] = V;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}