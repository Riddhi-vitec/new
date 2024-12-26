import 'package:flutter/material.dart';
import '../../../imports/common.dart';

class FossDetailView extends StatelessWidget {
  final Map licenceDetails;
  const FossDetailView(
      {super.key, required this.licenceDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: licenceDetails['title'].toString().toUpperCase(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenHPadding, vertical: screenVPadding),
        child: Column(
          children: [
            Text(
              licenceDetails["licence"],
              style: Style.paragraphStyle(),
            ),
          ],
        ),
      ),
    );
  }
}