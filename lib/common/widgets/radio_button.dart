import 'package:flutter/material.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/style.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({Key? key, required this.value, required this.groupValue,
    required this.radioButtonText, required this.onChanged}) : super(key: key);

  final int value;
  final int? groupValue;
  final String radioButtonText;
  final Function(int?)? onChanged;

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //Above two lines added to remove default internal padding of radio widget
          value: widget.value,
          groupValue: widget.groupValue,
          onChanged: widget.onChanged,
          fillColor:
              MaterialStateColor.resolveWith((states) => AppColor.colorPrimary),
        ),
        const SizedBox(width: 5),
        Text(
          widget.radioButtonText,
          style: Style.titleStyle(),
        ),
      ],
    );
  }
}