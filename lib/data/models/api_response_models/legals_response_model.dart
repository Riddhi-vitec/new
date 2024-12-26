class LegalsResponseModel {
  LegalsResponseModel({
      this.status, 
      this.message, 
      this.data,});

  LegalsResponseModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(LegalsData.fromJson(v));
      });
    }
  }
  bool? status;
  String? message;
  List<LegalsData>? data;

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

class LegalsData {
  LegalsData({
      this.id, 
      this.type, 
      this.pageName, 
      this.title, 
      this.content, 
      this.createdAt, 
      this.updatedAt,});

  LegalsData.fromJson(dynamic json) {
    id = json['_id'];
    type = json['type'];
    pageName = json['pageName'];
    title = json['title'];
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? type;
  String? pageName;
  String? title;
  String? content;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['type'] = type;
    map['pageName'] = pageName;
    map['title'] = title;
    map['content'] = content;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}