import 'package:dartz/dartz.dart';
import 'package:voltspot/core/errors/failure.dart';
import 'package:voltspot/modules/charge_locations/domain/entities/charge_location_entity.dart';
import 'package:voltspot/modules/charge_locations/domain/parameters/get_charge_location_parameters.dart';

abstract class ChargeLocationsRepository {
  Future<Either<Failure, List<ChargeLocationEntity>>> getChargeLocations(
      GetChargeLocationParameters parameters);
}
