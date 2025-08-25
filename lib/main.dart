import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voltspot/core/constants/app_constants.dart';
import 'package:voltspot/core/routes/app_routes.dart';
import 'package:voltspot/core/services/service_locator.dart';
import 'package:voltspot/core/themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  ServicesLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: (_, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppConstants.applicationName,
            theme: AppTheme().lightTheme,
            darkTheme: AppTheme().lightTheme,
            routerConfig: AppRoutes.router,
          );
        });
  }
}
