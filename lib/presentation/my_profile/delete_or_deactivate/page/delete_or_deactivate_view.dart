import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/my_profile/delete_or_deactivate/bloc/delete_or_deactivate_bloc.dart';

import '../../../../device_variables.dart';
import '../../../../di/di.dart';
import '../../../../imports/common.dart';
import '../../../../imports/data.dart';

class DeleteOrDeactivateView extends StatelessWidget {
  DeleteOrDeactivateView({super.key});

  final DeleteOrDeactivateBloc deleteOrDeactivateBloc =
      instance<DeleteOrDeactivateBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => deleteOrDeactivateBloc,
      child: BlocListener<DeleteOrDeactivateBloc,
          DeleteOrDeactivateWithInitialState>(
        listener: (context, state) {
          if (state.message.isNotEmpty) {
            Toast.nullableIconToast(
                message: state.message,
                isErrorBooleanOrNull: state.isFailure ? true : false);
            if (!state.isFailure) {
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteName.routeVerifyOtp,
                  arguments: OtpRequestModel(
                    socialId: null,
                    otp: '',
                    email: state.email,
                    password: '',
                    deviceToken: '',
                    fullName: '',
                    socialType: null,
                    isChangeEmail: false,
                    isAccountDeletion: true,
                    isSocialAccountVerification: false,
                    deviceType: DeviceVariables.deviceType,
                  ),
                  (route) => false);
            }
          }
        },
        child: BlocBuilder<DeleteOrDeactivateBloc,
            DeleteOrDeactivateWithInitialState>(
          builder: (context, state) {
            return Scaffold(
              appBar: const CustomAppBar(
                title: AppStrings
                    .myAccount_editProfile_deleteOrDeactivate_screen_title,
                isLeading: true,
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenHPadding, vertical: screenVPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: widgetTopPadding),
                    Text(
                        AppStrings
                            .myAccount_editProfile_deleteOrDeactivate_title,
                        textAlign: TextAlign.center,
                        style: Style.titleBoldStyle(
                            color: AppColor.colorPrimary)),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: widgetBottomPadding),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.visibility_off,
                              color: AppColor.colorDisable),
                          SizedBox(width: 10.w),
                          Expanded(
                              child: Text(
                                  AppStrings
                                      .myAccount_editProfile_deleteOrDeactivate_deleteAccount_description_text,
                                  style: Style.paragraphStyle()))
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.warning, color: AppColor.colorError),
                        SizedBox(width: 10.w),
                        Expanded(
                            child: Text(
                          AppStrings
                              .myAccount_editProfile_deleteOrDeactivate_deactivateAccount_description_text,
                          style: Style.paragraphStyle(),
                        ))
                      ],
                    ),
                    const Spacer(flex: 2),
                    RowWithTwoButtons(
                      leftButtonSize: ButtonSize.large,
                      rightButtonSize: ButtonSize.large,
                      leftButtonText: AppStrings.common_deleteBtn,
                      rightButtonText: AppStrings.common_deactivateBtn,
                      leftButtonVariant: ButtonVariant.btnWithBorder,
                      rightButtonVariant: ButtonVariant.btnPrimary,
                      leftButtonOnTap: () {
                        deleteOrDeactivateBloc.add(TriggerDeleteAccount());
                      },
                      rightButtonOnTap: () {},
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
