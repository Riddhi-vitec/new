import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../imports/common.dart';
import '../bloc/edit_profile_bloc.dart';

Padding buildProfileImage(
    {required BuildContext context,required EditProfileWithInitialState state, required  dynamic Function() onCameraClick, required dynamic Function() onGalleryClick }) {
  return Padding(
    padding: EdgeInsets.only(bottom: widgetBottomPadding),
    child: Center(
      child: Stack(
        children: [
          SizedBox(height: 110.h, width: 120.w),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteName.routeProfilePhoto,
              );
            },
            child: Container(
              height: profileContainerHeight,
              width: profileContainerWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(cardRadius),
                  border: Border.all(color: AppColor.colorAbsent),
                  color: AppColor.colorPrimaryInverse),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(cardRadius),
                child: PickedProfileImage(
                    imageUrl: state.imageUrl,
                    imageFile: state.fileImage),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      shape: Style.bottomSheetShape(),
                      context: context,
                      builder: (context) {
                        return MediaSelectionBottomSheet(
                            title: AppStrings
                                .myAccount_profileSettings_editView_selectProfileBtn,
                            onCameraClick:onCameraClick,
                            onGalleryClick: onGalleryClick);
                      });
                },
                child: CircleAvatar(
                  radius: cameraIconBorderRadius,
                  backgroundColor: AppColor.colorPrimary,
                  child: CircleAvatar(
                    radius: cameraIconRadius,
                    backgroundColor: AppColor.colorPrimaryInverse,
                    child: const Icon(Icons.edit),
                  ),
                ),
              )),
        ],
      ),
    ),
  );
}