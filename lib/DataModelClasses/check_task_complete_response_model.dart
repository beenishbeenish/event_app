class CheckTaskCompleteResponseModel {
  CheckTaskCompleteResponseModel({
    required this.status,
    required this.tasksAvailable,
    required this.message,
  });
  late final bool status;
  late final bool tasksAvailable;
  late final String message;

  CheckTaskCompleteResponseModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    tasksAvailable = json['tasks_available'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['tasks_available'] = tasksAvailable;
    _data['message'] = message;
    return _data;
  }
}