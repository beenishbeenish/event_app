
      class ImageUploadModel {
        ImageUploadModel({
      required this.status,
      required this.gal,
      required this.message,
      });
      late final bool status;
      late final List<Gal> gal;
      late final String message;

        ImageUploadModel.fromJson(Map<String, dynamic> json){
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
      required this.image,
      required this.uid,
      required this.pid,
      required this.isPrivate,
      required this.id,
      required this.comments,
      required this.V,
      required this.createdAt,
      required this.updatedAt,
      });
      late final String image;
      late final String uid;
      late final String pid;
      late final bool isPrivate;
      late final String id;
      late final List<dynamic> comments;
      late final int V;
      late final String createdAt;
      late final String updatedAt;

      Gal.fromJson(Map<String, dynamic> json){
      image = json['image'];
      uid = json['uid'];
      pid = json['pid'];
      isPrivate = json['isPrivate'];
      id = json['_id'];
      comments = List.castFrom<dynamic, dynamic>(json['comments']);
      V = json['__v'];
      createdAt = json['createdAt'];
      updatedAt = json['updatedAt'];
      }

      Map<String, dynamic> toJson() {
      final _data = <String, dynamic>{};
      _data['image'] = image;
      _data['uid'] = uid;
      _data['pid'] = pid;
      _data['isPrivate'] = isPrivate;
      _data['_id'] = id;
      _data['comments'] = comments;
      _data['__v'] = V;
      _data['createdAt'] = createdAt;
      _data['updatedAt'] = updatedAt;
      return _data;
      }
      }