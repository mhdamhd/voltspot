import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:voltspot/core/errors/failure.dart';

import 'package:voltspot/core/utils/base_state.dart';
import 'package:voltspot/modules/charge_locations/domain/entities/charge_location_entity.dart';
import 'package:voltspot/modules/charge_locations/domain/parameters/get_charge_location_parameters.dart';
import 'package:voltspot/modules/charge_locations/domain/repository/charge_locations_repository.dart';
import 'package:voltspot/modules/charge_locations/presentation/blocs/charge_locations_bloc/charge_locations_bloc.dart';

/// --- Test Doubles ---

class MockChargeLocationsRepository extends Mock
    implements ChargeLocationsRepository {}

class FakeGetParams extends Fake implements GetChargeLocationParameters {}

/// Minimal Failure type used by BaseState in your project. If you already have a Failure class, import it instead.
// class Failure {
//   final String message;
//   Failure(this.message);
// }

/// Helpers to quickly make entities for tests.
ChargeLocationEntity makeLoc({
  String address = 'Address',
  String city = 'Amsterdam',
  String country = 'NL',
  int available = 2,
  int total = 3,
}) {
  final evses = List.generate(total, (i) {
    final isAvail = i < available;
    return EvseEntity(
      evseId: 'EVSE-$i',
      status: isAvail ? EvseStatus.available : EvseStatus.unavailable,
      connectorType: 'CCS',
      powerType: 'AC',
    );
  });
  return ChargeLocationEntity(
    address: address,
    city: city,
    country: country,
    latitude: 0,
    longitude: 0,
    evses: evses,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockChargeLocationsRepository repo;

  setUpAll(() {
    registerFallbackValue(FakeGetParams());
  });

  setUp(() {
    repo = MockChargeLocationsRepository();
  });

  group('ChargeLocationsBloc', () {
    blocTest<ChargeLocationsBloc, BaseState<List<ChargeLocationEntity>>>(
      'emits [loading, success] on SearchCityChanged after debounce (success path)',
      build: () {
        when(() => repo.getChargeLocations(any())).thenAnswer(
              (_) async => Right(<ChargeLocationEntity>[makeLoc()]),
        );
        return ChargeLocationsBloc(repo);
      },
      act: (bloc) {
        // Use FakeAsync to advance virtual time past debounce (400ms)
        fakeAsync((fa) {
          bloc.add(const SearchCityChanged('A'));
          bloc.add(const SearchCityChanged('Am'));
          bloc.add(const SearchCityChanged('Ams'));
          // Before 400ms elapse – nothing should happen
          fa.elapse(const Duration(milliseconds: 399));
          // Cross the boundary so the debounced stream emits
          fa.elapse(const Duration(milliseconds: 2));
        });
      },
      expect: () => [
        // loading then success
        predicate<BaseState<List<ChargeLocationEntity>>>((s) => s.isLoading),
        predicate<BaseState<List<ChargeLocationEntity>>>((s) =>
        s.isSuccess && (s.data?.isNotEmpty ?? false)),
      ],
      verify: (_) {
        // Only one call due to debounce + switchMap
        verify(() => repo.getChargeLocations(any())).called(1);
      },
    );

    blocTest<ChargeLocationsBloc, BaseState<List<ChargeLocationEntity>>>(
      'emits [init] when SearchCityChanged with empty string',
      build: () => ChargeLocationsBloc(repo),
      act: (bloc) {
        // No repo call expected
        bloc.add(const SearchCityChanged(''));
      },
      expect: () => [
        // Back to initial state
        predicate<BaseState<List<ChargeLocationEntity>>>((s) => s.isInit),
      ],
      verify: (_) => verifyNever(() => repo.getChargeLocations(any())),
    );

    blocTest<ChargeLocationsBloc, BaseState<List<ChargeLocationEntity>>>(
      'emits [loading, error] on SearchCityChanged when repository fails',
      build: () {
        when(() => repo.getChargeLocations(any())).thenAnswer(
              (_) async => const Left(Failure('Server error')),
        );
        return ChargeLocationsBloc(repo);
      },
      act: (bloc) {
        fakeAsync((fa) {
          bloc.add(const SearchCityChanged('Amsterdam'));
          fa.elapse(const Duration(milliseconds: 401));
        });
      },
      expect: () => [
        predicate<BaseState<List<ChargeLocationEntity>>>((s) => s.isLoading),
        predicate<BaseState<List<ChargeLocationEntity>>>((s) => s.isError),
      ],
    );

    blocTest<ChargeLocationsBloc, BaseState<List<ChargeLocationEntity>>>(
      'GetChargeLocationsEvent bypasses debounce and fetches immediately',
      build: () {
        when(() => repo.getChargeLocations(any())).thenAnswer(
              (_) async => Right(<ChargeLocationEntity>[makeLoc()]),
        );
        return ChargeLocationsBloc(repo);
      },
      act: (bloc) async {
        bloc.add(const GetChargeLocationsEvent(city: 'Amsterdam'));
      },
      expect: () => [
        predicate<BaseState<List<ChargeLocationEntity>>>((s) => s.isLoading),
        predicate<BaseState<List<ChargeLocationEntity>>>((s) => s.isSuccess),
      ],
      verify: (_) => verify(() => repo.getChargeLocations(any())).called(1),
    );
  });
}
