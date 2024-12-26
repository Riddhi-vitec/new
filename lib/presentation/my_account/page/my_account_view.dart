
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/my_account/bloc/my_account_bloc.dart';
import '../../../di/di.dart';
import '../../../imports/common.dart';
import '../widgets/build_menu.dart';
import '../widgets/build_profile_information_container.dart';
import '../widgets/build_profile_picture.dart';

class MyAccountView extends StatelessWidget {
  MyAccountView({super.key});

  final MyAccountBloc _myAccountBloc = instance<MyAccountBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _myAccountBloc..add(TriggerGetProfile()),
      child: BlocListener<MyAccountBloc, MyAccountWithInitialState>(
        listener: (context, state) {
          if (state.message.isNotEmpty) {
            Toast.nullableIconToast(
                message: state.message,
                isErrorBooleanOrNull: state.isFailure ? true : false);
            if (state.isLogout) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteName.routeSignIn, (route) => false);
            }
          }
        },
        child: BlocBuilder<MyAccountBloc, MyAccountWithInitialState>(
          builder: (context, state) {
            if (state.isLoadingForLogout) {
              return CustomLoader(
                child: buildMyAccountLayout(state, context),
              );
            } else {
              return buildMyAccountLayout(state, context);
            }
          },
        ),
      ),
    );
  }

  Scaffold buildMyAccountLayout(
      MyAccountWithInitialState state, BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.colorScaffold,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenVPadding),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          height: 290.h,
                          child: Stack(
                            alignment: Alignment(0, 0.5.h),
                            children: [
                              buildProfileInformationContainer(state),
                              buildProfilePicture(state),
                            ],
                          )),
                      for (var j = 0;
                          j < state.myAccountMenuModelList.length;
                          j++)
                        buildMenu(context,
                            argument: null,
                            iconUrl: state.myAccountMenuModelList[j].iconUrl,
                            menuTitle:
                                state.myAccountMenuModelList[j].menuTitle,
                            routeName:
                                state.myAccountMenuModelList[j].routeName),
                    ],
                  ),
                ),
              ),
              CustomButton(
                onTap: () {
                  _myAccountBloc.add(TriggerSignOut());
                },
                text: AppStrings.myAccount_logOutBtn,
                variant: ButtonVariant.btnDisable,
              ),
            ],
          ),
        ));
  }



}
