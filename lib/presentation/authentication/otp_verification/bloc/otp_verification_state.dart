part of 'otp_verification_bloc.dart';

@freezed
class VerifyOtpWithInitialState with _$VerifyOtpWithInitialState {
  const factory VerifyOtpWithInitialState({
    required AnimationController? animationController,
    required num animationValue,
    required String email,
    required String password,
    required String fullname,
    required List<TextEditingController> fields,
    required List<FocusNode> nodes,
    required List<String?> fieldErrors,
    required bool isOTPSubmissionSuccessful,
    required bool hasAnimationStarted,
    required String otpSubmissionMessage,
    required bool isLoading,
    required bool isEmptyFieldError,
    required String emptyFieldError,
    required bool isInitiated,
    required bool isResendOtpSuccessful,
  }) = _VerifyOtpWithInitialState;

  factory VerifyOtpWithInitialState.initial() => VerifyOtpWithInitialState(
      animationController: null,
      password: '',
      email: '',
      fullname: '',
      emptyFieldError: '',
      animationValue: 60,
      isResendOtpSuccessful: false,
      fields: List.generate(4, (index) => TextEditingController(text: '')),
      nodes: List.generate(4, (index) => FocusNode()),
      fieldErrors: List.generate(
        4,
        (index) => null,
      ),
      isOTPSubmissionSuccessful: true,
      hasAnimationStarted: true,
      otpSubmissionMessage: '',
      isInitiated: false,
      isEmptyFieldError: false,
      isLoading: true);
}
