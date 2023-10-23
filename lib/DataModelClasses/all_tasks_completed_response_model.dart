
  class AllCompletedTaskResponseModel {
    AllCompletedTaskResponseModel({
  required this.task,
  required this.completeCount,
  required this.status,
  required this.randomCount,
  required this.message,
  });
  late final List<Task> task;
  late final int? completeCount;
  late final bool status;
  late final int? randomCount;
  late final String message;

    AllCompletedTaskResponseModel.fromJson(Map<String, dynamic> json){
  task = List.from(json['task']).map((e)=>Task.fromJson(e)).toList();
  completeCount = json['completeCount'];
  status = json['status'];
  randomCount = json['randomCount'];
  message = json['message'];
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['task'] = task.map((e)=>e.toJson()).toList();
  _data['completeCount'] = completeCount;
  _data['status'] = status;
  _data['randomCount'] = randomCount;
  _data['message'] = message;
  return _data;
  }
  }

  class Task {
  Task({
  required this.id,
  required this.name,
  required this.status,
  required this.isDeleted,
  required this.createdBy,
  required this.createdAt,
  required this.updatedAt,
  required this.V,
  });
  late final String id;
  late final String name;
  late final int status;
  late final bool isDeleted;
  late final String createdBy;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  Task.fromJson(Map<String, dynamic> json){
  id = json['_id'];
  name = json['name'];
  status = json['status'];
  isDeleted = json['is_deleted'];
  createdBy = json['createdBy'];
  createdAt = json['createdAt'];
  updatedAt = json['updatedAt'];
  V = json['__v'];
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['_id'] = id;
  _data['name'] = name;
  _data['status'] = status;
  _data['is_deleted'] = isDeleted;
  _data['createdBy'] = createdBy;
  _data['createdAt'] = createdAt;
  _data['updatedAt'] = updatedAt;
  _data['__v'] = V;
  return _data;
  }
  }