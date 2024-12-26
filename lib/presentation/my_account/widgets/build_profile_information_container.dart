import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../imports/common.dart';
import '../bloc/my_account_bloc.dart';

Container buildProfileInformationContainer(MyAccountWithInitialState state) {
  return Container(
    height: 145.h,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(10.r),
        color: AppColor.colorPrimary),
    child: Padding(
      padding: EdgeInsets.only(
          bottom: 15.h,
          left: 5.w,
          right: 5.w),
      child: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.end,
          children: [

            if(!state.isLoadingForUserInfo)  ... [
              buildUserInfoRow(info: state.fullName, icon: Icons.person),
              buildUserInfoRow(info: state.email, icon: Icons.mail_outline),
              buildUserInfoRow(info: state.phone, icon: Icons.phone_android_rounded),
             ],
            if(state.isLoadingForUserInfo)
              Center(child: SizedBox(height: 50.h,child: const CustomLoader(child: SizedBox())))
          ],

        ),
      ),
    ),
  );
}

Row buildUserInfoRow({required IconData icon, required String info }) {
  return Row(
    mainAxisAlignment:
    MainAxisAlignment.center,
    crossAxisAlignment:
    CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 2.h),
        child: Icon(icon,
            color: AppColor
                .colorPrimaryInverse),
      ),
      Flexible(
          child: Text(info,
              maxLines: 2,
              overflow:
              TextOverflow.ellipsis,
              style: Style.titleStyle(
                  color: AppColor
                      .colorPrimaryInverse))),
    ],
  );
}
