class EventResponseModel {
  EventResponseModel({
    required this.status,
    required this.event,
    required this.message,
  });
  late final bool status;
  late final Event? event;
  late final String message;

  EventResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    event = json['event'] != null ? Event.fromJson(json['event']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['event'] = event!.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Event {
  Event({
    required this.generalInfo,
    required this.id,
    required this.licenseNumber,
    required this.licenseId,
    required this.userId,
    required this.profileImage,
    required this.coverImage,
    required this.welcomeImage,
    required this.tasks,
    required this.eventCode,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
    required this.qrCode,
  });
  late final GeneralInfo generalInfo;
  late final String id;
  late final String licenseNumber;
  late final String licenseId;
  late final String userId;
  late final String profileImage;
  late final String coverImage;
  late final String welcomeImage;
  late final List<String> tasks;
  late final String createdAt;
  late final String updatedAt;
  late final String eventCode;
  late final int V;
  late final bool qrCode;

  Event.fromJson(Map<String, dynamic> json) {
    generalInfo = GeneralInfo.fromJson(json['general_info']);
    id = json['_id'] ?? '';
    licenseNumber = json['license_number'] ?? '';
    licenseId = json['license_id'] ?? '';
    userId = json['user_id'] ?? '';
    profileImage = json['profile_image'] ?? '';
    coverImage = json['cover_image'] ?? '';
    welcomeImage = json['welcome_image'] ?? '';
    tasks = List.castFrom<dynamic, String>(json['tasks']);
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    eventCode = json['event_code'] ?? '';
    V = json['__v'];
    qrCode = json['qrCode'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['general_info'] = generalInfo.toJson();
    _data['_id'] = id;
    _data['license_number'] = licenseNumber;
    _data['license_id'] = licenseId;
    _data['user_id'] = userId;
    _data['profile_image'] = profileImage;
    _data['cover_image'] = coverImage;
    _data['welcome_image'] = welcomeImage;
    _data['tasks'] = tasks;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['event_code'] = eventCode;
    _data['__v'] = V;
    _data['qrCode'] = qrCode;
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
    eventName = json['event_name'] ?? '';
    eventLocation = json['event_location'] ?? '';
    description = json['description'] ?? '';
    dateFrom = json['date_from'] ?? '';
    dateTo = json['date_to'] ?? '';
    timeFrom = json['time_from'] ?? '';
    timeTo = json['time_to'] ?? '';
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
