class SignedInUserResponseModel {
  SignedInUserResponseModel({
      this.status, 
      this.message, 
      this.data,});

  SignedInUserResponseModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SignedInUserData.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  SignedInUserData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class SignedInUserData {
  SignedInUserData({
      this.id, 
      this.fullName, 
      this.email, 
      this.mobile, 
      this.profile, 
      this.token, 
      this.refreshToken,});

  SignedInUserData.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    mobile = json['mobile'] != null ? Mobile.fromJson(json['mobile']) : null;
    profile = json['profile'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }
  String? id;
  String? fullName;
  String? email;
  Mobile? mobile;
  String? profile;
  String? token;
  String? refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    if (mobile != null) {
      map['mobile'] = mobile?.toJson();
    }
    map['profile'] = profile;
    map['token'] = token;
    map['refreshToken'] = refreshToken;
    return map;
  }

}

class Mobile {
  Mobile({
      this.code, 
      this.number,});

  Mobile.fromJson(dynamic json) {
    code = json['code'];
    number = json['number'];
  }
  dynamic code;
  dynamic number;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['number'] = number;
    return map;
  }

}