class AllGreetingResponse {
  AllGreetingResponse({
    required this.status,
    required this.message,
    required this.greetings,
  });
  late final bool status;
  late final String message;
  late final Greetings greetings;

  AllGreetingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    greetings = Greetings.fromJson(json['greetings']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['greetings'] = greetings.toJson();
    return _data;
  }
}

class Greetings {
  Greetings({
    required this.id,
    required this.eventId,
    required this.title,
    required this.description,
    required this.userId,
    required this.images,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final String id;
  late final String eventId;
  late final String title;
  late final String description;
  late final String userId;
  late final List<Images> images;
  late final bool isDeleted;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  Greetings.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    eventId = json['event_id'];
    title = json['title'];
    description = json['description'];
    userId = json['user_id'];
    images = List.from(json['images']).map((e) => Images.fromJson(e)).toList();
    isDeleted = json['is_deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['event_id'] = eventId;
    _data['title'] = title;
    _data['description'] = description;
    _data['user_id'] = userId;
    _data['images'] = images.map((e) => e.toJson()).toList();
    _data['is_deleted'] = isDeleted;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}

class Images {
  Images({
    required this.file,
    required this.fileType,
    required this.id,
  });
  late final String file;
  late final String fileType;
  late final String id;

  Images.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    fileType = json['file_type'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['file'] = file;
    _data['file_type'] = fileType;
    _data['_id'] = id;
    return _data;
  }
}
