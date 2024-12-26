import 'package:flutter/material.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_strings.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/paddings.dart';


import 'package:template_flutter_mvvm_repo_bloc/common/widgets/custom_button.dart';

import '../../imports/common.dart';

class MediaSelectionBottomSheet extends StatelessWidget {
  final String title;
  final Function() onCameraClick;
  final Function() onGalleryClick;
  const MediaSelectionBottomSheet({super.key, required this.title,
    required this.onCameraClick, required this.onGalleryClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenHPadding, vertical: screenVPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(width: 64, height: 4,
            decoration: BoxDecoration(
                color: AppColor.colorSecondary,
                borderRadius: BorderRadius.circular(20)),
          ),
          const SizedBox(height: 20),
          Text(title),
          const SizedBox(height: 20),
          CustomButton(
            text: AppStrings.myAccount_profileSettings_editView_changeProfileImage_cameraBtn,
            variant: ButtonVariant.btnPrimary,
            onTap: onCameraClick,
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: AppStrings.myAccount_profileSettings_editView_changeProfileImage_galleryBtn,
            variant: ButtonVariant.btnPrimary,
            onTap: onGalleryClick
          ),
        ],
      ),
    );
  }
}
