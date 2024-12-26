import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../device_variables.dart';
import '../../../../di/di.dart';
import '../../../../imports/common.dart';
import '../../../../imports/data.dart';
import '../../authentication_bloc/authentication_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final AuthenticationBloc _signUpBloc = instance<AuthenticationBloc>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _signUpBloc,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthenticationBloc, AuthenticationWithInitialState>(
            listener: (context, state) {
              if (state.message.isNotEmpty) {
                Toast.nullableIconToast(
                    message: state.message,
                    isErrorBooleanOrNull: state.isFailure ? true : false);
                if (!state.isFailure && !state.isSociallySignedIn) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteName.routeVerifyOtp, (route) => false,
                      arguments:
                      OtpRequestModel(
                        socialId: null,
                        otp: '',
                        email: state.emailController.text,
                        password: state.passwordController.text,
                        deviceToken: '',
                        fullName:  '${state.firstNameController.text} ${state.lastNameController.text}',
                        socialType: null,
                        isChangeEmail: false,
                        isAccountDeletion: false,
                        isSocialAccountVerification: false,
                        deviceType: DeviceVariables.deviceType,
                      )
                    );
                } else if (!state.isFailure && state.isSociallySignedIn) {
                  Navigator.pushNamedAndRemoveUntil(context,
                      RouteName.routeParentNavigation, (route) => false);
                }
              }
            },
          ),
        ],
        child: BlocBuilder<AuthenticationBloc, AuthenticationWithInitialState>(
          builder: (context, state) {
            if (state.isLoading) {
              return CustomLoader(child: buildSignUpLayout(state, context));
            } else {
              return buildSignUpLayout(state, context);
            }
          },
        ),
      ),
    );
  }

  Scaffold buildSignUpLayout(
      AuthenticationWithInitialState state, BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorScaffold,
      body: Center(
        child: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: screenHPadding, vertical: 40.h),
          child: Form(
            key: _signUpBloc.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Text(AppStrings.appName,
                        textAlign: TextAlign.center,
                        style: Style.extraLargeTitleStyle()),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: widgetBottomPadding),
                    child: SvgPicture.asset(Assets.icLogo,
                        width: 50.w, height: 50.h, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Text(AppStrings.authentication_signInAndsignUp_title,
                      style: Style.extraLargeTitleStyle()),
                ),
                SvgPicture.asset(
                  Assets.icBlueDivider,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: widgetBottomPadding),
                  child: Text(AppStrings.authentication_signup_subTitle,
                      style: Style.subTitleStyle(color: AppColor.colorAccent)),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: widgetBottomPadding),
                  child: RowWithTwoTextFields(
                    isLeftFieldHasError: state.isFirstNameInvalid,
                    leftFieldFocusNode: state.firstNameFocusNode,
                    leftLabel: AppStrings.textfield_addFirstName_text,
                    leftTextFieldEditController: state.firstNameController,
                    leftTextFieldHintText:
                        AppStrings.textfield_addFirstName_hint,
                    leftTextFieldVariant: TextFieldVariant.user,
                    leftTextFieldValidator: (value) {
                      _signUpBloc.add(TriggerFieldValidationEvent(
                          isPassword: false,
                          textFieldVariant: TextFieldVariant.firstName,
                          input: state.firstNameController.text));
                      return validateFirstName(value!);
                    },
                    isRightTextFieldHasError: state.isLastNameInvalid,
                    rightTextFieldFocusNode: state.lastNameFocusNode,
                    rightLabel: AppStrings.textfield_addLastName_text,
                    rightTextFieldEditController: state.lastNameController,
                    rightTextFieldHintText:
                        AppStrings.textfield_addLastName_hint,
                    rightTextFieldVariant: TextFieldVariant.user,
                    rightTextFieldValidator: (value) {
                      _signUpBloc.add(TriggerFieldValidationEvent(
                          isPassword: false,
                          textFieldVariant: TextFieldVariant.lastName,
                          input: state.lastNameController.text));
                      return validateLastName(value!);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: widgetBottomPadding),
                  child: CustomTextField(
                    label: AppStrings.textfield_addEmail_text,
                    isError: state.isEmailInvalid,
                    focusNode: state.emailFocusNode,
                    controller: state.emailController,
                    hintText: AppStrings.textfield_addEmail_hint,
                    variant: TextFieldVariant.email,
                    validator: (value) {
                      _signUpBloc.add(TriggerFieldValidationEvent(
                          input: value!,
                          textFieldVariant: TextFieldVariant.email,
                          isPassword: null));
                      return validateEmail(value);
                    },
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: widgetBottomPadding),
                      child: CustomTextField(
                        label: AppStrings.textfield_addPassword_text,
                        filledColor: AppColor.colorPrimaryInverse,
                        isError: state.isPasswordInvalid,
                        focusNode: state.passwordFocusNode,
                        controller: state.passwordController,
                        hintText: AppStrings.textfield_addPassword_hint,
                        variant: TextFieldVariant.password,
                        isObscureText: !state.isPasswordVisible,
                        onChanged: (value) {
                          _signUpBloc.add(TriggerFieldValidationEvent(
                              isPassword: true,
                              textFieldVariant: TextFieldVariant.password,
                              input: value!));
                        },
                        onTapPassword: () {
                          FocusScope.of(context).unfocus();
                          _signUpBloc.add(TriggerPasswordVisibilityCheck(
                              currentPassword: null,
                              isCurrentPasswordVisible: null,
                              isConfirmedPasswordVisible: null,
                              isPasswordVisible: state.isPasswordVisible,
                              isPassword: true));
                        },
                        validator: (value) {
                          _signUpBloc.add(TriggerFieldValidationEvent(
                              isPassword: true,
                              textFieldVariant: TextFieldVariant.password,
                              input: value!));

                          return validatePasswordSecurityPolicies(value, null);
                        },
                      ),
                    ),
                    if (state.isPasswordFieldTapped) ...[
                      Padding(
                        padding: EdgeInsets.only(bottom: widgetBottomPadding),
                        child: CustomPasswordChecker(
                          hasLowerChar: state.hasLowerChar,
                          hasUpperChar: state.hasUpperChar,
                          hasDigit: state.hasDigit,
                          hasSpecialChar: state.hasSpecialChar,
                          hasMinChar: state.hasSpecialChar,
                        ),
                      ),
                    ]
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
                      _signUpBloc.add(TriggerPasswordVisibilityCheck(
                          currentPassword: null,
                          isCurrentPasswordVisible: null,
                          isPasswordVisible: null,
                          isConfirmedPasswordVisible:
                              state.isConfirmPasswordVisible,
                          isPassword: false));
                    },
                    validator: (value) {
                      _signUpBloc.add(TriggerFieldValidationEvent(
                          isPassword: false,
                          textFieldVariant: TextFieldVariant.password,
                          input: value!));

                      return validateConfirmPassword(
                          value, state.passwordController.text);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: CustomCheckbox(
                    isLink: true,
                    isChecked: state.isChecked,
                    isCenter: true,
                    onChanged: (b) {
                      _signUpBloc.add(TriggerCheckboxForSignUp());
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: widgetBottomPadding),
                  child: CustomButton(
                    buttonSize: ButtonSize.large,
                    variant: ButtonVariant.btnPrimary,
                    onTap: () {
                      FocusScope.of(context)
                          .unfocus(); // Before validating form add this line is compulsory
                      if (_signUpBloc.formKey.currentState!.validate()) {
                        if (state.isChecked) {
                          _signUpBloc.add(TriggerEmailSignUpRequest(
                            email: state.emailController.text,
                          ));
                        } else {
                          Toast.nullableIconToast(
                              message: AppStrings
                                  .authentication_signup_checkBox_notTicked_error,
                              isErrorBooleanOrNull: true);
                        }
                      }
                    },
                    text: AppStrings.authentication_signup_signupBtn,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: widgetBottomPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child:
                            Divider(thickness: 2, color: AppColor.colorDivider),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            AppStrings
                                .authentication_signin_socialSignInOption_text,
                            style: Style.subTitleStyle(),
                          )),
                      Expanded(
                        child:
                            Divider(thickness: 2, color: AppColor.colorDivider),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _signUpBloc.add(TriggerGoogleSignInRequest());
                        },
                        child: SvgPicture.asset(
                          Assets.icGoogle,
                          width: socialIconWidth,
                          height: socialIconHeight,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: widgetBottomPadding),
                        child: InkWell(
                          onTap: () {
                            _signUpBloc.add(TriggerFacebookSignInRequest());
                          },
                          child: SvgPicture.asset(
                            Assets.icFacebook,
                            width: socialIconWidth,
                            height: socialIconHeight,
                          ),
                        ),
                      ),
                      if (Platform.isIOS)
                        Padding(
                          padding: EdgeInsets.only(top: widgetBottomPadding),
                          child: InkWell(
                            onTap: () {},
                            child: SvgPicture.asset(
                              Assets.icApple,
                              width: socialIconWidth,
                              height: socialIconHeight,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: widgetBottomPadding),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          AppStrings
                              .authentication_signup_alreadyWithAccount_text,
                          style: Style.subTitleStyle(
                              color: AppColor.colorSecondaryText),
                        ),
                        TextButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context);
                          },
                          child: Text(
                              AppStrings
                                  .authentication_signup_signInOption_text,
                              style: Style.subTitleStyle()),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
