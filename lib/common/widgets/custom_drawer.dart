import 'package:flutter/material.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/assets.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_strings.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/widgets/image_view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      width: size.width / 2,
      backgroundColor: AppColor.colorPrimaryInverse,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, right: 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  text == AppStrings.dashboard_openDrawer_text
                      ? Scaffold.of(context).closeDrawer()
                      : Scaffold.of(context).closeEndDrawer();
                },
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: ImageView(
                    svgPath: Assets.icCircularCross,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(text)
            ],
          ),
        ),
      ),
    );
  }
}