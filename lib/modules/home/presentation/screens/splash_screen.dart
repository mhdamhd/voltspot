import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:voltspot/core/constants/app_constants.dart';
import 'package:voltspot/core/constants/app_duration.dart';
import 'package:voltspot/core/core_compoent/app_logo.dart';
import 'package:voltspot/core/core_compoent/app_scaffold.dart';
import 'package:voltspot/core/extensions/theme_extensions/text_theme_extension.dart';
import 'package:voltspot/modules/home/presentation/routes/main_route.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(AppDuration.splashDuration)
        .then((value) => context.go(MainRoute.name));
    return AppScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLogo(),
          SizedBox(height: 10.w),
          Text(AppConstants.applicationVersion, style: context.f14500),
        ],
      ),
    );
  }
}
