import 'package:flutter/services.dart';

List<TextInputFormatter> setIntegerFormat() {
  return [
    FilteringTextInputFormatter.digitsOnly
  ];
}

List<TextInputFormatter> setRealNumFormat() {
  return [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
  ];
}

List<TextInputFormatter> setMobileNumberFormat() {
  return [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(12)
  ];
}

List<TextInputFormatter> setUserNameFormat() {
  return [LengthLimitingTextInputFormatter(24)];
}
List<TextInputFormatter> setItemNameFormat() {
  return [LengthLimitingTextInputFormatter(8)];
}
