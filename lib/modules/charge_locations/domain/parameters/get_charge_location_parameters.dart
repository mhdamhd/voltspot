import 'package:equatable/equatable.dart';

class GetChargeLocationParameters extends Equatable {
  final String city;

  const GetChargeLocationParameters({required this.city});

  Map<String, dynamic> toJson() => {
        'city': city
      };

  @override
  List<Object> get props => [city];
}
