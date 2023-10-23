
  class PostCommentResponseModel {
    PostCommentResponseModel({
      required this.status,
      required this.galLikes,
      required this.message,
    });
    late final bool status;
    late final GalLikes galLikes;
    late final String message;

    PostCommentResponseModel.fromJson(Map<String, dynamic> json){
      status = json['status'];
      galLikes = GalLikes.fromJson(json['galLikes']);
      message = json['message'];
    }

    Map<String, dynamic> toJson() {
      final _data = <String, dynamic>{};
      _data['status'] = status;
      _data['galLikes'] = galLikes.toJson();
      _data['message'] = message;
      return _data;
    }
  }

  class GalLikes {
    GalLikes({
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
    late final String taskId;
    late final String uid;
    late final String pid;
    late final int likesCount;
    late final int commentsCount;
    late final bool isPrivate;
    late final String type;
    late final bool isDeleted;
    late final List<Comments> comments;
    late final List<Likes> likes;
    late final int V;
    late final String createdAt;
    late final String updatedAt;

    GalLikes.fromJson(Map<String, dynamic> json){
      id = json['_id'];
      image = json['image'];
      taskId = json['taskId']??'';
      uid = json['uid'];
      pid = json['pid'];
      likesCount = json['likes_count'];
      commentsCount = json['commentsCount'];
      isPrivate = json['isPrivate'];
      type = json['type'];
      isDeleted = json['isDeleted'];
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
      _data['taskId'] = taskId;
      _data['uid'] = uid;
      _data['pid'] = pid;
      _data['likes_count'] = likesCount;
      _data['commentsCount'] = commentsCount;
      _data['isPrivate'] = isPrivate;
      _data['type'] = type;
      _data['isDeleted'] = isDeleted;
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
      required this.createdAt,
      required this.id,
    });
    late final String comments;
    late final String createdAt;
    late final String id;

    Comments.fromJson(Map<String, dynamic> json){
      comments = json['comments'];
      createdAt = json['createdAt'];
      id = json['_id'];
    }

    Map<String, dynamic> toJson() {
      final _data = <String, dynamic>{};
      _data['comments'] = comments;
      _data['createdAt'] = createdAt;
      _data['_id'] = id;
      return _data;
    }
  }

  class Likes {
    Likes({
      required this.userId,
      required this.id,
    });
    late final String userId;
    late final String id;

    Likes.fromJson(Map<String, dynamic> json){
      userId = json['user_id'];
      id = json['_id'];
    }

    Map<String, dynamic> toJson() {
      final _data = <String, dynamic>{};
      _data['user_id'] = userId;
      _data['_id'] = id;
      return _data;
    }
  }