import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../imports/common.dart';
import '../bloc/edit_profile_bloc.dart';


Padding buildChangeEMailSection(
    {required EditProfileWithInitialState state, required BuildContext context, required EditProfileBloc editProfileBloc}) {
  return Padding(
      padding: EdgeInsets.only(bottom: widgetBottomPadding),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: cardHorizontalPadding,
            vertical: cardVerticalPadding),
        decoration: BoxDecoration(
          color: AppColor.colorTertiary,
          borderRadius: BorderRadius.all(Radius.circular(
              cardRadius)), // Set rounded corner radius
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    state.emailController.text,
                    style: Style.subTitleBoldStyle(
                        color: AppColor.colorAccentText),
                  ),
                ),
                //const Spacer(),
                changeEMailButton(context: context, state: state, editProfileBloc: editProfileBloc)
              ],
            ),
            Text(
              AppStrings
                  .myAccount_profileSettings_editView_changeEmailDescription_text,
              style: Style.paragraphStyle(
                  color: AppColor.colorSecondaryText),
            ),
          ],
        ),
      ));
}

InkWell changeEMailButton(
    {required BuildContext context, required EditProfileWithInitialState state, required EditProfileBloc editProfileBloc}) {
  return InkWell(
    onTap: () {
      CustomModalBottomSheet
          .showCustomModalBottomSheet(
          isDismissible: false,
          isScrollableContents: false,
          willPopScope: true,
          isDraggable: false,
          bottomSheetColor:
          AppColor.colorPrimaryInverse,
          title: AppStrings
              .myAccount_profileSettings_editView_modalBottomSheet_title,
          subTitle: AppStrings
              .myAccount_profileSettings_editView_modalBottomSheet_subtitle,
          body: buildBodyForBottomSheet(editProfileBloc: editProfileBloc),
          leftButtonName: AppStrings
              .confirmationDialog_cancelBtn,
          rightButtonName: AppStrings
              .confirmationDialog_verifyBtn,
          leftButtonFunction: () {
            Navigator.pop(context);
          },
          rightButtonFunction: () {
            if (state.formKeyForBottomSheet
                .currentState!
                .validate()) {
              editProfileBloc.add(
                  TriggerChangeEmailEvent(
                      isForValidation: false,
                      email: state
                          .emailController.text));
            }
          },
          isBodyAnImage: false);
    },
    child: Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColor.colorPrimary,
            // Set border color
            width: 1.0),
        borderRadius: const BorderRadius.all(
            Radius.circular(
                5.0)), // Set rounded corner radius
      ),
      child: Text(
        AppStrings
            .myAccount_profileSettings_editView_changeEmailBtn,
        style: Style.paragraphStyle(
            color: AppColor.colorPrimaryText),
      ),
    ),
  );
}

BlocProvider<EditProfileBloc> buildBodyForBottomSheet({required EditProfileBloc editProfileBloc}) {
  return BlocProvider.value(
    value: editProfileBloc
      ..add(TriggerGetUserEmail()),
    child: BlocListener<EditProfileBloc,
        EditProfileWithInitialState>(
      listener: (context, state) {
        if (state.message.isNotEmpty) {
          Toast.nullableIconToast(
              message: state.message,
              isErrorBooleanOrNull:
              state.isFailure
                  ? true
                  : false);
        }
      },
      child: BlocBuilder<EditProfileBloc,
          EditProfileWithInitialState>(
        builder: (context, state) {
          if (state
              .isBottomSheetLoading) {
            return SizedBox(
              height: 80.h,
              child: CustomLoader(
                child:
                buildChangeEmailBottomSheet(
                  state: state,
                  onTap: () {
                    editProfileBloc.add(
                        const TriggerFocusFields(
                            hasMobileFieldFocus:
                            false));
                  },
                  validator: (value) {
                    editProfileBloc.add(
                        TriggerChangeEmailEvent(
                            isForValidation:
                            true,
                            email:
                            value!));
                    return validateEmail(
                        value);
                  },
                ),
              ),
            );
          } else {
            return buildChangeEmailBottomSheet(
              state: state,
              onTap: () {
                editProfileBloc.add(
                    const TriggerFocusFields(
                        hasMobileFieldFocus:
                        false));
              },
              validator: (value) {
                editProfileBloc.add(
                    TriggerChangeEmailEvent(
                        isForValidation:
                        true,
                        email: value!));
                return validateEmail(
                    value);
              },
            );
          }
        },
      ),
    ),
  );
}

Form buildChangeEmailBottomSheet({required EditProfileWithInitialState state, dynamic Function()? onTap, String? Function(String?)? validator,}) {
  return Form(
    key: state.formKeyForBottomSheet,
    child: Padding(
      padding: EdgeInsets.only(bottom: widgetBottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              label: AppStrings.textfield_addEmail_text,
              isError: state.isEmailInvalid,
              focusNode: state.emailFocusNode,
              controller: state.emailController,
              hintText: AppStrings.textfield_addEmail_hint,
              variant: TextFieldVariant.email,
              onTap:onTap,
              validator: validator
          ),
        ],
      ),
    ),
  );
}