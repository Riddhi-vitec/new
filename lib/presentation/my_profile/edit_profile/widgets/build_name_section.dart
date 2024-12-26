import 'package:flutter/cupertino.dart';

import '../../../../imports/common.dart';
import '../bloc/edit_profile_bloc.dart';

Padding buildNameFields({required EditProfileWithInitialState state,dynamic Function()? onTapLeft, String? Function(String?)? leftTextFieldValidator, dynamic Function()? onTapRight, String? Function(String?)? rightTextFieldValidator }) {
  return Padding(
    padding: EdgeInsets.only(bottom: widgetBottomPadding),
    child: RowWithTwoTextFields(
      leftLabel: AppStrings.textfield_addFirstName_text,
      isLeftFieldHasError: state.isFirstNameInvalid,
      leftFieldFocusNode: state.firsNameFocusNode,
      leftTextFieldEditController: state.firstNameController,
      leftTextFieldHintText: AppStrings.textfield_addFirstName_text,
      leftTextFieldVariant: TextFieldVariant.user,
      onTapLeft: onTapLeft,
      leftTextFieldValidator: leftTextFieldValidator,
      isRightTextFieldHasError: state.isLastNameInvalid,
      rightTextFieldFocusNode: state.lastNameFocusNode,
      rightTextFieldEditController: state.lastNameController,
      rightLabel: AppStrings.textfield_addLastName_text,
      rightTextFieldHintText: AppStrings.textfield_addLastName_hint,
      rightTextFieldVariant: TextFieldVariant.user,
      onTapRight:onTapRight,
      rightTextFieldValidator:rightTextFieldValidator
    ),
  );
}