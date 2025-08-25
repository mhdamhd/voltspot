part of 'charge_locations_bloc.dart';

class ChargeLocationsEvent extends Equatable {
  const ChargeLocationsEvent();

  @override
  List<Object> get props => [];
}
class SearchCityChanged extends ChargeLocationsEvent {
  final String city;
  const SearchCityChanged(this.city);

  @override
  List<Object> get props => [city];
}

class GetChargeLocationsEvent extends ChargeLocationsEvent {
  final String city;

  const GetChargeLocationsEvent({required this.city});

  @override
  List<Object> get props => [city];
}
