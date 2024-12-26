import 'package:flutter/cupertino.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';

class CustomCupertinoToggleButton extends StatefulWidget {
  const CustomCupertinoToggleButton(
      {Key? key,
        required this.trackColor,
        required this.onChanged,
        required this.isToggled})
      : super(key: key);
  final Color trackColor;
  final Function(bool) onChanged;
  final bool isToggled;

  @override
  State<CustomCupertinoToggleButton> createState() => _CustomCupertinoToggleButtonState();
}

class _CustomCupertinoToggleButtonState extends State<CustomCupertinoToggleButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      trackColor: widget.trackColor,
      activeColor: AppColor.colorPrimary,
      thumbColor: AppColor.colorPrimaryInverse,
      onChanged: widget.onChanged,
      value: widget.isToggled,
    );
  }
}