import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/other_constants.dart';

import '../../../imports/common.dart';
import '../bloc/onboarding_bloc.dart';
import 'carousel_image.dart';
import 'carousel_text.dart';

class Carousel extends StatelessWidget {
  final CarouselModel carouselModel;

  const Carousel({Key? key, required this.carouselModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    space(double p) => SizedBox(height: getScreenHeight(context: context) * p / 100);
    return Column(
      children: [
        space(10),
        CarouselImage(
          image: carouselModel.image,
          color: carouselModel.bgColor,
        ),
        space(8),
        CarouselText(

          text: carouselModel.title,
        textColor: carouselModel.textColor,
          isTitle: true,
        ),CarouselText(
          isTitle: false,
          text: carouselModel.subTitle,
          textColor: carouselModel.textColor,
        ),
      ],
    );
  }
}



