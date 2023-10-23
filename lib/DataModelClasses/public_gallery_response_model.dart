class PublicGalleryResponseModel {
  PublicGalleryResponseModel({
    required this.status,
    required this.gal,
    required this.images,
    required this.message,
    required this.totalMediaCount,
  });
  late bool status;
  late List<Gal> gal;
  late List<String> images;
  late int totalMediaCount;
  late String message;

  PublicGalleryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    gal = List.from(json['gal']).map((e) => Gal.fromJson(e)).toList();
    images = List.castFrom<dynamic, String>(json['images']);
    totalMediaCount = json['total_media_count'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['gal'] = gal.map((e) => e.toJson()).toList();
    _data['images'] = images;
    _data['total_media_count'] = totalMediaCount;
    _data['message'] = message;
    return _data;
  }
}

class Gal {
  Gal({
    required this.id,
    required this.image,
    this.taskId,
    required this.eventId,
    required this.uid,
    required this.pid,
    required this.likesCount,
    required this.commentsCount,
    // required this.isPrivate,
    required this.type,
    // required this.isDeleted,
    // required this.comments,
    // required this.likes,
    // required this.V,
    // required this.createdAt,
    // required this.updatedAt,
    required this.user,
    required this.liked,
    this.task,
  });
  late final String id;
  late final String image;
  late final String? taskId;
  late final String eventId;
  late final String uid;
  late final String pid;
  late int likesCount;
  late int commentsCount;
  // late final bool isPrivate;
  late final String type;
  // late final bool isDeleted;
  // late final List<dynamic> comments;
  // late final List<dynamic> likes;
  // late final int V;
  // late final String createdAt;
  // late final String updatedAt;
  late final User user;
  late bool liked;
  late final Task? task;

  Gal.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    image = json['image'];
    taskId = json['taskId'] ?? '';
    eventId = json['eventId'];
    uid = json['uid'];
    pid = json['pid'];
    likesCount = json['likes_count'];
    commentsCount = json['commentsCount'];
    // isPrivate = json['isPrivate'];
    type = json['type'];
    // isDeleted = json['isDeleted'];
    // comments = List.castFrom<dynamic, dynamic>(json['comments']);
    // likes = List.castFrom<dynamic, dynamic>(json['likes']);
    // V = json['__v'];
    // createdAt = json['createdAt'];
    // updatedAt = json['updatedAt'];
    user = User.fromJson(json['user']);
    liked = json['liked'];
    task = json['task'] != null ? Task.fromJson(json['task']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['image'] = image;
    _data['taskId'] = taskId;
    _data['eventId'] = eventId;
    _data['uid'] = uid;
    _data['pid'] = pid;
    _data['likes_count'] = likesCount;
    _data['commentsCount'] = commentsCount;
    // _data['isPrivate'] = isPrivate;
    _data['type'] = type;
    // _data['isDeleted'] = isDeleted;
    // _data['comments'] = comments;
    // _data['likes'] = likes;
    // _data['__v'] = V;
    // _data['createdAt'] = createdAt;
    // _data['updatedAt'] = updatedAt;
    _data['user'] = user.toJson();
    _data['liked'] = liked;
    _data['task'] = task?.toJson();
    return _data;
  }
}

class User {
  User({
    // required this.profile,
    // required this.id,
    // required this.deviceId,
    // required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.username,
    required this.photoURL,
    // required this.active,
    //required this.name,
    // required this.password,
    // required this.resetToken,
    // required this.socialEmail,
  });
  //late final Profile profile;
  // late final String id;
  // late final String deviceId;
  // late final int status;
  late final String createdAt;
  late final String updatedAt;
  // late final int V;
  late final String username;
  late final String photoURL;
  // late final bool active;
  // late final String name;
  // late final String password;
  // late final String resetToken;
  // late final String socialEmail;

  User.fromJson(Map<String, dynamic> json) {
    // profile = Profile.fromJson(json['profile']);
    // id = json['_id'];
    // deviceId = json['deviceId'];
    // status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    //V = json['__v'];
    username = json['username'];
    photoURL = json['photoURL'] ?? '';
    //active = json['active'];
    //name = json['name'];
    // password = json['password'];
    // resetToken = json['resetToken'];
    // socialEmail = json['socialEmail'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    //_data['profile'] = profile.toJson();
    // _data['_id'] = id;
    // _data['deviceId'] = deviceId;
    // _data['status'] = status;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    //_data['__v'] = V;
    _data['username'] = username;
    _data['photoURL'] = photoURL;
    //_data['active'] = active;
    //_data['name'] = name;
    // _data['password'] = password;
    // _data['resetToken'] = resetToken;
    // _data['socialEmail'] = socialEmail;
    return _data;
  }
}

class Task {
  Task({
    //required this.id,
    required this.name,

    // required this.unCategorized,
    // required this.categoryId,
    // required this.status,
    // required this.isDeleted,
    // required this.createdBy,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.V,
  });
  //late final String id;
  late final String name;

  // late final bool unCategorized;
  // late final String categoryId;
  // late final int status;
  // late final bool isDeleted;
  // late final String createdBy;
  // late final String createdAt;
  // late final String updatedAt;
  // late final int V;

  Task.fromJson(Map<String, dynamic> json) {
    // id = json['_id'];
    name = json['name'];

    // unCategorized = json['unCategorized'];
    // categoryId = json['categoryId'];
    // status = json['status'];
    // isDeleted = json['is_deleted'];
    // createdBy = json['createdBy'];
    // createdAt = json['createdAt'];
    // updatedAt = json['updatedAt'];
    // V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    //_data['_id'] = id;
    _data['name'] = name;

    // _data['unCategorized'] = unCategorized;
    // _data['categoryId'] = categoryId;
    // _data['status'] = status;
    // _data['is_deleted'] = isDeleted;
    // _data['createdBy'] = createdBy;
    // _data['createdAt'] = createdAt;
    // _data['updatedAt'] = updatedAt;
    // _data['__v'] = V;
    return _data;
  }
}
