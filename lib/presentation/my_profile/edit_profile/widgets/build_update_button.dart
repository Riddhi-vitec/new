import 'package:flutter/cupertino.dart';

import '../../../../imports/common.dart';
import '../bloc/edit_profile_bloc.dart';

Padding buildUpdateButton({required EditProfileWithInitialState state, required void Function()? onTap}) {
  return Padding(
    padding: EdgeInsets.only(bottom: widgetBottomPadding),
    child: CustomButton(
        text:
        AppStrings.myAccount_profileSettings_editView_updateBtn,
        variant: ButtonVariant.btnPrimary,
        buttonSize: ButtonSize.medium,
        onTap:onTap),
  );
}