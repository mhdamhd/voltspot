import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:voltspot/core/errors/failure.dart';
import 'package:voltspot/modules/charge_locations/data/data_source/charge_locations_data_source.dart';
import 'package:voltspot/modules/charge_locations/data/models/charge_location_model.dart';
import 'package:voltspot/modules/charge_locations/data/repository/charge_locations_repository_imp.dart';
import 'package:voltspot/modules/charge_locations/domain/entities/charge_location_entity.dart';
import 'package:voltspot/modules/charge_locations/domain/parameters/get_charge_location_parameters.dart';

class MockDS extends Mock implements ChargeLocationsDataSource {}

void main() {
  late MockDS ds;
  late ChargeLocationsRepositoryImp repo;

  setUpAll(() {
    // 👇 required so `any()` works with non-nullable GetChargeLocationParameters
    registerFallbackValue(const GetChargeLocationParameters(city: 'dummy'));
  });

  setUp(() {
    ds = MockDS();
    repo = ChargeLocationsRepositoryImp(ds);
  });

  test('returns Right(List<ChargeLocationEntity>) on success', () async {
    final models = [
      ChargeLocationModel(
        address: 'A', city: 'C', country: 'NL', latitude: 1, longitude: 2, evses: const [],
      ),
    ];

    when(() => ds.getChargeLocations(any<GetChargeLocationParameters>()))
        .thenAnswer((_) async => models);

    final res = await repo.getChargeLocations(
      const GetChargeLocationParameters(city: 'Amsterdam'),
    );

    expect(res.isRight(), true);
    res.fold(
          (l) => fail('Expected Right, got Left: ${l.message}'),
          (r) {
        expect(r, isA<List<ChargeLocationEntity>>());
        expect(r.first.address, 'A');
      },
    );

    verify(() => ds.getChargeLocations(any<GetChargeLocationParameters>())).called(1);
  });

  test('maps exceptions to Failure via ErrorsHandler', () async {
    when(() => ds.getChargeLocations(any<GetChargeLocationParameters>()))
        .thenThrow(Exception('boom'));

    final res = await repo.getChargeLocations(
      const GetChargeLocationParameters(city: 'Amsterdam'),
    );

    expect(res.isLeft(), true);
    res.fold(
          (l) => expect(l, isA<Failure>()),
          (_) => fail('Expected Left, got Right'),
    );
  });
}
