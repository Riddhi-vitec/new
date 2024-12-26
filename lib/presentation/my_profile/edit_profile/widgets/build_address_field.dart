import 'package:flutter/cupertino.dart';

import '../../../../imports/common.dart';
import '../bloc/edit_profile_bloc.dart';

Padding buildAddressField({required EditProfileWithInitialState state, dynamic Function()? onTap, String? Function(String?)? validator}) {
  return Padding(
    padding: EdgeInsets.only(bottom: widgetBottomPadding),
    child: CustomTextField(
      label: AppStrings.textfield_addAddress_text,
      isError: state.isAddressInvalid,
      focusNode: state.addressFocusNode,
      controller: state.addressController,
      variant: TextFieldVariant.address,
      hintText: AppStrings.textfield_addAddress_hint,
      onTap:onTap,
      validator: validator,
    ),
  );
}