import 'package:dartz/dartz.dart';
import 'package:voltspot/core/errors/errors_handler.dart';
import 'package:voltspot/core/errors/failure.dart';
import 'package:voltspot/modules/charge_locations/data/data_source/charge_locations_data_source.dart';
import 'package:voltspot/modules/charge_locations/domain/entities/charge_location_entity.dart';
import 'package:voltspot/modules/charge_locations/domain/parameters/get_charge_location_parameters.dart';
import 'package:voltspot/modules/charge_locations/domain/repository/charge_locations_repository.dart';

import '../models/charge_location_model.dart';

class ChargeLocationsRepositoryImp extends ChargeLocationsRepository {
  final ChargeLocationsDataSource chargeLocationsDataSource;

  ChargeLocationsRepositoryImp(this.chargeLocationsDataSource);


  @override
  Future<Either<Failure, List<ChargeLocationEntity>>> getChargeLocations(GetChargeLocationParameters parameters) async {
    return ErrorsHandler.handleEitherList<ChargeLocationEntity, ChargeLocationModel>(
          () => chargeLocationsDataSource.getChargeLocations(parameters),
    );
  }
}
