class ImageDetailsResponseModel {
  ImageDetailsResponseModel({
    required this.status,
    required this.gal,
    required this.liked,
    required this.image,
    required this.user,
    this.taskDetails,
    required this.message,
  });
  late final bool status;
  late final Gal gal;
  late final bool liked;
  late final List<Image> image;
  late final TaskDetails? taskDetails;
  late final User user;
  late final String message;

  ImageDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    gal = Gal.fromJson(json['gal']);
    liked = json['liked'];
    taskDetails = json['task_details'] != null
        ? TaskDetails.fromJson(json['task_details'])
        : null;
    user = User.fromJson(json['user']);
    image = List.from(json['image']).map((e) => Image.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['gal'] = gal.toJson();
    _data['liked'] = liked;
    _data['user'] = user.toJson();
    _data['image'] = image.map((e) => e.toJson()).toList();
    _data['task_details'] = taskDetails!.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Gal {
  Gal({
    required this.id,
    required this.image,
    required this.taskId,
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
  late final String? taskId;
  late final String uid;
  late final String pid;
  late int likesCount;
  late final int commentsCount;
  late final bool isPrivate;
  late final String type;
  late final bool isDeleted;
  late final List<dynamic> comments;
  late final List<dynamic> likes;
  late final int V;
  late final String createdAt;
  late final String updatedAt;

  Gal.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    image = json['image'];
    taskId = json['taskId'] ?? '';
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
    _data['taskId'] = taskId;
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

class TaskDetails {
  TaskDetails({
    required this.id,
    required this.name,
    required this.unCategorized,
    required this.status,
    required this.isDeleted,
    required this.createdBy,
    required this.V,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String name;
  late final bool unCategorized;
  late final int status;
  late final bool isDeleted;
  late final String createdBy;
  late final int V;
  late final String createdAt;
  late final String updatedAt;

  TaskDetails.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    unCategorized = json['unCategorized'];
    status = json['status'];
    isDeleted = json['is_deleted'];
    createdBy = json['createdBy'];
    V = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    _data['unCategorized'] = unCategorized;
    _data['status'] = status;
    _data['is_deleted'] = isDeleted;
    _data['createdBy'] = createdBy;
    _data['__v'] = V;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}

class User {
  User({
    required this.profile,
    required this.id,
    required this.deviceId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
    required this.username,
  });
  late final Profile profile;
  late final String id;
  late final String deviceId;
  late final int status;
  late final String createdAt;
  late final String updatedAt;
  late final int V;
  late final String username;

  User.fromJson(Map<String, dynamic> json) {
    profile = Profile.fromJson(json['profile']);
    id = json['_id'];
    deviceId = json['deviceId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['profile'] = profile.toJson();
    _data['_id'] = id;
    _data['deviceId'] = deviceId;
    _data['status'] = status;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    _data['username'] = username;
    return _data;
  }
}

class Profile {
  Profile({
    required this.imageLocation,
  });
  late final String imageLocation;

  Profile.fromJson(Map<String, dynamic> json) {
    imageLocation = json['image_location'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image_location'] = imageLocation;
    return _data;
  }
}

class Image {
  Image({
    required this.imageUrl,
  });
  late final String imageUrl;

  Image.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imageUrl'] = imageUrl;
    return _data;
  }
}
