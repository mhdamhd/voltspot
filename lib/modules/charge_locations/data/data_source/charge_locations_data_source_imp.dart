import 'package:voltspot/core/constants/apis_urls.dart';
import 'package:voltspot/core/services/api_services.dart';
import 'package:voltspot/core/utils/app_response.dart';
import 'package:voltspot/modules/charge_locations/data/data_source/charge_locations_data_source.dart';
import 'package:voltspot/modules/charge_locations/data/models/charge_location_model.dart';
import 'package:voltspot/modules/charge_locations/domain/parameters/get_charge_location_parameters.dart';

class ChargeLocationsRemoteDataSourceImp extends ChargeLocationsDataSource {

  @override
  Future<List<ChargeLocationModel>> getChargeLocations(GetChargeLocationParameters parameters) async {
    AppResponse appResponse = await ApiServices()
        .get(ApisUrls.chargeLocations, data: parameters.toJson());
    List<ChargeLocationModel> list = [];
    appResponse.data.forEach((v) {
      list.add(ChargeLocationModel.fromJson(v));
    });
    return list;
  }
}