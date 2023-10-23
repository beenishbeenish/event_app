 class RandomTaskResponseModel {
   RandomTaskResponseModel({
    required this.task,
    required this.id,
    required this.status,
    required this.taskstatus,
    required this.message,
    });
    late final Task? task;
    late final String? id;
    late final bool status;
    late final bool? taskstatus;
    late final String message;

    RandomTaskResponseModel.fromJson(Map<String, dynamic> json){
    task = json['task']!=null?Task.fromJson(json['task']):null;
    id = json['id'];
    status = json['status'];
    taskstatus = json['taskstatus'];
    message = json['message'];
    }

    Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['task'] = task!.toJson();
    _data['id'] = id;
    _data['status'] = status;
    _data['taskstatus'] = taskstatus;
    _data['message'] = message;
    return _data;
    }
    }

    class Task {
    Task({
    required this.id,
    required this.name,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
    });
    late final String id;
    late final String name;
    late final int status;
    late final String createdBy;
    late final String createdAt;
    late final String updatedAt;
    late final int V;

    Task.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    name = json['name'];
    status = json['status'];
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
    _data['createdBy'] = createdBy;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
    }
    }