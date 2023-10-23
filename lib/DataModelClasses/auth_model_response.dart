
    class AuthModel {
      AuthModel({
    required this.status,
    required this.user,
    required this.message,
    });
    late final bool status;
    late final User user;
    late final String message;

    AuthModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    user = User.fromJson(json['user']);
    message = json['message'];
    }

    Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['user'] = user.toJson();
    _data['message'] = message;
    return _data;
    }
    }

    class User {
    User({

    required this.id,
    required this.deviceId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
    required this.name,

    required this.socialEmail,
    required this.photoURL,
    });

    late final String? id;
    late final String? deviceId;
    late final int status;
    late final String? createdAt;
    late final String? updatedAt;
    late final int V;
    late final String? name;

    late final String? socialEmail;
    late final String? photoURL;

    User.fromJson(Map<String, dynamic> json){

    id = json['_id']??'';
    deviceId = json['deviceId']??'';
    status = json['status'];
    createdAt = json['createdAt']??'';
    updatedAt = json['updatedAt']??'';
    V = json['__v'];
    name = json['username']??'';

    socialEmail = json['socialEmail']??'';
    photoURL = json['photoURL']??'';
    }

    Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['_id'] = id;
    _data['deviceId'] = deviceId;
    _data['status'] = status;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    _data['name'] = name;

    _data['socialEmail'] = socialEmail;
    _data['photoURL'] = photoURL;
    return _data;
    }
    }

    class Profile {
    Profile({
    required this.imageKey,
    });
    late final String imageKey;

    Profile.fromJson(Map<String, dynamic> json){
    imageKey = json['image_key'];
    }

    Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image_key'] = imageKey;
    return _data;
    }
    }