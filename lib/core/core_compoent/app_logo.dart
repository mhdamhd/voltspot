import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voltspot/core/constants/app_constants.dart';
import 'package:voltspot/core/paths/images_paths.dart';

class AppLogo extends StatelessWidget {
  final double? width;

  const AppLogo({
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: AppConstants.logoTag,
      child: SizedBox(
          width: width ?? 150.w, child: Image.asset(ImagesPaths.logoPng)),
    );
  }
}
