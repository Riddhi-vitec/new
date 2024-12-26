import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/authentication/reset_password/bloc/reset_password_bloc.dart';

import '../../../../di/di.dart';
import '../../../../imports/common.dart';

import '../../widgets/authentication_information_text.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key, required this.tokenExtractedFromEmail});

  final String tokenExtractedFromEmail;

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final ResetPasswordBloc _resetPasswordBloc = instance<ResetPasswordBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _resetPasswordBloc,
      child: BlocListener<ResetPasswordBloc, ResetPasswordWithInitialState>(
        listener: (context, state) {
          if (state.message.isNotEmpty) {
            Toast.nullableIconToast(
                message: state.message,
                isErrorBooleanOrNull: state.isFailure ? true : false);
          }
        },
        child: BlocBuilder<ResetPasswordBloc, ResetPasswordWithInitialState>(
          builder: (context, state) {
            return Scaffold(
              appBar: const CustomAppBar(
                isLeading: false,
                title: AppStrings.authentication_resetPassword_screen_title,
              ),
              body: Form(
                key: _resetPasswordBloc.formKey,
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: screenHPadding, vertical: screenVPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (var i = 0; i < 2; i++)
                            const CommonGapBetweenWidgets(),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Text(
                              AppStrings.authentication_resetPassword_header,
                              style: Style.extraLargeTitleStyle(),
                            ),
                          ),
                          SvgPicture.asset(Assets.icBlueDivider),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: widgetBottomPadding),
                            child: SvgPicture.asset(Assets.icSms),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: widgetBottomPadding),
                            child: const AuthenticationInformationText(
                              message: AppStrings
                                  .authentication_resetPassword_information_text,
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: widgetBottomPadding),
                                child: CustomTextField(
                                  label:
                                      AppStrings.textfield_addNewPassword_text,
                                  filledColor: AppColor.colorPrimaryInverse,
                                  isError: state.isNewPasswordInvalid,
                                  focusNode: state.newPasswordFocus,
                                  controller: state.newPasswordController,
                                  hintText:
                                      AppStrings.textfield_addNewPassword_hint,
                                  variant: TextFieldVariant.password,
                                  isObscureText: state.isNewPasswordVisible,
                                  onChanged: (value) {
                                    _resetPasswordBloc.add(
                                        TriggerPasswordValidationCheck(
                                            password: value,
                                            isNewPasswordCheck: true));
                                  },
                                  onTapPassword: () {
                                    FocusScope.of(context).unfocus();
                                    _resetPasswordBloc.add(
                                        const TriggerPasswordVisibilityCheck(
                                            isNewPasswordCheck: true));
                                  },
                                  validator: (value) {
                                    _resetPasswordBloc.add(
                                        TriggerPasswordValidationCheck(
                                            password: value!,
                                            isNewPasswordCheck: true));

                                    return validatePasswordSecurityPolicies(
                                        value, null);
                                  },
                                ),
                              ),
                              if (state.isPasswordFieldTapped) ...[
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: widgetBottomPadding),
                                  child: CustomPasswordChecker(
                                      hasLowerChar: state.hasLowerChar,
                                      hasUpperChar: state.hasUpperChar,
                                      hasDigit: state.hasDigit,
                                      hasSpecialChar: state.hasSpecialChar,
                                      hasMinChar: state.hasMinChar),
                                ),
                              ],
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: widgetBottomPadding),
                            child: CustomTextField(
                              isReadOnly:
                                  state.isPasswordFieldIncorrectlyFilled,
                              label:
                                  AppStrings.textfield_addConfirmPassword_text,
                              filledColor: AppColor.colorPrimaryInverse,
                              isError: state.isConfirmPasswordInvalid,
                              focusNode: state.confirmPasswordFocus,
                              controller: state.confirmPasswordController,
                              hintText:
                                  AppStrings.textfield_addConfirmPassword_hint,
                              variant: TextFieldVariant.password,
                              isObscureText: !state.isConfirmPasswordVisible,
                              onTapPassword: () {
                                FocusScope.of(context).unfocus();
                                _resetPasswordBloc.add(
                                    const TriggerPasswordVisibilityCheck(
                                        isNewPasswordCheck: false));
                              },
                              validator: (value) {
                                _resetPasswordBloc.add(
                                    TriggerPasswordValidationCheck(
                                        isNewPasswordCheck: false,
                                        password: value!));

                                return validateConfirmPassword(
                                    value, state.newPasswordController.text);
                              },
                            ),
                          ),
                          CustomButton(
                              buttonSize: ButtonSize.large,
                              text: AppStrings.common_confirmBtn,
                              onTap: () {
                                if (_resetPasswordBloc.formKey.currentState!
                                    .validate()) {
                                  _resetPasswordBloc.add(
                                      TriggerResetPasswordSubmission(
                                          newPassword: state
                                              .confirmPasswordController.text,
                                          tokenExtractedFromEmail:
                                              widget.tokenExtractedFromEmail));
                                }
                              },
                              variant: ButtonVariant.btnPrimary),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
