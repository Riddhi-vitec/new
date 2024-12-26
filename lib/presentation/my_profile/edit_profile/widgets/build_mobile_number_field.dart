import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/phone_number.dart';


import '../../../../imports/common.dart';
import '../bloc/edit_profile_bloc.dart';

Padding buildMobileNumberField({required EditProfileWithInitialState state, void Function()? onTap, required void Function(PhoneNumber?) onChanged}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.h),
    child: CustomPhoneField(
      mobileController: state.mobileNumberController,
      mobileFocusNode: state.mobileNumberFocusNode,
      hasFocus: state.hasFocusMobileNumberField,
      hasError: state.isMobileNumberInvalid,
      label: AppStrings.textfield_addMobileNo_text,
      hint: AppStrings.textfield_addMobileNo_hint,
      errorMessage: state.invalidMobileNumberError,
      onTap:onTap,
      onChanged: onChanged,
    ),
  );
}