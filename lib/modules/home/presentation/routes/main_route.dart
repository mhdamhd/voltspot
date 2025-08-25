import 'package:go_router/go_router.dart';
import 'package:voltspot/modules/home/presentation/screens/main_screen.dart';

class MainRoute {
  static const String name = '/main';
  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) => const MainScreen(),
  );
}
