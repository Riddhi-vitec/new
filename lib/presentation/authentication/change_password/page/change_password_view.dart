import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../di/di.dart';
import '../../../../imports/common.dart';
import '../../authentication_bloc/authentication_bloc.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  final AuthenticationBloc _changePasswordBloc = instance<AuthenticationBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _changePasswordBloc,
      child: BlocListener<AuthenticationBloc, AuthenticationWithInitialState>(
        listener: (context, state) {
          if (state.message.isNotEmpty) {
            Toast.nullableIconToast(
                message: state.message,
                isErrorBooleanOrNull: state.isFailure ? true : false);
          }
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationWithInitialState>(
          builder: (context, state) {
            if (state.isLoading) {
              return CustomLoader(
                  child: buildChangePasswordLayout(state, context));
            } else {
              return buildChangePasswordLayout(state, context);
            }
          },
        ),
      ),
    );
  }

  Scaffold buildChangePasswordLayout(
      AuthenticationWithInitialState state, BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          centerTitle: false,
          title: AppStrings.myAccount_changePassword_screen_title),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: screenHPadding, vertical: screenVPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _changePasswordBloc.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: widgetBottomPadding),
                    child: CustomTextField(
                      label: AppStrings.textfield_addCurrentPassword_text,
                      isError: state.isCurrentPasswordInvalid,
                      controller: state.currentPasswordController,
                      focusNode: state.currentPasswordFocusNode,
                      hintText: AppStrings.textfield_addCurrentPassword_text,
                      validator: (value) {
                        _changePasswordBloc.add(TriggerFieldValidationEvent(
                          input: value!,
                          textFieldVariant: TextFieldVariant.password,
                          isCurrentPassword: true,
                          isPassword: null,
                        ));
                        return validatePasswordSecurityPolicies(value, true);
                      },
                      isObscureText: !state.isCurrentPasswordVisible,
                      variant: TextFieldVariant.password,
                      onTapPassword: () {
                        _changePasswordBloc.add(TriggerPasswordVisibilityCheck(
                            isConfirmedPasswordVisible: null,
                            isPasswordVisible: null,
                            isCurrentPasswordVisible:
                                state.isCurrentPasswordVisible,
                            isPassword: null,
                            currentPassword: true));
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: state.isPasswordFieldTapped
                                ? 0
                                : widgetBottomPadding),
                        child: CustomTextField(
                          label: AppStrings.textfield_addNewPassword_text,
                          isError: state.isPasswordInvalid,
                          controller: state.passwordController,
                          focusNode: state.passwordFocusNode,
                          hintText: AppStrings.textfield_addNewPassword_hint,
                          isObscureText: state.isPasswordVisible,
                          variant: TextFieldVariant.password,
                          validator: (value) {
                            _changePasswordBloc.add(TriggerFieldValidationEvent(
                                isPassword: true,
                                textFieldVariant: TextFieldVariant.password,
                                input: value!));
                            return validatePasswordSecurityPolicies(
                                value, false);
                          },
                          onChanged: (val) {
                            _changePasswordBloc.add(TriggerFieldValidationEvent(
                                isPassword: true,
                                textFieldVariant: TextFieldVariant.password,
                                input: val));
                          },
                          onTapPassword: () {
                            FocusScope.of(context).unfocus();
                            _changePasswordBloc.add(
                                TriggerPasswordVisibilityCheck(
                                    isConfirmedPasswordVisible: null,
                                    isCurrentPasswordVisible: null,
                                    currentPassword: null,
                                    isPasswordVisible: state.isPasswordVisible,
                                    isPassword: true));
                          },
                        ),
                      ),
                      if (state.isPasswordFieldTapped) ...[
                        Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: CustomPasswordChecker(
                            hasDigit: state.hasDigit,
                            hasLowerChar: state.hasLowerChar,
                            hasMinChar: state.hasMinChar,
                            hasSpecialChar: state.hasSpecialChar,
                            hasUpperChar: state.hasUpperChar,
                          ),
                        ),
                      ],
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: widgetBottomPadding),
                    child: CustomTextField(
                      isReadOnly: state.isPasswordFieldCorrectlyFilled,
                      label: AppStrings.textfield_addConfirmPassword_text,
                      filledColor: state.isPasswordFieldCorrectlyFilled
                          ? AppColor.colorDisable
                          : null,
                      isError: state.isConfirmPasswordInvalid,
                      focusNode: state.confirmPasswordFocusNode,
                      controller: state.confirmPasswordController,
                      hintText: AppStrings.textfield_addConfirmPassword_hint,
                      variant: TextFieldVariant.password,
                      isObscureText: !state.isConfirmPasswordVisible,
                      onTapPassword: () {
                        FocusScope.of(context).unfocus();
                        _changePasswordBloc.add(
                             TriggerPasswordVisibilityCheck(
                                isPasswordVisible: null,
                                isCurrentPasswordVisible: null,
                                currentPassword: null,
                                isConfirmedPasswordVisible:
                                    state.isConfirmPasswordVisible,
                                isPassword: false));
                      },
                      validator: (value) {
                        _changePasswordBloc.add(TriggerFieldValidationEvent(
                            isPassword: false,
                            textFieldVariant: TextFieldVariant.password,
                            input: value!));

                        return validateConfirmPassword(
                            value, state.passwordController.text);
                      },
                    ),
                  ),
                  CustomButton(
                    onTap: () {
                      if (_changePasswordBloc.formKey.currentState!
                          .validate()) {
                        _changePasswordBloc.add(TriggerChangePasswordRequest(
                          newPassword: state.confirmPasswordController.text,
                          oldPassword: state.currentPasswordController.text,
                        ));
                      } else {}
                    },
                    text: AppStrings.common_continueBtn,
                    variant: ButtonVariant.btnPrimary,
                    buttonSize: ButtonSize.large,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
