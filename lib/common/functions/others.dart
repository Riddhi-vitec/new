import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_strings.dart';

import '../../di/di.dart';
import '../../imports/common.dart';
import '../../imports/data.dart';
import '../../imports/services.dart';


String mergeTwoStringsByBlank({required String predecessor, required String successor}){
  String fullName = '$predecessor $successor';
  if(fullName.isNotEmpty){
    return fullName.trim();
  }else{
    return AppStrings.userType_undefinedUser_title;
  }
}




List<Locale> generateSupportedLocales() {
  return LanguageCode.values.map((language) {
    return Locale(language.toString().split('.').last);
  }).toList();
}


extension LanguageName on LanguageCode {
  String get languageName {
    switch (this) {
      case LanguageCode.en:
        return AppStrings.myAccount_appSettings_selectLanguage_englishOption;
      case LanguageCode.de:
        return AppStrings.myAccount_appSettings_selectLanguage_deutschOption;
    }
  }
}

convertToUpperCase({required String word}){
  return word[0].toUpperCase() + word.toLowerCase().substring(1);
}

Future<SignedInUserData> extractUserDataFromCache() async {
  UserData userData = instance<UserData>();
  String userDataInString = await userData.getUserInfo() ?? '';
  Map<String, dynamic> userDataInMap = jsonDecode(userDataInString);
  SignedInUserData signedInUserData = SignedInUserData.fromJson(userDataInMap);
  return signedInUserData;
}