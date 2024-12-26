import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../app_configuration/app_environments.dart';
import '../../../di/di.dart';
import '../../../imports/common.dart';
import '../../../imports/data.dart';
import '../../../imports/services.dart';
import '../../../imports/usecase.dart';
import 'authentication_bloc.dart';

void handleFieldValidationEvent({
  required TriggerFieldValidationEvent event,
  required Emitter<AuthenticationWithInitialState> emit,
  required AuthenticationWithInitialState state,
}) async {
  emit(state.copyWith(
    message: '',
    isFailure: false,
    isRefresh: true,
  ));

  if (event.textFieldVariant == TextFieldVariant.firstName) {
    _handleNameValidation(
        event: event,
        emit: emit,
        state: state,
        textFieldVariant: TextFieldVariant.firstName);
  }
  if (event.textFieldVariant == TextFieldVariant.lastName) {
    _handleNameValidation(
        event: event,
        emit: emit,
        state: state,
        textFieldVariant: TextFieldVariant.lastName);
  } else if (event.textFieldVariant == TextFieldVariant.email) {
    _handleEmailValidation(event: event, emit: emit, state: state);
  } else if (event.textFieldVariant == TextFieldVariant.password) {
    _handlePasswordValidation(
      event: event,
      emit: emit,
      state: state,
    );
  }
}

void _handleNameValidation({
  required TriggerFieldValidationEvent event,
  required Emitter<AuthenticationWithInitialState> emit,
  required AuthenticationWithInitialState state,
  required TextFieldVariant textFieldVariant,
}) {
  emit(state.copyWith(
    isRefresh: false,
    isPasswordFieldTapped: true,
  ));
  String? validationResult = textFieldVariant == TextFieldVariant.firstName
      ? validateFirstName(event.input.trim())
      : validateLastName(event.input.trim());
  if (textFieldVariant == TextFieldVariant.firstName) {
    emit(state.copyWith(
      isFirstNameInvalid: validationResult == null ? false : true,
    ));
  } else {
    emit(state.copyWith(
      isLastNameInvalid: validationResult == null ? false : true,
    ));
  }
}

void _handleEmailValidation({
  required TriggerFieldValidationEvent event,
  required Emitter<AuthenticationWithInitialState> emit,
  required AuthenticationWithInitialState state,
}) {
  String? validationResult = validateEmail(event.input.trim().toLowerCase());
  emit(state.copyWith(
    isRefresh: false,
    isPasswordFieldTapped: true,
    isEmailInvalid: validationResult != null,
  ));
}

void _handlePasswordValidation({
  required TriggerFieldValidationEvent event,
  required Emitter<AuthenticationWithInitialState> emit,
  required AuthenticationWithInitialState state,
}) {
  if (event.isPassword != null) {
    if (event.isPassword!) {
      _handlePasswordSecurityPolicies(
        event: event,
        emit: emit,
        state: state,
      );
    } else {
      _handleConfirmPasswordSecurityPolicies(
        event: event,
        emit: emit,
        state: state,
      );
    }
  } else if (event.isCurrentPassword != null) {
    _handleCurrentPasswordSecurityPolicies(
        event: event, emit: emit, state: state);
  }
}

void _handlePasswordSecurityPolicies({
  required TriggerFieldValidationEvent event,
  required Emitter<AuthenticationWithInitialState> emit,
  required AuthenticationWithInitialState state,
}) {
  String? validationResultPassword =
      validatePasswordSecurityPolicies(event.input.trim(), null);

  String password = event.input.trim();
  emit(state.copyWith(
    isRefresh: true,
    hasLowerChar: validatePasswordForLowerChar(password: password),
    hasUpperChar: validatePasswordForUpperChar(password: password),
    hasSpecialChar: validatePasswordForSpecialCharacter(password: password),
    hasDigit: validatePasswordForDigits(password: password),
    hasMinChar: validatePasswordMinLength(password: password),
    isPasswordFieldTapped: true,
    isPasswordFieldCorrectlyFilled: validationResultPassword != null,
    isPasswordInvalid: validationResultPassword != null,
  ));
}

void _handleConfirmPasswordSecurityPolicies({
  required TriggerFieldValidationEvent event,
  required Emitter<AuthenticationWithInitialState> emit,
  required AuthenticationWithInitialState state,
}) {
  String? validationResultConfirm = validateConfirmPassword(
      event.input.trim(), state.passwordController.text.trim());

  emit(state.copyWith(
    isRefresh: false,
    isPasswordFieldTapped: true,
    isConfirmPasswordInvalid: validationResultConfirm == null ? false : true,
  ));
}

void _handleCurrentPasswordSecurityPolicies({
  required TriggerFieldValidationEvent event,
  required Emitter<AuthenticationWithInitialState> emit,
  required AuthenticationWithInitialState state,
}) {
  String? validationResult =
      validatePasswordSecurityPolicies(event.input.trim(), true);
  emit(state.copyWith(
    isPasswordFieldTapped: true,
    isCurrentPasswordInvalid: validationResult != null,
  ));
}

void handlePasswordVisibilityCheck({
  required TriggerPasswordVisibilityCheck event,
  required Emitter<AuthenticationWithInitialState> emit,
  required AuthenticationWithInitialState state,
}) {
  emit(state.copyWith(message: '', isFailure: false, isLoading: false));

  if (event.currentPassword != null) {
    _toggleCurrentPasswordVisibility(
        emit: emit,
        state: state,
        isCurrentPasswordVisible: event.isCurrentPasswordVisible!);
  } else if (event.isPassword != null) {
    if (event.isPassword!) {
      _togglePasswordVisibility(
          emit: emit,
          state: state,
          isPasswordVisible: event.isPasswordVisible!);
    } else {
      _toggleConfirmedPasswordVisibility(
          emit: emit,
          state: state,
          isConfirmedPasswordVisible: event.isConfirmedPasswordVisible!);
    }
  }
}

void _toggleCurrentPasswordVisibility({
  required Emitter<AuthenticationWithInitialState> emit,
  required AuthenticationWithInitialState state,
  required bool isCurrentPasswordVisible,
}) {
  isCurrentPasswordVisible = !isCurrentPasswordVisible;
  emit(state.copyWith(isCurrentPasswordVisible: isCurrentPasswordVisible));
}

void _togglePasswordVisibility({
  required Emitter<AuthenticationWithInitialState> emit,
  required AuthenticationWithInitialState state,
  required bool isPasswordVisible,
}) {
  isPasswordVisible = !isPasswordVisible;
  emit(state.copyWith(
    isPasswordVisible: isPasswordVisible,
  ));
}

void _toggleConfirmedPasswordVisibility({
  required Emitter<AuthenticationWithInitialState> emit,
  required AuthenticationWithInitialState state,
  required bool isConfirmedPasswordVisible,
}) {
  isConfirmedPasswordVisible = !isConfirmedPasswordVisible;
  emit(state.copyWith(
    isConfirmPasswordVisible: isConfirmedPasswordVisible,
  ));
}

Future<void> handleEmailSignUpRequest({
  required TriggerEmailSignUpRequest event,
  required Emitter<AuthenticationWithInitialState> emit,
  required AuthenticationWithInitialState state,
  required SignUpUseCase signUpUseCase,
}) async {
  emit(state.copyWith(
    isLoading: true,
    isFailure: false,
    message: '',
  ));

  try {
    final response =
        await signUpUseCase.execute(event.email.trim().toLowerCase());

    response.fold(
      (failure) {
        _handleEmailSignUpFailure(failure: failure, emit: emit, state: state);
      },
      (success) {
        _handleEmailSignUpSuccess(emit: emit, state: state, success: success);
      },
    );
  } catch (e) {
    emit(state.copyWith(
        isFailure: true, message: e.toString(), isLoading: false));
  }
}

void _handleEmailSignUpSuccess(
    {required Emitter<AuthenticationWithInitialState> emit,
    required AuthenticationWithInitialState state,
    required CommonResponseModel success}) {
  emit(state.copyWith(
      message: success.message!, isFailure: false, isLoading: false));
}

void _handleEmailSignUpFailure(
    {required Failure failure,
    required Emitter<AuthenticationWithInitialState> emit,
    required AuthenticationWithInitialState state}) {
  emit(state.copyWith(
      isFailure: true, message: failure.message, isLoading: false));
}

Future<void> handleEmailSignInRequest({
  required TriggerEmailSignInRequest event,
  required Emitter<AuthenticationWithInitialState> emit,
  required AuthenticationWithInitialState state,
  required SignInUseCase signInUseCase,
}) async {
  emit(state.copyWith(message: '', isFailure: false, isLoading: true));
  try {
    final response = await signInUseCase.execute(SignInRequestModel(
        isSocial: false,
        email: event.email.trim().toLowerCase(),
        password: event.password.trim(),
        isEmailVerified: false,
        socialId: '',
        socialType: ''));
    response.fold(
        (failure) => _handleSignViaEmailFailure(
            failure: failure, emit: emit, state: state),
        (success) => _handleSignViaEmailSuccess(
            emit: emit, state: state, success: success));
  } catch (e) {
    emit(state.copyWith(
        message: e.toString(), isFailure: true, isLoading: false));
  }
}

_handleSignViaEmailSuccess(
    {required Emitter<AuthenticationWithInitialState> emit,
    required AuthenticationWithInitialState state,
    required SignedInUserResponseModel success}) {
  emit(state.copyWith(
      message: success.message!,
      isFailure: false,
      signInData: success.data,
      isLoading: false));
}

_handleSignViaEmailFailure(
    {required Failure failure,
    required Emitter<AuthenticationWithInitialState> emit,
    required AuthenticationWithInitialState state}) {
  emit(state.copyWith(
      message: failure.message, isFailure: true, isLoading: false));
}

Future<void> handleGoogleSignInRequest({
  required TriggerGoogleSignInRequest event,
  required Emitter<AuthenticationWithInitialState> emit,
  required AuthenticationWithInitialState state,
  required SignInUseCase signInUseCase,
}) async {
  emit(state.copyWith(
    message: '',
    isFailure: false,
    signInData: null,
  ));

  UserCredential? userCredential =
      await SocialSignInServices.signInWithGoogle();
  if (userCredential != null) {
    await _handleGoogleSignInResponses(
        signInUseCase: signInUseCase,
        userCredential: userCredential,
        emit: emit,
        state: state);
  }
}

_handleGoogleSignInResponses(
    {required UserCredential userCredential,
    required SignInUseCase signInUseCase,
    required Emitter<AuthenticationWithInitialState> emit,
    required AuthenticationWithInitialState state}) async {
  String googleUserEmail = userCredential.user?.email ?? '';
  bool isGoogleUserEmailVerified = userCredential.user?.emailVerified ?? false;
  String googleUserUid = userCredential.user?.uid ?? '';
  try {
    final response = await signInUseCase.execute(SignInRequestModel(
        email: googleUserEmail,
        socialId: googleUserUid,
        socialType: 'google',
        isSocial: true,
        password: '',
        isEmailVerified: isGoogleUserEmailVerified));
    response.fold(
      (failure) => _handleSignInViaGoogleFailure(
          emit: emit, failure: failure, state: state),
      (success) => _handleSignInViaGoogleSuccess(
          emit: emit, state: state, success: success),
    );
  } catch (e) {
    emit(state.copyWith(message: e.toString(), isFailure: true));
  }
}

_handleSignInViaGoogleSuccess(
    {required Emitter<AuthenticationWithInitialState> emit,
    required AuthenticationWithInitialState state,
    required SignedInUserResponseModel success}) {
  emit(state.copyWith(
    message: success.message!,
    isFailure: false,
    isSociallySignedIn: true,
    signInData: success.data,
  ));
}

_handleSignInViaGoogleFailure(
    {required Emitter<AuthenticationWithInitialState> emit,
    required Failure failure,
    required AuthenticationWithInitialState state}) {
  emit(state.copyWith(message: failure.message, isFailure: true));
}

Future<void> handleFacebookSignInRequest({
  required TriggerFacebookSignInRequest event,
  required Emitter<AuthenticationWithInitialState> emit,
  required AuthenticationWithInitialState state,
  required SignInUseCase signInUseCase,
}) async {
  emit(state.copyWith(
    message: '',
    isFailure: false,
    isSociallySignedIn: false,
    signInData: null,
  ));
  final FacebookLogin? facebookLogin =
      await SocialSignInServices.signInWithFacebook();
  if (facebookLogin != null) {
    await _handleFacebookSignInResponses(
        facebookLogin: facebookLogin,
        signInUseCase: signInUseCase,
        emit: emit,
        state: state);
  }
}

Future<void> _handleFacebookSignInResponses(
    {required FacebookLogin facebookLogin,
    required SignInUseCase signInUseCase,
    required Emitter<AuthenticationWithInitialState> emit,
    required AuthenticationWithInitialState state}) async {
  bool isEmailVerified = false;
  String? userEmail;
  FacebookAccessToken? facebookAccessToken = await facebookLogin.accessToken;

  if (_isContainingEmailName(facebookAccessToken: facebookAccessToken!)) {
    userEmail = await facebookLogin.getUserEmail();
    isEmailVerified = checkBoolForVerifiedEmail(userEmail: userEmail);
  }
  FacebookUserProfile? facebookUserProfile =
      await facebookLogin.getUserProfile();
  String facebookUserId = facebookUserProfile?.userId ?? '';

  try {
    final response = await signInUseCase.execute(SignInRequestModel(
        email: userEmail ?? '',
        socialId: facebookUserId,
        socialType: 'facebook',
        isSocial: true,
        password: '',
        isEmailVerified: isEmailVerified));
    response.fold(
        (failure) => _handleFacebookSignInFailure(
            emit: emit, failure: failure, state: state),
        (success) => _handleFacebookSignInSuccess(
            emit: emit, state: state, success: success));
  } catch (e) {
    emit(state.copyWith(message: e.toString(), isFailure: true));
  }
}

_handleFacebookSignInSuccess(
    {required Emitter<AuthenticationWithInitialState> emit,
    required AuthenticationWithInitialState state,
    required SignedInUserResponseModel success}) {
  emit(state.copyWith(
      message: success.message!, isSociallySignedIn: true,isFailure: false, signInData: success.data));
}

_handleFacebookSignInFailure(
    {required Emitter<AuthenticationWithInitialState> emit,
    required Failure failure,
    required AuthenticationWithInitialState state}) {
  emit(state.copyWith(message: failure.message, isFailure: true));
}

bool checkBoolForVerifiedEmail({required String? userEmail}) {
  return userEmail != null ? true : false;
}

bool _isContainingEmailName({
  required FacebookAccessToken facebookAccessToken,
}) {
  return facebookAccessToken.permissions
      .contains(FacebookPermission.email.name);
}

Future<void> handleChangePasswordRequest({
  required TriggerChangePasswordRequest event,
  required Emitter<AuthenticationWithInitialState> emit,
  required AuthenticationWithInitialState state,
  required ChangePasswordUseCase changePasswordUseCase,
}) async {
  emit(state.copyWith(isLoading: true, message: '', isFailure: false));
  try {
    final response = await changePasswordUseCase.execute(
        ChangePasswordRequestModel(
            oldPassword: event.oldPassword.trim(),
            password: event.newPassword.trim()));
    response.fold(
        (failure) => _handleChangePasswordFailure(
            failure: failure, emit: emit, state: state),
        (success) => _handleChangePasswordSuccess(
            success: success, emit: emit, state: state));
  } catch (e) {
    emit(state.copyWith(
        isLoading: false, isFailure: true, message: e.toString()));
  }
}

_handleChangePasswordSuccess(
    {required success,
    required Emitter<AuthenticationWithInitialState> emit,
    required AuthenticationWithInitialState state}) {
  emit(state.copyWith(
      isLoading: false, message: success.message!, isFailure: false));
}

_handleChangePasswordFailure(
    {required Failure failure,
    required Emitter<AuthenticationWithInitialState> emit,
    required AuthenticationWithInitialState state}) {
  emit(state.copyWith(
      isLoading: false, message: failure.message, isFailure: true));
}

Future<void> handleAppleSignInRequest(
    {required TriggerAppleSignInRequest event,
    required Emitter<AuthenticationWithInitialState> emit,
    required SignInUseCase signInUseCase,
    required AuthenticationWithInitialState state}) async {
  emit(state.copyWith(
    message: '',
    isFailure: false,
    isSociallySignedIn: false,
    signInData: null,
  ));
  try {
    final Future<AuthorizationCredentialAppleID> credential =
        await _getAppleIDCredential();
    final appleUserData = await _fetchOrCreateAppleUserData(credential);
    await _signInWithAppleUserData(
        appleUserData: appleUserData,
        emit: emit,
        state: state,
        signInUseCase: signInUseCase);
  } catch (e) {
    emit(state.copyWith(message: e.toString(), isFailure: true));
  }
}

_signInWithAppleUserData(
    {required AppleUserDataModel appleUserData,
    required Emitter<AuthenticationWithInitialState> emit,
    required AuthenticationWithInitialState state,
    required SignInUseCase signInUseCase,
    }) async {
  try {
    final response = await signInUseCase.execute(SignInRequestModel(
        email: appleUserData.email ?? '',
        socialId: appleUserData.userIdentifier ?? '',
        socialType: 'apple',
        isSocial: true,
        password: '',
        isEmailVerified: appleUserData.email == null ? false : true));
    response.fold(
        (failure) => _handleAppleSignInFailure(
            failure: failure, emit: emit, state: state),
        (success) => _handleAppleSignInSuccess(
            emit: emit, state: state, success: success));
  } catch (e) {
    emit(state.copyWith(message: e.toString(), isFailure: true));
  }
}

_handleAppleSignInSuccess(
    {required Emitter<AuthenticationWithInitialState> emit,
    required AuthenticationWithInitialState state,
    required SignedInUserResponseModel success}) {
  emit(state.copyWith(
      isFailure: false, isSociallySignedIn: true,message: success.message!, signInData: success.data));
}

_handleAppleSignInFailure(
    {required Failure failure,
    required Emitter<AuthenticationWithInitialState> emit,
    required AuthenticationWithInitialState state}) {
  emit(state.copyWith(message: failure.message, isFailure: true));
}

_fetchOrCreateAppleUserData(credential) async {
  final UserData userData = instance<UserData>();
  final AppleUserDataModel appleUserData = credential.email == null
      ? await _retrieveAppleUserData(userData)
      : AppleUserDataModel(
          firstName: credential.givenName!,
          lastName: credential.familyName!,
          email: credential.email!,
          userIdentifier: credential.userIdentifier!,
        );

  await userData.setAppleUserData(jsonEncode(appleUserData));

  return appleUserData;
}

Future<AppleUserDataModel> _retrieveAppleUserData(UserData userData) async {
  final appleData = await userData.getAppleUserData();
  if (appleData.isNotEmpty) {
    return AppleUserDataModel.fromJson(jsonDecode(appleData));
  }
  throw Exception('Apple user data not found');
}

_getAppleIDCredential() async {
  return await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
    webAuthenticationOptions: WebAuthenticationOptions(
      clientId: AppEnvironments.iOSBundleID,
      redirectUri: Uri.parse(
        'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
      ),
    ),
  );
}

handleRefreshView({ required Emitter<AuthenticationWithInitialState> emit, required AuthenticationWithInitialState state}) {
  state.firstNameController.dispose();
  state.lastNameController.dispose();
  state.emailController.dispose();
  state.passwordController.dispose();
  state.confirmPasswordController.dispose();
  state.currentPasswordController.dispose();

  state.firstNameFocusNode.dispose();
  state.lastNameFocusNode.dispose();
  state.emailFocusNode.dispose();
  state.passwordFocusNode.dispose();
  state.confirmPasswordFocusNode.dispose();
  state.currentPasswordFocusNode.dispose();

  emit(AuthenticationWithInitialState.initial());
}