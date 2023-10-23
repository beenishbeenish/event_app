class TaskCompletedResponseModel {
  TaskCompletedResponseModel({
    required this.task,
    required this.status,
    required this.message,
  });
  late final Task task;
  late final bool status;
  late final String message;

  TaskCompletedResponseModel.fromJson(Map<String, dynamic> json){
    task = Task.fromJson(json['task']);
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['task'] = task.toJson();
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}

class Task {
  Task({
    required this.taskid,
    required this.status,
    required this.id,
  });
  late final String taskid;
  late final bool status;
  late final String id;

  Task.fromJson(Map<String, dynamic> json){
    taskid = json['taskid'];
    status = json['status'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['taskid'] = taskid;
    _data['status'] = status;
    _data['_id'] = id;
    return _data;
  }
}