
  class TaskCompletedDetailsResponseModel {
    TaskCompletedDetailsResponseModel({
  required this.status,
  required this.task,
  required this.images,
  });
  late final bool status;
  late final Task task;
  late final List<Images> images;

    TaskCompletedDetailsResponseModel.fromJson(Map<String, dynamic> json){
  status = json['status'];
  task = Task.fromJson(json['task']);
  images = List.from(json['images']).map((e)=>Images.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['status'] = status;
  _data['task'] = task.toJson();
  _data['images'] = images.map((e)=>e.toJson()).toList();
  return _data;
  }
  }

  class Task {
  Task({
  required this.id,
  required this.name,
  required this.status,
  required this.createdBy,
  required this.createdAt,
  required this.updatedAt,
  required this.V,
  });
  late final String id;
  late final String name;
  late final int status;
  late final String createdBy;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  Task.fromJson(Map<String, dynamic> json){
  id = json['_id'];
  name = json['name'];
  status = json['status'];
  createdBy = json['createdBy'];
  createdAt = json['createdAt'];
  updatedAt = json['updatedAt'];
  V = json['__v'];
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['_id'] = id;
  _data['name'] = name;
  _data['status'] = status;
  _data['createdBy'] = createdBy;
  _data['createdAt'] = createdAt;
  _data['updatedAt'] = updatedAt;
  _data['__v'] = V;
  return _data;
  }
  }

  class Images {
  Images({
  required this.id,
  required this.image,
  required this.taskId,
  required this.uid,
  required this.pid,
  required this.likesCount,
  required this.commentsCount,
  required this.isPrivate,
  required this.type,
  required this.comments,
  required this.likes,
  required this.V,
  required this.createdAt,
  required this.updatedAt,
  required this.isLiked,
  });
  late final String id;
  late final String image;
  late final String taskId;
  late final String uid;
  late final String pid;
  late  int likesCount;
  late final int commentsCount;
  late final bool isPrivate;
  late final String type;
  late final List<dynamic> comments;
  late final List<Likes> likes;
  late final int V;
  late final String createdAt;
  late final String updatedAt;
  late final bool isLiked;

  Images.fromJson(Map<String, dynamic> json){
  id = json['_id'];
  image = json['image'];
  taskId = json['taskId'];
  uid = json['uid'];
  pid = json['pid'];
  likesCount = json['likes_count'];
  commentsCount = json['commentsCount'];
  isPrivate = json['isPrivate'];
  type = json['type'];
  comments = List.castFrom<dynamic, dynamic>(json['comments']);
  likes = List.from(json['likes']).map((e)=>Likes.fromJson(e)).toList();
  V = json['__v'];
  createdAt = json['createdAt'];
  updatedAt = json['updatedAt'];
  isLiked = json['is_liked'];
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
  _data['comments'] = comments;
  _data['likes'] = likes.map((e)=>e.toJson()).toList();
  _data['__v'] = V;
  _data['createdAt'] = createdAt;
  _data['updatedAt'] = updatedAt;
  _data['is_liked'] = isLiked;
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