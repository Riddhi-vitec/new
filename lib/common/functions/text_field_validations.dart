


import '../../imports/common.dart';


String? validateFirstName(String value) {
  if(value.isEmpty){
    return AppStrings.textfield_addFirstName_emptyField_error;
  } else if(value.length > 20){
    return AppStrings.textfield_addFirstName_tooLarge_error;
  }else if(value.length < 4){
    return AppStrings.textfield_addFirstName_tooSmall_error;
  }else {
    return null;
  }
}

String? validateLastName(String value) {
  if(value.isEmpty){
    return AppStrings.textfield_addLastName_emptyField_error;
  } else if(value.length > 20){
    return AppStrings.textfield_addLastName_tooLarge_error;
  }else if(value.length < 4){
    return AppStrings.textfield_addLastName_tooSmall_error;
  }else {
    return null;
  }
}

String? validateFullName(String value) {
  if(value.isEmpty){
    return AppStrings.textfield_addFirstName_emptyField_error;
  } else if(value.length < 4 ){
    return AppStrings.textfield_addFullName_tooSmall_error;
  }else if( value.length > 40){
    return  AppStrings.textfield_addFullName_tooLarge_error;
  }else {
    return null;
  }
}
String? validateMobileNumber({required String value, required int length}) {
  if(value.isEmpty){
    return AppStrings.textfield_addMobileNo_emptyField_error;
  } else if(value.length < length) {
    return AppStrings.textfield_addMobileNo_invalid_error;
  } else {
    return null;
  }
}

String? validateEmail(String value) {
  if(value.isEmpty){
    return AppStrings.textfield_addEmail_emptyField_error;
  } else if(!isEmailValid(value)) {
    return AppStrings.textfield_addEmail_invalid_error;
  } else {
    return null;
  }
}

String? validatePasswordSecurityPolicies(String value, bool? isCurrentPassword) {
  if(value.isEmpty){
    return isCurrentPassword == null
        ? AppStrings.textfield_addPassword_emptyField_error : isCurrentPassword
        ? AppStrings.textfield_addCurrentPassword_emptyField_error
        : AppStrings.textfield_addNewPassword_emptyField_error;
  }else if (!validatePasswordInputBySecurityPolicies(password: value)) {
    return AppStrings.textfield_addPassword_invalid_error;
  } else {
    return null;
  }
}

String? validateConfirmPassword(String value, String newPassword) {
  if(value.isEmpty){
    return AppStrings.textfield_addConfirmPassword_emptyField_error;
  } else if(value != newPassword){
    return AppStrings.textfield_addConfirmPassword_mismatch_error;
  } else {
    return null;
  }
}

String? validateAddress(String value) {
  if(value.isEmpty){
    return AppStrings.textfield_addAddress_emptyField_error;
  } else {
    return null;
  }
}

String? validateMessage(String value) {
  if(value.isEmpty){
    return AppStrings.textfield_addMessage_emptyField_error;
  } else {
    return null;
  }
}
validateProduct({required String value, required int length}) {
  if(value.isEmpty){
    return AppStrings.textfield_addProductName_emptyField_error;
  } else if(value.length > length) {
    return AppStrings.textfield_addProductName_invalid_error;
  } else {
    return null;
  }
}

String? validateBirthday(String dobString) {
  // Parse the date string
  List<String> parts = dobString.split('/');
  if (parts.length != 3) {
    return AppStrings.textfield_addDob_emptyField_error;
  }

  try {
    int month = int.parse(parts[0]);
    int day = int.parse(parts[1]);
    int year = int.parse(parts[2]);

    // Create a DateTime object from the parsed components
    DateTime dob = DateTime(year, month, day);

    // Calculate age
    DateTime now = DateTime.now();
    int age = now.year - dob.year;

    // Check if the birthday has passed this year
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      age--;
    }

    // Check if age is greater than or equal to 18
    if (age >= 18) {
      return null; // Age is valid
    } else {
      return AppStrings.textfield_addDob_invalid_error;
    }
  } catch (e) {
    return e.toString();
  }
}


