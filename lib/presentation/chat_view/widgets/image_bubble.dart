
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageBubble extends StatelessWidget {
  ImageBubble({
    super.key,
    required this.isNetwork,
    required this.message,
  });

  bool isNetwork;
  dynamic message;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.w,
      width: 200.w,
      child: isNetwork ? Image.network(message):Image.file(message),
    );
  }
}
