import 'package:go_router/go_router.dart';
import 'package:voltspot/modules/charge_locations/presentation/screens/charge_locations_screen.dart';

class ChargeLocationsRoute {
  static const String name = '/charge_locations';
  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) {
      return const ChargeLocationsScreen();
    },
  );
}