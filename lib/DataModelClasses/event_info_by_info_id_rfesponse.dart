class EventInfoByInfoIdResponse {
  EventInfoByInfoIdResponse({
    required this.status,
    required this.event,
    required this.totalImages,
    required this.totalguest,
    required this.totalVideos,
    required this.message,
  });
  late final bool status;
  late final Event event;
  late final int totalImages;
  late final int totalguest;
  late final int totalVideos;
  late final String message;

  EventInfoByInfoIdResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    event = Event.fromJson(json['event']);
    totalImages = json['totalImages'];
    totalguest = json['totalguest'];
    totalVideos = json['totalVideos'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['event'] = event.toJson();
    _data['totalImages'] = totalImages;
    _data['totalguest'] = totalguest;
    _data['totalVideos'] = totalVideos;
    _data['message'] = message;
    return _data;
  }
}

class Event {
  Event({
    //required this.generalInfo,
    required this.id,
    // required this.licenseNumber,
    // required this.licenseId,
    // required this.duration,
    // required this.userId,
    // required this.profileImage,
    // required this.coverImage,
    // this.welcomeImage,
    // required this.isPublic,
    // required this.qrCode,
    required this.mediaTypeallowed,
    required this.maxMedia,
    required this.maxGuest,
    required this.accesstodownloads,
    required this.downloadAllowed,
    // required this.unregisteredGuest,
    // required this.tasks,
    // required this.isDeleted,
    // required this.eventCode,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.V,
    // required this.isCancelled,
  });
  //late final GeneralInfo generalInfo;
  late final String id;
  // late final String licenseNumber;
  // late final String licenseId;
  // late final int duration;
  // late final String userId;
  // late final String profileImage;
  // late final String coverImage;
  // late final Null welcomeImage;
  // late final bool isPublic;
  // late final bool qrCode;
  late final String mediaTypeallowed;
  late final int maxMedia;
  late final int maxGuest;
  late final int accesstodownloads;
  late final String downloadAllowed;
  // late final String unregisteredGuest;
  // late final List<Tasks> tasks;
  // late final bool isDeleted;
  // late final String eventCode;
  // late final String createdAt;
  // late final String updatedAt;
  // late final int V;
  // late final bool isCancelled;

  Event.fromJson(Map<String, dynamic> json) {
    //generalInfo = GeneralInfo.fromJson(json['general_info']);
    id = json['_id'];
    // licenseNumber = json['license_number'];
    // licenseId = json['license_id'];
    // duration = json['duration'];
    // userId = json['user_id'];
    // profileImage = json['profile_image'];
    // coverImage = json['cover_image'];
    // welcomeImage = null;
    // isPublic = json['is_public'];
    // qrCode = json['qrCode'];
    mediaTypeallowed = json['mediaTypeallowed'];
    maxMedia = json['maxMedia'];
    maxGuest = json['maxGuest'];
    accesstodownloads = json['accesstodownloads'];
    downloadAllowed = json['downloadAllowed'];
    // unregisteredGuest = json['unregisteredGuest'];
    // tasks = List.from(json['tasks']).map((e) => Tasks.fromJson(e)).toList();
    // isDeleted = json['is_deleted'];
    // eventCode = json['event_code'];
    // createdAt = json['createdAt'];
    // updatedAt = json['updatedAt'];
    // V = json['__v'];
    // isCancelled = json['is_cancelled'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    //_data['general_info'] = generalInfo.toJson();
    _data['_id'] = id;
    // _data['license_number'] = licenseNumber;
    // _data['license_id'] = licenseId;
    // _data['duration'] = duration;
    // _data['user_id'] = userId;
    // _data['profile_image'] = profileImage;
    // _data['cover_image'] = coverImage;
    // _data['welcome_image'] = welcomeImage;
    // _data['is_public'] = isPublic;
    // _data['qrCode'] = qrCode;
    _data['mediaTypeallowed'] = mediaTypeallowed;
    _data['maxMedia'] = maxMedia;
    _data['maxGuest'] = maxGuest;
    _data['accesstodownloads'] = accesstodownloads;
    _data['downloadAllowed'] = downloadAllowed;
    // _data['unregisteredGuest'] = unregisteredGuest;
    // _data['tasks'] = tasks.map((e) => e.toJson()).toList();
    // _data['is_deleted'] = isDeleted;
    // _data['event_code'] = eventCode;
    // _data['createdAt'] = createdAt;
    // _data['updatedAt'] = updatedAt;
    // _data['__v'] = V;
    // _data['is_cancelled'] = isCancelled;
    return _data;
  }
}

class GeneralInfo {
  GeneralInfo({
    required this.eventName,
    required this.eventLocation,
    required this.description,
    required this.dateFrom,
    required this.dateTo,
    required this.timeFrom,
    required this.timeTo,
  });
  late final String eventName;
  late final String eventLocation;
  late final String description;
  late final String dateFrom;
  late final String dateTo;
  late final String timeFrom;
  late final String timeTo;

  GeneralInfo.fromJson(Map<String, dynamic> json) {
    eventName = json['event_name'];
    eventLocation = json['event_location'];
    description = json['description'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['event_name'] = eventName;
    _data['event_location'] = eventLocation;
    _data['description'] = description;
    _data['date_from'] = dateFrom;
    _data['date_to'] = dateTo;
    _data['time_from'] = timeFrom;
    _data['time_to'] = timeTo;
    return _data;
  }
}

class Tasks {
  Tasks({
    required this.id,
    required this.name,
  });
  late final String id;
  late final String name;

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    return _data;
  }
}
