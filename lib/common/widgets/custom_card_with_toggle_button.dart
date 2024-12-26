import 'package:flutter/material.dart';

import '../../imports/common.dart';

Widget customCardWithToggleButton(
    {required String title,
      required Function() toggle,
      required bool isToggled,
      required String description}) =>
    Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Style.titleStyle()),
                CustomCupertinoToggleButton(
                  trackColor: AppColor.colorError,
                  onChanged: (value) {
                    toggle();
                  },
                  isToggled: isToggled,
                ),
              ],
            ),
            Text(
              description,
              style: Style.paragraphStyle(),
            )
          ],
        ),
      ),
    );