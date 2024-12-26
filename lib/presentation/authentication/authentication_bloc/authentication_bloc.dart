import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/authentication/authentication_bloc/authentication_hanlders.dart';


import '../../../imports/common.dart';
import '../../../imports/data.dart';
import '../../../imports/usecase.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

part 'authentication_bloc.freezed.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationWithInitialState> {
  bool isChecked = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  AuthenticationBloc(
      {required this.signInUseCase,
      required this.signUpUseCase,
      required this.changePasswordUseCase})
      : super(AuthenticationWithInitialState.initial()) {
    on<TriggerFieldValidationEvent>(_onTriggerFieldValidationEvent);
    on<TriggerPasswordVisibilityCheck>(_onTriggerPasswordVisibilityCheck);
    on<TriggerGoogleSignInRequest>(_onTriggerGoogleSignInRequest);
    on<TriggerFacebookSignInRequest>(_onTriggerFacebookSignInRequest);
    on<TriggerAppleSignInRequest>(_onTriggerAppleSignInRequest);
    on<TriggerEmailSignInRequest>(_onTriggerEmailSignInRequest);
    on<TriggerEmailSignUpRequest>(_onTriggerEmailSignUpRequest);
    on<TriggerRefreshView>(_onTriggerRefreshView);
    on<TriggerCheckboxForSignUp>(_onTriggerCheckboxForSignUp);
    on<TriggerChangePasswordRequest>(_onTriggerChangePassword);
  }

  FutureOr<void> _onTriggerFieldValidationEvent(
      TriggerFieldValidationEvent event,
      Emitter<AuthenticationWithInitialState> emit) {
    handleFieldValidationEvent(
      event: event,
      emit: emit,
      state: state,
    );
  }

  FutureOr<void> _onTriggerPasswordVisibilityCheck(
      TriggerPasswordVisibilityCheck event,
      Emitter<AuthenticationWithInitialState> emit) {
    handlePasswordVisibilityCheck(
      event: event,
      emit: emit,
      state: state,
    );
  }

  FutureOr<void> _onTriggerEmailSignUpRequest(TriggerEmailSignUpRequest event,
      Emitter<AuthenticationWithInitialState> emit) async {
    await handleEmailSignUpRequest(
        event: event, emit: emit, state: state, signUpUseCase: signUpUseCase);
  }

  FutureOr<void> _onTriggerEmailSignInRequest(TriggerEmailSignInRequest event,
      Emitter<AuthenticationWithInitialState> emit) async {
    await handleEmailSignInRequest(
        event: event, emit: emit, state: state, signInUseCase: signInUseCase);
  }

  FutureOr<void> _onTriggerAppleSignInRequest(TriggerAppleSignInRequest event,
      Emitter<AuthenticationWithInitialState> emit) async {
    await handleAppleSignInRequest(
        event: event, emit: emit, state: state, signInUseCase: signInUseCase);
    // emit(state.copyWith(
    //   message: '',
    //   isFailure: false,
    //   signInData: null,
    // ));
    //
    // late AppleUserDataModel appleUserData;
    // try {
    //   final Future<AuthorizationCredentialAppleID> credential = await SignInWithApple.getAppleIDCredential(
    //     scopes: [
    //       AppleIDAuthorizationScopes.email,
    //       AppleIDAuthorizationScopes.fullName,
    //     ],
    //     webAuthenticationOptions: WebAuthenticationOptions(
    //       clientId: AppEnvironments.iOSBundleID,
    //       redirectUri: Uri.parse(
    //         'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
    //       ),
    //     ),
    //   ).then((value) async {
    //     if (value.email == null) {
    //       String appleData = await _userData.getAppleUserData();
    //
    //       if (appleData.isNotEmpty) {
    //         appleUserData = AppleUserDataModel.fromJson(jsonDecode(appleData));
    //       } else {}
    //     } else {
    //       appleUserData = AppleUserDataModel(
    //         firstName: value.givenName!,
    //         lastName: value.familyName!,
    //         email: value.email!,
    //         userIdentifier: value.userIdentifier!,
    //       );
    //
    //       //set Value
    //       await _userData.setAppleUserData(jsonEncode(appleUserData));
    //
    //       //get Value
    //       var appleValue = await _userData.getAppleUserData();
    //     }
    //     try {
    //       final response = await signInUseCase.execute(SignInRequestModel(
    //           email: appleUserData.email ?? '',
    //           socialId: appleUserData.userIdentifier ?? '',
    //           socialType: 'apple',
    //           isSocial: true,
    //           password: '',
    //           isEmailVerified: appleUserData.email == null ? false : true));
    //       response.fold(
    //           (failure) => emit(
    //               state.copyWith(message: failure.message, isFailure: true)),
    //           (success) => emit(state.copyWith(
    //               isFailure: false,
    //               message: success.message!,
    //               signInData: success.data)));
    //     } catch (e) {
    //       emit(state.copyWith(message: e.toString(), isFailure: true));
    //     }
    //   });
    // } catch (e) {
    //   emit(state.copyWith(message: e.toString(), isFailure: true));
    // }
  }

  FutureOr<void> _onTriggerGoogleSignInRequest(TriggerGoogleSignInRequest event,
      Emitter<AuthenticationWithInitialState> emit) async {
    await handleGoogleSignInRequest(
        event: event, emit: emit, state: state, signInUseCase: signInUseCase);
  }

  FutureOr<void> _onTriggerFacebookSignInRequest(
      TriggerFacebookSignInRequest event,
      Emitter<AuthenticationWithInitialState> emit) async {
    await handleFacebookSignInRequest(
        event: event, emit: emit, state: state, signInUseCase: signInUseCase);
  }

  FutureOr<void> _onTriggerRefreshView(
      TriggerRefreshView event, Emitter<AuthenticationWithInitialState> emit) {

    formKey = GlobalKey<FormState>();
    handleRefreshView( emit: emit, state: state);
  }

  FutureOr<void> _onTriggerCheckboxForSignUp(TriggerCheckboxForSignUp event,
      Emitter<AuthenticationWithInitialState> emit) {
    isChecked = !isChecked;
    emit(state.copyWith(message: '', isFailure: false, isChecked: isChecked));
  }

  FutureOr<void> _onTriggerChangePassword(TriggerChangePasswordRequest event,
      Emitter<AuthenticationWithInitialState> emit) async {
   await handleChangePasswordRequest(event: event, emit: emit, state: state, changePasswordUseCase: changePasswordUseCase);
  }
}
