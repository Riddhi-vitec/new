import 'package:bloc/bloc.dart';

import '../../../imports/common.dart';
import '../../../imports/data.dart';
import '../../../imports/usecase.dart';
import 'my_account_bloc.dart';

Future<void> handleProfileEvent(
    {required TriggerGetProfile event,
   required  Emitter<MyAccountWithInitialState> emit,
    required MyAccountWithInitialState state,
    required ProfileUseCase profileUseCase}) async {
  emit(state.copyWith(isLoadingForUserInfo: true));
  try {
    final response = await profileUseCase.execute(null);
    response.fold(
            (failure) => _handleProfileFailure(failure: failure, emit: emit, state: state),
            (success) {
          return _handleProfileSuccess(success: success, emit: emit, state: state);
        });
  } catch (e) {
    emit(state.copyWith(
      isFailure: true,
      message: e.toString(),
      isLoadingForUserInfo: false,
    ));
  }
}

 _handleProfileSuccess({required SignedInUserResponseModel success, required Emitter<MyAccountWithInitialState> emit, required MyAccountWithInitialState state}) {
  String phone =
      '${success.data?.mobile?.code} ${success.data?.mobile?.number}';
  emit(state.copyWith(
    fullName: success.data!.fullName!,
    cachedNetworkImageUrl: success.data!.profile ?? '',
    email: success.data!.email!,
    phone: phone.contains('null') ? '+49 123467891012' : phone,
    signedInUserResponseModel: success,
    isLoadingForUserInfo: false,
  ));
}

_handleProfileFailure({required Failure failure, required Emitter<MyAccountWithInitialState> emit, required MyAccountWithInitialState state}) {
  emit(state.copyWith(
    isFailure: true,
    message: failure.message,
    isLoadingForUserInfo: false,
  ));
}

handleSignOut(
    {required TriggerSignOut event,
      required Emitter<MyAccountWithInitialState> emit,
      required MyAccountWithInitialState state,
      required SignOutUseCase signOutUseCase}) async {
  emit(state.copyWith(isLoadingForLogout: true));

  try {
    final response = await signOutUseCase.execute(null);
    response.fold(
            (failure) =>_handleSignOutFailure(failure: failure, emit: emit, state: state),
            (success) => _handleSignOutSuccess(success: success, emit: emit, state: state));
  } catch (e) {
    emit(state.copyWith(
      isFailure: true,
      message: e.toString(),
      isLoadingForLogout: false,
    ));
  }
}

_handleSignOutSuccess({required CommonResponseModel success, required Emitter<MyAccountWithInitialState> emit, required MyAccountWithInitialState state}) {
  emit(state.copyWith(
    isLoadingForLogout: false,
    isFailure: false,
    isLogout: true,
    message: success.message!,
  ));
}

_handleSignOutFailure({required Failure failure, required Emitter<MyAccountWithInitialState> emit, required MyAccountWithInitialState state}) {
  emit(state.copyWith(
    isFailure: true,
    message: failure.message,
    isLoadingForLogout: false,
  ));
}
