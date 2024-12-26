import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../imports/common.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({
    Key? key,
    required this.color,
    required this.image,
  }) : super(key: key);

  final Color color;
  final String image;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.all(Radius.circular(60.0.r)),
      ),
      child: Image.asset(
        image,
        height: getScreenHeight(context: context) * 0.35,
      ),
    );
  }
}
