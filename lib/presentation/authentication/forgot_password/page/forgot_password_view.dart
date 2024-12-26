import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';


import '../../../../di/di.dart';
import '../../../../imports/common.dart';
import '../../widgets/authentication_information_text.dart';
import '../../../../common/widgets/common_gap_between_widgets.dart';
import '../../widgets/suggestion.dart';
import '../bloc/forgot_password_bloc.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final ForgotPasswordBloc _forgotPasswordBloc = instance<ForgotPasswordBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _forgotPasswordBloc,
      child: BlocListener<ForgotPasswordBloc, ForgotPasswordWithInitialState>(
        listener: (context, state) {
          if (state.message.isNotEmpty) {
            Toast.nullableIconToast(
              message: state.message,
              isErrorBooleanOrNull: state.isFailure ? true : false,
            );
          }
        },
        child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordWithInitialState>(
          builder: (context, state) {
            if(state.isLoading) {
              return CustomLoader(child: buildForgotPasswordLayout(state, context));
            }else{
              return buildForgotPasswordLayout(state, context);
            }
          },
        ),
      ),
    );
  }

  Scaffold buildForgotPasswordLayout(ForgotPasswordWithInitialState state, BuildContext context) {
    return Scaffold(
            appBar: const CustomAppBar(
              title: AppStrings.authentication_forgotPassword_screen_title,
            ),
            body: Form(
              key: _forgotPasswordBloc.formKey,
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: screenHPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (var i = 0; i < 3; i++)
                          const CommonGapBetweenWidgets(),
                        Text(
                          AppStrings.authentication_forgotPassword_header,
                          style: Style.extraLargeTitleStyle(),
                        ),
                        SvgPicture.asset(Assets.icBlueDivider),
                        SvgPicture.asset(Assets.icOtp),
                        const AuthenticationInformationText(
                          message: AppStrings.authentication_forgotPassword_subheader,
                        ),
                        const CommonGapBetweenWidgets(),
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
                              _forgotPasswordBloc.add(TriggerEmailValidation(email: value!));
                              return validateEmail(value);
                            },
                          ),
                        ),
                        CustomButton(
                            buttonSize: ButtonSize.large,
                            text: AppStrings.common_sendBtn,
                            onTap: () {
                              if(_forgotPasswordBloc.formKey.currentState!.validate()){
                                _forgotPasswordBloc.add(TriggerSubmitEmail(email: state.emailController.text));
                              }
                            },
                            variant: ButtonVariant.btnPrimary),
                        Suggestion(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Navigator.pop(
                              context,
                            );
                          },
                          buttonText: AppStrings.authentication_signin_signinBtn,
                          suggestionText:
                          AppStrings.authentication_forgotPassword_rememberPasswordOption_text,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
