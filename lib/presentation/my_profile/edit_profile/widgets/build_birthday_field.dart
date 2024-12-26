
import 'package:flutter/cupertino.dart';

import '../../../../imports/common.dart';
import '../bloc/edit_profile_bloc.dart';

Padding buildBirthdayField(
    {required EditProfileWithInitialState state, required dynamic Function()? onTap, required BuildContext context, String? Function(String?)? validator}) {
  return Padding(
    padding: EdgeInsets.only(bottom: widgetBottomPadding),
    child: CustomTextField(
      isReadOnly: true,
      controller: state.birthDayController,
      focusNode: state.birthdayFocusNode,
      isError: state.isBirthdayInvalid,
      label: AppStrings.textfield_addDOB_text,
      hintText: AppStrings.textfield_addDOB_hint,
      variant: TextFieldVariant.date,
      validator:validator,
      onTap: onTap,
    ),
  );
}