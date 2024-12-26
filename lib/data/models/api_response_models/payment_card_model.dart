class PaymentCardModel {
  PaymentCardModel({
      this.id, 
      this.object, 
      this.card, 
      this.clientIp, 
      this.created, 
      this.livemode, 
      this.type, 
      this.used,});

  PaymentCardModel.fromJson(dynamic json) {
    id = json['id'];
    object = json['object'];
    card = json['card'] != null ? PaymentCardInfo.fromJson(json['card']) : null;
    clientIp = json['client_ip'];
    created = json['created'];
    livemode = json['livemode'];
    type = json['type'];
    used = json['used'];
  }
  String? id;
  String? object;
  PaymentCardInfo? card;
  String? clientIp;
  num? created;
  bool? livemode;
  String? type;
  bool? used;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['object'] = object;
    if (card != null) {
      map['card'] = card?.toJson();
    }
    map['client_ip'] = clientIp;
    map['created'] = created;
    map['livemode'] = livemode;
    map['type'] = type;
    map['used'] = used;
    return map;
  }

}

class PaymentCardInfo {
  PaymentCardInfo({
      this.id, 
      this.object, 
      this.addressCity, 
      this.addressCountry, 
      this.addressLine1, 
      this.addressLine1Check, 
      this.addressLine2, 
      this.addressState, 
      this.addressZip, 
      this.addressZipCheck, 
      this.brand, 
      this.country, 
      this.cvcCheck, 
      this.dynamicLast4, 
      this.expMonth, 
      this.expYear, 
      this.funding, 
      this.last4, 
      this.name, 
      this.tokenizationMethod, 
      this.wallet,});

  PaymentCardInfo.fromJson(dynamic json) {
    id = json['id'];
    object = json['object'];
    addressCity = json['address_city'];
    addressCountry = json['address_country'];
    addressLine1 = json['address_line1'];
    addressLine1Check = json['address_line1_check'];
    addressLine2 = json['address_line2'];
    addressState = json['address_state'];
    addressZip = json['address_zip'];
    addressZipCheck = json['address_zip_check'];
    brand = json['brand'];
    country = json['country'];
    cvcCheck = json['cvc_check'];
    dynamicLast4 = json['dynamic_last4'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    funding = json['funding'];
    last4 = json['last4'];
    name = json['name'];
    tokenizationMethod = json['tokenization_method'];
    wallet = json['wallet'];
  }
  String? id;
  String? object;
  dynamic addressCity;
  dynamic addressCountry;
  dynamic addressLine1;
  dynamic addressLine1Check;
  dynamic addressLine2;
  dynamic addressState;
  dynamic addressZip;
  dynamic addressZipCheck;
  String? brand;
  String? country;
  String? cvcCheck;
  dynamic dynamicLast4;
  num? expMonth;
  num? expYear;
  String? funding;
  String? last4;
  String? name;
  dynamic tokenizationMethod;
  dynamic wallet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['object'] = object;
    map['address_city'] = addressCity;
    map['address_country'] = addressCountry;
    map['address_line1'] = addressLine1;
    map['address_line1_check'] = addressLine1Check;
    map['address_line2'] = addressLine2;
    map['address_state'] = addressState;
    map['address_zip'] = addressZip;
    map['address_zip_check'] = addressZipCheck;
    map['brand'] = brand;
    map['country'] = country;
    map['cvc_check'] = cvcCheck;
    map['dynamic_last4'] = dynamicLast4;
    map['exp_month'] = expMonth;
    map['exp_year'] = expYear;
    map['funding'] = funding;
    map['last4'] = last4;
    map['name'] = name;
    map['tokenization_method'] = tokenizationMethod;
    map['wallet'] = wallet;
    return map;
  }

}