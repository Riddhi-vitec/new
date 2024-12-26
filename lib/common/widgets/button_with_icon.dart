import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/radius.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/widget.dart';

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({
    super.key,
    required this.onTap, required this.widget,
  });

  final void Function() onTap;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: iconContainerWidth,
        height: iconContainerHeight,
        ///You may decorate here your custom icon button as per fig using BoxDecoration parameter
        decoration: BoxDecoration(
          // color: Colors.red,
            borderRadius: BorderRadius.circular(cardRadius)
        ),

        margin: const EdgeInsets.all(10),
        child: Center(
          child: widget,
        ),
      ),
    );
  }
}