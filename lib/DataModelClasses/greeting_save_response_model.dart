class GreetingSaveResponseModel {
  GreetingSaveResponseModel({
    required this.status,
    required this.message,
  });
  late final bool? status;
  late final String message;

  GreetingSaveResponseModel.fromJson(Map<String, dynamic> json){
    status = json['status']??true;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}