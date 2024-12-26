import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:template_flutter_mvvm_repo_bloc/di/di.dart';

import '../../../../imports/common.dart';
import '../../authentication_bloc/authentication_bloc.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final AuthenticationBloc _signInBloc = instance<AuthenticationBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _signInBloc,
      child: BlocConsumer<AuthenticationBloc, AuthenticationWithInitialState>(
        listener: (context, state) {
          if ( state.message.isNotEmpty) {
            Toast.nullableIconToast(
              message: state.message,
              isErrorBooleanOrNull: state.isFailure? true :false,
            );
            if(!state.isFailure){
              Navigator.pushNamedAndRemoveUntil(context, RouteName.routeParentNavigation, (route) => false);
            }
          }
        },
        builder: (context, state) {
          if(state.isLoading) {
            return CustomLoader(child: buildSignInLayout(state, context));
          }else{
            return buildSignInLayout(state, context);
          }
        },
      ),
    );
  }

  Scaffold buildSignInLayout(AuthenticationWithInitialState state, BuildContext context) {
    return Scaffold(
          backgroundColor: AppColor.colorScaffold,
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: screenHPadding, vertical: screenHPadding),
              child: Form(
                key: _signInBloc.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                      height: 50.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: Text(
                          AppStrings.authentication_signInAndsignUp_title,
                          style: Style.extraLargeTitleStyle()),
                    ),
                    SvgPicture.asset(
                      Assets.icBlueDivider,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: widgetBottomPadding),
                      child: Text(AppStrings.authentication_signin_subTitle,
                          style: Style.subTitleStyle(
                              color: AppColor.colorAccent)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: widgetBottomPadding),
                      child: CustomTextField(
                        label: AppStrings.textfield_addEmail_text,
                        isError: state.isEmailInvalid,
                        focusNode: state.emailFocusNode,
                        controller: state.emailController!,
                        hintText: AppStrings.textfield_addEmail_hint,
                        variant: TextFieldVariant.email,
                        validator: (value) {
                          _signInBloc.add(TriggerFieldValidationEvent(
                              input: value!,
                              textFieldVariant: TextFieldVariant.email,
                              isPassword: null));
                          return validateEmail(value);
                        },
                      ),
                    ),
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
                        onTapPassword: () {
                          FocusScope.of(context).unfocus();
                          _signInBloc.add(
                               TriggerPasswordVisibilityCheck(
                                 currentPassword: null,
                                  isCurrentPasswordVisible: null,
                                  isConfirmedPasswordVisible: null,
                                  isPasswordVisible: state.isPasswordVisible,
                                  isPassword: true));
                        },
                        validator: (value) {
                          _signInBloc.add(TriggerFieldValidationEvent(
                              isPassword: true,
                              textFieldVariant: TextFieldVariant.password,
                              input: value!));

                          return validatePasswordSecurityPolicies(
                              value!, null);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: widgetBottomPadding),
                      child: GestureDetector(
                        onTap: () {
                           Navigator.pushNamed(context, RouteName.routeForgotPassword);
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            AppStrings
                                .authentication_signin_forgotPassword_text,
                            style: Style.textButtonStyle(),
                          ),
                        ),
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
                          if (_signInBloc.formKey.currentState!.validate()) {
                            _signInBloc.add(TriggerEmailSignInRequest(
                                email: state.emailController!.text,
                                password: state.passwordController!.text));
                          }
                        },
                        text: AppStrings.authentication_signin_signinBtn,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: widgetBottomPadding),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                                thickness: 2, color: AppColor.colorDivider),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                AppStrings
                                    .authentication_signin_socialSignInOption_text,
                                style: Style.subTitleStyle(),
                              )),
                          Expanded(
                            child: Divider(
                                thickness: 2, color: AppColor.colorDivider),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: widgetBottomPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              _signInBloc.add(TriggerGoogleSignInRequest());
                            },
                            child: SvgPicture.asset(
                              Assets.icGoogle,
                              width: socialIconWidth,
                              height: socialIconHeight,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: widgetBottomPadding),
                            child: InkWell(
                              onTap: () {
                                _signInBloc
                                    .add(TriggerFacebookSignInRequest());
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
                              padding:
                                  EdgeInsets.only(top: widgetBottomPadding),
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
                              AppStrings.authentication_signin_noAccount_text,
                              style: Style.subTitleStyle(
                                  color: AppColor.colorSecondaryText),
                            ),
                            TextButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                Navigator.pushNamed(
                                  context,
                                  RouteName.routeSignUp,
                                ).then((value) =>
                                    _signInBloc.add(TriggerRefreshView()));
                              },
                              child: Text(
                                  AppStrings.authentication_signup_signupBtn,
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
