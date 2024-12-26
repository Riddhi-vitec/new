import 'package:flutter/material.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_strings.dart';
import 'password_validation_statement.dart';

class CustomPasswordChecker extends StatelessWidget {
  const CustomPasswordChecker({super.key, required this.hasLowerChar,
    required this.hasUpperChar, required this.hasDigit,
    required this.hasSpecialChar, required this.hasMinChar,
  });

  final bool hasLowerChar, hasUpperChar, hasDigit, hasSpecialChar, hasMinChar;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,

      child: Wrap(
          spacing: 5.0,
          runSpacing: 3.0,
          children: [
          PasswordValidationStatement(text: AppStrings.passwordValidation_validatesMinChar_label, isChecked: hasMinChar),
          PasswordValidationStatement(text: AppStrings.passwordValidation_validatesOneLowercaseChar_label, isChecked: hasLowerChar),
          PasswordValidationStatement(text: AppStrings.passwordValidation_validatesOneUppercaseChar_label, isChecked: hasUpperChar),
          PasswordValidationStatement(text: AppStrings.passwordValidation_validatesOneDigit_label, isChecked: hasDigit),
          PasswordValidationStatement(text: AppStrings.passwordValidation_validatesOneSpecialChar_label, isChecked: hasSpecialChar),
      ],
    ));
  }
}