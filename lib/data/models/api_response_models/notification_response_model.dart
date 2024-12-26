class NotificationResponseModel {
  NotificationResponseModel({
    this.status,
    this.message,
    this.data,});

  NotificationResponseModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(NotificationData.fromJson(v));
      });
    }
  }
  bool? status;
  String? message;
  List<NotificationData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class NotificationData {
  NotificationData({
    this.id,
    this.notificationType,
    this.title,
    this.description,
    this.referenceType,
    this.referenceId,
    this.senderId,
    this.receiverId,
    this.createdAt,
    this.updatedAt,
    this.isRead,});

  NotificationData.fromJson(dynamic json) {
    id = json['_id'];
    notificationType = json['notificationType'];
    title = json['title'];
    description = json['description'];
    referenceType = json['referenceType'];
    referenceId = json['referenceId'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isRead = json['isRead'];
  }
  String? id;
  dynamic notificationType;
  String? title;
  String? description;
  String? referenceType;
  String? referenceId;
  String? senderId;
  dynamic receiverId;
  String? createdAt;
  String? updatedAt;
  bool? isRead;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['notificationType'] = notificationType;
    map['title'] = title;
    map['description'] = description;
    map['referenceType'] = referenceType;
    map['referenceId'] = referenceId;
    map['senderId'] = senderId;
    map['receiverId'] = receiverId;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['isRead'] = isRead;
    return map;
  }

}