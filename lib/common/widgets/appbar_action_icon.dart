import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/radius.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/widgets/image_view.dart';

class AppBarActionIcon extends StatelessWidget {
  final bool isLeading;
  final String svg;
  final EdgeInsets? margin;
  final Function()? onTap;
  final double? height, width;
  final double? iconH, iconW;
  const AppBarActionIcon({super.key, required this.isLeading, this.margin,
    required this.svg, required this.onTap, this.height, this.width,
    this.iconH, this.iconW});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: isLeading ? 0: 50.h, width: isLeading ? 0 : 40.w,
        margin: margin ?? EdgeInsets.fromLTRB(isLeading ? 15.w : 0, 5.h, isLeading ? 0 : 15.w, 10.h),
        decoration: BoxDecoration(
            color: AppColor.colorPrimaryInverse,
            borderRadius: BorderRadius.circular(cardRadius)
        ),
        alignment: Alignment.center,
        child: ImageView(svgPath: svg,
          height: iconH, width: iconW,
          color: AppColor.colorPrimary,
        ),
      ),
    );
  }
}
