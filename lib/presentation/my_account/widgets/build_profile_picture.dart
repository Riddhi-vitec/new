import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../imports/common.dart';
import '../bloc/my_account_bloc.dart';

Align buildProfilePicture(MyAccountWithInitialState state) {
  return Align(
      alignment: Alignment(0, -0.3.h),
      child: Container(
        width: 130.w,
        height: 116.h,
        color: AppColor.colorPrimaryInverse,
        child: state.isLoadingForUserInfo? const CustomLoader(child: SizedBox(),): state.cachedNetworkImageUrl
            .isNotEmpty
            ? CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: state
                .cachedNetworkImageUrl)
            : SvgPicture.asset(Assets.icLogo, fit: BoxFit.cover,),
      ));
}