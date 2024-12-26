import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../imports/common.dart';


class FossItemWidget extends StatelessWidget {
  final String title, licence, copyright;
  const FossItemWidget({super.key, required this.title, required this.licence,
    required this.copyright});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius)
      ),
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: cardVerticalPadding, horizontal: cardHorizontalPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Style.titleStyle()),
            SizedBox(height: 5.h),
            Text(licence, style: Style.subTitleStyle()),
            SizedBox(height: 5.h),
            Text(copyright, maxLines: 1, overflow: TextOverflow.ellipsis,style: Style.paragraphStyle()),
          ],
        ),
      ),
    );
  }
}