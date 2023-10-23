
    class JoinEventResponseModel {
      JoinEventResponseModel({
    required this.jointEvent,
    required this.token,
    required this.status,
    required this.message,
    });
    late final JointEvent jointEvent;
    late final String token;
    late final bool status;
    late final String message;

  JoinEventResponseModel.fromJson(Map<String, dynamic> json){
    jointEvent = JointEvent.fromJson(json['jointEvent']);
    token = json['token'];
    status = json['status'];
    message = json['message'];
    }

    Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['jointEvent'] = jointEvent.toJson();
    _data['token'] = token;
    _data['status'] = status;
    _data['message'] = message;
    return _data;
    }
    }

    class JointEvent {
    JointEvent({
    required this.uid,
    required this.EventId,
    required this.tasksId,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
    });
    late final String uid;
    late final String EventId;
    late final List<dynamic> tasksId;
    late final String id;
    late final String createdAt;
    late final String updatedAt;
    late final int V;

    JointEvent.fromJson(Map<String, dynamic> json){
    uid = json['uid'];
    EventId = json['EventId'];
    tasksId = List.castFrom<dynamic, dynamic>(json['tasksId']);
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
    }

    Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['EventId'] = EventId;
    _data['tasksId'] = tasksId;
    _data['_id'] = id;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
    }
    }
