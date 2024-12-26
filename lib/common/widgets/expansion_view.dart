import 'package:flutter/material.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/radius.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/widgets/image_view.dart';

class ExpansionView extends StatelessWidget {
  final String title;
  final List<Widget>? children;
  final String leadingIcon;

  const ExpansionView(
      {super.key, required this.title, required this.leadingIcon, this.children});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(cardRadius),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cardRadius)),
        leading: ImageView(svgPath: leadingIcon,
            color: AppColor.colorPrimary),
        tilePadding: EdgeInsets.zero,
        // set it zero to remove default padding
        title: Text(title),
        children: children!,
      ),
    );
  }
}