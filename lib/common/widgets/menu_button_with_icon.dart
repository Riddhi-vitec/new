import 'package:flutter/material.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/assets.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/paddings.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/style.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/widgets/custom_divider.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/widgets/image_view.dart';

class MenuButtonWithIcon extends StatelessWidget {
  final String text;
  final Function() onTap;
  final String? leadingIcon, actionIcon;
  const MenuButtonWithIcon({super.key, required this.text,
    required this.onTap, this.leadingIcon, this.actionIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: menuCardHorizontalPadding,
            vertical: menuCardVerticalPadding
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(right: leadingIcon !=null ?12.0: 0),
              child: ImageView(svgPath: leadingIcon),
            ),
            Expanded(child: Text(text, overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left, style: Style.titleStyle(color: AppColor.colorPrimary),
            )),
            ImageView(svgPath: actionIcon ?? Assets.icLeftArrow)
          ],
        ),
      ),
    );
  }
}