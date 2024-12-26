import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


import '../../../../imports/common.dart';



class OtpTimer extends StatefulWidget {
  const OtpTimer({
    super.key,
    required this.animationController, required this.animationProgressValue,
  });


  final AnimationController animationController;
  final num animationProgressValue;

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {

  @override
  Widget build(BuildContext context) {

    return SizedBox(
        height: 90.h,
        width: 40.w,
        child: Stack(alignment: Alignment.center, children: [
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                  height: 60.h,
                  width: 40.w,
                  child: AnimatedBuilder(
                    animation: widget.animationController,
                    builder: (context, child) {
                      return CircularPercentIndicator(
                          radius: 25.r,
                          curve: Curves.linear,
                          reverse: false,
                          percent: double.parse(
                              (widget.animationProgressValue / 60)
                                  .toString()),
                          backgroundColor: AppColor.colorAccent,
                          circularStrokeCap:
                          CircularStrokeCap.round,
                          progressColor: Colors.white70,
                          center: Text(
                            "${(widget.animationProgressValue.round())}s",
                            style: Style.paragraphStyle(),
                          ));
                    },
                  ))),
        ]));
  }
}