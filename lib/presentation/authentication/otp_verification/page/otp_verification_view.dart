import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/svg.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/authentication/otp_verification/bloc/otp_verification_bloc.dart';

import '../../../../di/di.dart';
import '../../../../imports/common.dart';
import '../../../../imports/data.dart';
import '../../../my_profile/delete_or_deactivate/bloc/delete_or_deactivate_bloc.dart';

import '../widget/otp_information.dart';
import '../widget/otp_resend_text_button.dart';
import '../widget/otp_timer.dart';
import '../widget/wrap_of_otp_fields.dart';

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({
    Key? key,
    required this.otpRequestModel,
  }) : super(key: key);
  final OtpRequestModel otpRequestModel;

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView>
    with TickerProviderStateMixin {
  OtpVerificationBloc _otpBloc = instance<OtpVerificationBloc>();
  DeleteOrDeactivateBloc _deleteOrDeactivateBloc =
      instance<DeleteOrDeactivateBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _otpBloc
            ..add(TriggerAnimationInitialization(
                vsync: this, otpRequestModel: widget.otpRequestModel)),
        ),
        BlocProvider(
          create: (context) => _deleteOrDeactivateBloc,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<OtpVerificationBloc, VerifyOtpWithInitialState>(
            listener: (context, state) {
              if (state.otpSubmissionMessage.isNotEmpty) {
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteName.routeSignIn, (route) => false);
                Toast.nullableIconToast(
                    message: state.otpSubmissionMessage,
                    isErrorBooleanOrNull:
                        state.isOTPSubmissionSuccessful ? false : true);
                if (state.isResendOtpSuccessful) {
                  _otpBloc.add(TriggerAnimationInitialization(
                      vsync: this, otpRequestModel: widget.otpRequestModel));
                }
              }
            },
          ),
          BlocListener<DeleteOrDeactivateBloc,
              DeleteOrDeactivateWithInitialState>(
            listener: (context, state) {
              if (state.message.isNotEmpty) {
                Toast.nullableIconToast(
                    message: state.message,
                    isErrorBooleanOrNull: state.isFailure ? true : false);
                _otpBloc.add(TriggerAnimationInitialization(
                    vsync: this, otpRequestModel: widget.otpRequestModel));
              }
            },
          ),
        ],
        child: BlocBuilder<DeleteOrDeactivateBloc,
            DeleteOrDeactivateWithInitialState>(
          builder: (context, state) {
            return BlocBuilder<OtpVerificationBloc, VerifyOtpWithInitialState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return CustomLoader(child: buildOtpLayout(state, this));
                }
                return buildOtpLayout(state, this);
                //buildOtpLayout(state, this);
              },
            );
          },
        ),
      ),
    );
  }

  Scaffold buildOtpLayout(state, vsync) {
    return Scaffold(
      appBar: const CustomAppBar(
        isLeading: false,
        title: AppStrings.authentication_otp_screen_title,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonGapBetweenWidgets(
                  isTop: true,
                  child: Text(
                    widget.otpRequestModel.isAccountDeletion
                        ? AppStrings
                            .myAccount_editProfile_deletionConfirmation_title
                        : AppStrings.authentication_otp_subTitle,
                    style: Style.extraLargeTitleStyle(),
                  ),
                ),
                SvgPicture.asset(Assets.icOtp),
                CommonGapBetweenWidgets(
                  child: OtpInformation(
                    message: widget.otpRequestModel.isAccountDeletion
                        ? AppStrings
                            .myAccount_editProfile_deletionConfirmation_otp_information_text(
                                email: widget.otpRequestModel.email,
                                fieldLength: state.fields.length)
                        : AppStrings.authentication_otp_information_text(
                            email: state.email,
                            fieldLength: state.fields.length),
                  ),
                ),

                // Implement 4 input fields
                CommonGapBetweenWidgets(
                  child: WrapOfOtpFields(
                    isEmptyFieldError: state.isEmptyFieldError,
                    fieldFunction: (String val, int index) {
                      _otpBloc.add(TriggerDigitReplace(
                          fieldErrors: state.fieldErrors,
                          fields: state.fields,
                          index: index,
                          val: val));
                    },
                    fieldErrors: state.fieldErrors,
                    fields: state.fields,
                    message: state.emptyFieldError,
                  ),
                ),

                if (state.animationController != null)
                  OtpTimer(
                    animationProgressValue: state.animationValue,
                    animationController: state.animationController,
                  ),
                CommonGapBetweenWidgets(
                  child: OtpResendTextButton(
                    hasAnimationStarted: state.hasAnimationStarted,
                    onTap: () {
                      if (_otpBloc.isClosed) {
                        _otpBloc = instance<OtpVerificationBloc>();
                      }
                      if (_deleteOrDeactivateBloc.isClosed) {
                        _deleteOrDeactivateBloc =
                            instance<DeleteOrDeactivateBloc>();
                      }
                      if (widget.otpRequestModel.isAccountDeletion) {
                        _deleteOrDeactivateBloc.add(TriggerDeleteAccount());
                      } else {
                        _otpBloc.add(TriggerResendOtp(
                            vsync: this,
                            otpRequestModel: widget.otpRequestModel));
                      }
                    },
                  ),
                ),

                CommonGapBetweenWidgets(
                  child: CustomButton(
                      buttonSize: ButtonSize.large,
                      text: widget.otpRequestModel.isAccountDeletion
                          ? AppStrings
                              .myAccount_editProfile_deletionConfirmation_otp_submitBtn
                          : AppStrings.authentication_otp_submitBtn,
                      onTap: () {
                        _otpBloc.add(TriggerSubmitOtp(
                            fields: state.fields,
                            isFromDeletion:
                                widget.otpRequestModel.isAccountDeletion,
                            email: state.email,
                            fullName: state.fullname,
                            password: state.password));
                      },
                      variant: ButtonVariant.btnPrimary),
                ),
                Text(AppStrings.authentication_otp_noEmailReceived_text,
                    textAlign: TextAlign.center, style: Style.labelStyle()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
