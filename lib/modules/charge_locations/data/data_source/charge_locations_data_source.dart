import 'package:voltspot/modules/charge_locations/data/models/charge_location_model.dart';
import 'package:voltspot/modules/charge_locations/domain/parameters/get_charge_location_parameters.dart';

abstract class ChargeLocationsDataSource {
  Future<List<ChargeLocationModel>> getChargeLocations(GetChargeLocationParameters parameters);
}