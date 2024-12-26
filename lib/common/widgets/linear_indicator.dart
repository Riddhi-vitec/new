import 'package:flutter/material.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';

class LinearIndicator extends StatelessWidget {
  const LinearIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LinearProgressIndicator(
          color: AppColor.colorPrimary,
        )
    );
  }
}