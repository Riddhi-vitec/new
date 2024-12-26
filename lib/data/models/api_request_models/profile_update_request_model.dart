import 'dart:io';

import 'package:http/http.dart';

class ProfileUpdateRequestModel {
  final String firstName;
  final String lastName;
  final String birthday;
  final String countryCode;
  final String mobileNumber;
  final String address;
  final File? profileImage;

  ProfileUpdateRequestModel({
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.countryCode,
    required this.mobileNumber,
    required this.address,
    required this.profileImage,
  });
}
