import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/assets.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/paddings.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/radius.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/style.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/widgets/appbar_action_icon.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/widgets/image_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
    this.isLeading = true,
    this.onTap,
  }) : super(key: key);

  final Widget? leading;
  final bool isLeading;
  final String? title;
  final bool? centerTitle;
  final List<Widget>? actions;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.colorPrimary, //change according to your requirement
      leading: isLeading ?
        AppBarActionIcon(isLeading: isLeading, svg: Assets.icLeftArrow,
            onTap: onTap ?? (){
              Navigator.pop(context);
            }
        )
        : null,
      title: Container(
          margin: isLeading == false ?  EdgeInsets.only(left: screenHPadding): null,
          padding: isLeading == false ? null :  EdgeInsets.only(left: 10.w),
          child: Text(title!,
            overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,
            style: Style.appBarTitleStyle(color: AppColor.colorPrimaryInverse),
          )
      ),
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}