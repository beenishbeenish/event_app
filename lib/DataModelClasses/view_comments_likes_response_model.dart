
    class ViewCommentLikesResponseModel {
        ViewCommentLikesResponseModel({
            required this.status,
            required this.likesCount,
            required this.commentsCount,
            required this.message,
            required this.image,
        });
        late final bool status;
        late final int likesCount;
        late final int commentsCount;
        late final String? message;
        late final Image image;

        ViewCommentLikesResponseModel.fromJson(Map<String, dynamic> json){
            status = json['status'];
            likesCount = json['likes_count'];
            commentsCount = json['comments_count'];
            message = json['message']??'';
            image = Image.fromJson(json['image']);
        }

        Map<String, dynamic> toJson() {
            final _data = <String, dynamic>{};
            _data['status'] = status;
            _data['likes_count'] = likesCount;
            _data['comments_count'] = commentsCount;
            _data['message'] = message;
            _data['image'] = image.toJson();
            return _data;
        }
    }

    class Image {
        Image({
            required this.id,
            required this.likesCount,
            required this.comments,
            required this.likes,
            required this.commentscount,
        });
        late final String id;
        late final int likesCount;
        late final List<Comments> comments;
        late final List<Likes> likes;
        late final int commentscount;

        Image.fromJson(Map<String, dynamic> json){
            id = json['_id'];
            likesCount = json['likes_count'];
            comments = List.from(json['comments']).map((e)=>Comments.fromJson(e)).toList();
            likes = List.from(json['likes']).map((e)=>Likes.fromJson(e)).toList();
            commentscount = json['commentscount'];
        }

        Map<String, dynamic> toJson() {
            final _data = <String, dynamic>{};
            _data['_id'] = id;
            _data['likes_count'] = likesCount;
            _data['comments'] = comments.map((e)=>e.toJson()).toList();
            _data['likes'] = likes.map((e)=>e.toJson()).toList();
            _data['commentscount'] = commentscount;
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