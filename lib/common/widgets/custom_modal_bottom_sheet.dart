import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template_flutter_mvvm_repo_bloc/root_app.dart';

import '../../imports/common.dart';

class CustomModalBottomSheet {
  static void showCustomModalBottomSheet({
    required String? title,
    String? subTitle,
    Widget? body,
    Widget? footer,
    required String leftButtonName,
    required bool isDismissible,
    required bool isDraggable,
    required String rightButtonName,
    required VoidCallback leftButtonFunction,
    required VoidCallback rightButtonFunction,
    required bool isBodyAnImage,
    required bool willPopScope,
    required bool isScrollableContents,
    Color bottomSheetColor = Colors.yellow,
  }) {
    BuildContext context = navigatorKey.currentState!.context;
    showModalBottomSheet(
      isDismissible: isDismissible,
      enableDrag: isDraggable,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(cardRadius),
        ),
      ),
      context: context,
      builder: (BuildContext ctx) {
        return willPopScope
            ? WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: ModalBottomSheet(
                  isScrollableContents: isScrollableContents,
                  isBodyAnImage: isBodyAnImage,
                  leftButtonFunction: leftButtonFunction,
                  leftButtonName: leftButtonName,
                  rightButtonFunction: rightButtonFunction,
                  rightButtonName: rightButtonName,
                  title: title,
                  subTitle: subTitle,
                  body: body,
                  footer: footer,
                  bottomSheetColor: bottomSheetColor,
                ),
              )
            : ModalBottomSheet(
                isBodyAnImage: isBodyAnImage,
                isScrollableContents: isScrollableContents,
                leftButtonFunction: leftButtonFunction,
                leftButtonName: leftButtonName,
                rightButtonFunction: rightButtonFunction,
                rightButtonName: rightButtonName,
                title: title,
                subTitle: subTitle,
                body: body,
                footer: footer,
                bottomSheetColor: bottomSheetColor,
              );
      },
    );
  }
}

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({
    super.key,
    required this.title,
    this.subTitle,
    this.body,
    this.footer,
    required this.leftButtonName,
    required this.isScrollableContents,
    required this.rightButtonName,
    required this.leftButtonFunction,
    required this.rightButtonFunction,
    required this.isBodyAnImage,
    required this.bottomSheetColor,
  });

  final String? title;
  final String? subTitle;
  final Widget? body;
  final Widget? footer;
  final String leftButtonName;
  final String rightButtonName;
  final VoidCallback leftButtonFunction;
  final VoidCallback rightButtonFunction;
  final bool isBodyAnImage;
  final bool isScrollableContents;
  final Color bottomSheetColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          isScrollableContents ? getScreenHeight(context: context) * 0.5 : null,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(bottomSheetRadius),
              topRight: Radius.circular(bottomSheetRadius),
            ),
            child: Container(
              color: bottomSheetColor,
              padding: EdgeInsets.fromLTRB(
                  bottomSheetHPadding,
                  bottomSheetVPadding,
                  bottomSheetHPadding,
                  bottomSheetVPadding),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: Style.subTitleBoldStyle(
                          color: AppColor.colorPrimaryText),
                    ),
                  SvgPicture.asset(Assets.icBlueDivider),
                  if (subTitle != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: widgetBottomPadding),
                      child: Text(
                        subTitle!,
                        style: Style.paragraphStyle(
                            color: AppColor.colorAccentText),
                      ),
                    ),
                  SizedBox(
                      height: isScrollableContents
                          ? getScreenHeight(context: context) * 0.3
                          : null,
                      child: isScrollableContents
                          ? SingleChildScrollView(
                              child: buildModalBodyContents(),
                            )
                          : buildModalBodyContents()),
                  RowWithTwoButtons(
                    rightButtonText: rightButtonName,
                    leftButtonText: leftButtonName,
                    leftButtonOnTap: leftButtonFunction,
                    rightButtonOnTap: rightButtonFunction,
                    leftButtonSize: ButtonSize.medium,
                    rightButtonSize: ButtonSize.medium,
                    leftButtonVariant: ButtonVariant.btnWithBorder,
                    rightButtonVariant: ButtonVariant.btnPrimary,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildModalBodyContents() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      if (body != null)
        Padding(
          padding: EdgeInsets.only(bottom: widgetBottomPadding),
          child: body!,
        ),
      if (footer != null) footer!,
    ]);
  }
}
