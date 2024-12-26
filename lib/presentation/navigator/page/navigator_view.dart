import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:template_flutter_mvvm_repo_bloc/di/di.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/dashboard/page/dashboard_view.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/navigator/bloc/navigators_bloc.dart';

import '../../../imports/common.dart';
import '../../my_account/page/my_account_view.dart';
import '../../my_products/page/my_products_view.dart';

class NavigatorView extends StatefulWidget {
  const NavigatorView({Key? key}) : super(key: key);

  @override
  State<NavigatorView> createState() => _NavigatorViewState();
}

class _NavigatorViewState extends State<NavigatorView> {
  final NavigatorsBloc _navigatorBloc = instance<NavigatorsBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigatorsBloc>(
      create: (context) =>
          _navigatorBloc,
      child: BlocListener<NavigatorsBloc, NavigatorStateWithInitialState>(
        listener: (context, state) {},
        child: BlocBuilder<NavigatorsBloc, NavigatorStateWithInitialState>(
          builder: (context, state) {
            return Scaffold(
              body: state.currentIndex == 0
                  ?  DashBoardView()
                  : state.currentIndex == 1
                      ? const MyProductsView()
                      : MyAccountView(),
              backgroundColor: AppColor.colorPrimaryInverse,
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: state.currentIndex,
                selectedItemColor: AppColor.colorPrimary,
                unselectedItemColor: AppColor.colorSecondaryText,
                onTap: (int i) {
                  _navigatorBloc.add(TriggerNavigatorsButton(currentIndex: i));
                },
                items: [
                  BottomNavigationBarItem(
                    label: AppStrings.btmNavigation_dashboard_title,
                    icon: SizedBox(
                        child: Icon(Icons.home,
                            color: state.currentIndex == 0
                                ? AppColor.colorPrimary
                                : AppColor.colorDisable)),
                  ),
                  BottomNavigationBarItem(
                    label: AppStrings.btmNavigation_myProducts_title,
                    icon: SizedBox(
                        child: Icon(Icons.list_alt_rounded,
                            color: state.currentIndex == 1
                                ? AppColor.colorPrimary
                                : AppColor.colorDisable)),
                  ),
                  BottomNavigationBarItem(
                    label: AppStrings.btmNavigation_myAccount_title,
                    icon: SizedBox(
                        child: ImageView(
                            svgPath: Assets.icUser,
                            color: state.currentIndex == 2
                                ? AppColor.colorPrimary
                                : AppColor.colorDisable)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
