import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/assets.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/widgets/circuler_loader.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/widgets/image_view.dart';

class PickedProfileImage extends StatelessWidget {
  const PickedProfileImage({super.key, this.imageFile, this.imageUrl,
    this.isCircleAvtar = false});
  final bool isCircleAvtar;
  final String? imageUrl;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ?  CachedNetworkImage(
      imageUrl: imageUrl!,
      placeholder: (context, url) => const CircularIndicator(),
    ) : imageFile != null ?
    Image.file(imageFile!, fit: BoxFit.cover)
        :  SvgPicture.asset(Assets.icLogo, fit: BoxFit.cover);
  }
}