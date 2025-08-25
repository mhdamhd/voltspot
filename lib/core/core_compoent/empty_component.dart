import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voltspot/core/constants/app_colors.dart';

class EmptyComponent extends StatelessWidget {
  const EmptyComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 300.h),
        Icon(
          Icons.warning_amber,
          size: 100.w,
          color: AppColors.yellow,
        ),
        SizedBox(height: 10.w),
        Text(
          "No Locations Found",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
