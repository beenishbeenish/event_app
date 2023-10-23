class GuestCountResponseModel {
  GuestCountResponseModel({
    required this.status,
    required this.imagesCount,
    required this.videoCount,
    required this.maxGuests,
    required this.message,
    required this.profileImage,
    required this.coverImage,
  });
  late final bool status;
  late final int imagesCount;
  late final int videoCount;
  late final int maxGuests;
  late final String message;
  late final String? profileImage;
  late final String? coverImage;

  GuestCountResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    imagesCount = json['imagesCount'];
    videoCount = json['videoCount'];
    maxGuests = json['maxGuests'];
    message = json['message'];
    profileImage = json['event_profile'] ?? '';
    coverImage = json['event_cover'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['imagesCount'] = imagesCount;
    _data['videoCount'] = videoCount;
    _data['maxGuests'] = maxGuests;
    _data['message'] = message;
    return _data;
  }
}
