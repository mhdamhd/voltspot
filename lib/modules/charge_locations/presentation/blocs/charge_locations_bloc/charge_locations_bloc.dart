import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voltspot/core/utils/base_state.dart';
import 'package:voltspot/modules/charge_locations/domain/entities/charge_location_entity.dart';
import 'package:voltspot/modules/charge_locations/domain/parameters/get_charge_location_parameters.dart';
import 'package:voltspot/modules/charge_locations/domain/repository/charge_locations_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'charge_locations_event.dart';



class ChargeLocationsBloc
    extends Bloc<ChargeLocationsEvent, BaseState<List<ChargeLocationEntity>>> {
  final ChargeLocationsRepository chargeLocationsRepository;

  ChargeLocationsBloc(this.chargeLocationsRepository)
      : super(const BaseState<List<ChargeLocationEntity>>()) {
    on<SearchCityChanged>(
      _onSearchCityChanged,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 400))
          .switchMap(mapper),
    );
    on<GetChargeLocationsEvent>(_getChargeLocations);
  }

  FutureOr<void> _onSearchCityChanged(
      SearchCityChanged event,
      Emitter<BaseState<List<ChargeLocationEntity>>> emit,
      ) async {
    final city = event.city.trim();
    if (city.isEmpty) {
      emit(const BaseState<List<ChargeLocationEntity>>()); // init
      return;
    }
    emit(state.loading());
    final result = await chargeLocationsRepository
        .getChargeLocations(GetChargeLocationParameters(city: city));
    result.fold((l) => emit(state.error(l)), (r) => emit(state.success(r)));
  }


  FutureOr<void> _getChargeLocations(
      GetChargeLocationsEvent event,
      Emitter<BaseState<List<ChargeLocationEntity>>> emit,
      ) async {
    final city = event.city.trim();
    if (city.isEmpty) {
      emit(const BaseState<List<ChargeLocationEntity>>()); // init
      return;
    }
    emit(state.loading());
    final result = await chargeLocationsRepository
        .getChargeLocations(GetChargeLocationParameters(city: event.city));
    result.fold((l) => emit(state.error(l)), (r) => emit(state.success(r)));
  }
}
