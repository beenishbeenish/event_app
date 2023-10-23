class AllChecksResponseModel {
  AllChecksResponseModel({
    required this.message,
    required this.status,
    required this.mediaType,
    required this.downloadAllowed,
  });
  late final String message;
  late final bool status;
  late final String mediaType;
  late final String downloadAllowed;

  AllChecksResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    mediaType = json['mediaType'] ?? '';
    downloadAllowed = json['downloadAllowed'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['status'] = status;
    _data['mediaType'] = mediaType;
    _data['downloadAllowed'] = downloadAllowed;
    return _data;
  }
}
