import 'package:go_router/go_router.dart';
import 'package:voltspot/modules/home/presentation/screens/splash_screen.dart';

class SplashRoute {
  static const String name = '/splash';
  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) => const SplashScreen(),
  );
}
