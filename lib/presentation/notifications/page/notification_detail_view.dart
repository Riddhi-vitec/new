import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../imports/common.dart';

class NotificationDetailView extends StatelessWidget {
  const NotificationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text(AppStrings.notification_details_screen_title),
      ),
      body: const Center(
        child: Text(AppStrings.notification_details_body_title)
      ),
    );
  }
}
