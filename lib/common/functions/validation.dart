

import '../../imports/common.dart';

bool validatePasswordInputBySecurityPolicies({required String password}){
  if(validatePasswordForLowerChar(password: password) &&
      validatePasswordForUpperChar(password: password) &&
      validatePasswordMinLength(password: password) &&
      validatePasswordForSpecialCharacter(password: password) &&
      validatePasswordForDigits(password: password)
  ) {
    return true;
  }else {
    return false;
  }
}

bool validatePasswordForUpperChar({required String password}) {
  return passwordUpperRegex.hasMatch(password.trim());
}

bool validatePasswordForLowerChar({required String password}) {
  return passwordLowerRegex.hasMatch(password.trim());
}

bool validatePasswordMinLength({required String password}) {
  if (password.length > 4) {
    return true;
  } else {
    return false;
  }
}

bool validatePasswordForSpecialCharacter({required String password}) {
  return passwordSpecialRegex.hasMatch(password.trim());
}

bool validatePasswordForDigits({required String password}) {
  return passwordDigitRegex.hasMatch(password.trim());
}

bool isEmailValid(String email){
  return emailRegex.hasMatch(email);
}

