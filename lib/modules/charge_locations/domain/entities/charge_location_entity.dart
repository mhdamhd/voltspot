import 'package:voltspot/core/entities/base_entity.dart';
import 'package:equatable/equatable.dart';

enum EvseStatus { available, unavailable, unknown }

extension EvseStatusX on String {
  EvseStatus toEvseStatus() {
    switch (toLowerCase()) {
      case 'available':
        return EvseStatus.available;
      case 'unavailable':
      case 'occupied':
      case 'busy':
        return EvseStatus.unavailable;
      default:
        return EvseStatus.unknown;
    }
  }
}

class ChargeLocationEntity extends BaseEntity with EquatableMixin {
  final String address;
  final String city;
  final String country;
  final num latitude;
  final num longitude;
  final List<EvseEntity> evses;

  ChargeLocationEntity({
    required this.address,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.evses,
  });

  // --- Domain logic ---
  int get totalEvses => evses.length;

  int get availableEvses =>
      evses.where((e) => e.isAvailable).length;

  double get availabilityRatio =>
      totalEvses == 0 ? 0.0 : availableEvses / totalEvses;

  bool get isMostlyAvailable => availabilityRatio > 0.5;

  @override
  List<Object?> get props =>
      [address, city, country, latitude, longitude, evses];
}

class EvseEntity extends BaseEntity with EquatableMixin {
  final String evseId;
  final EvseStatus status;
  final String connectorType;
  final String powerType;

  EvseEntity({
    required this.evseId,
    required this.status,
    required this.connectorType,
    required this.powerType,
  });

  bool get isAvailable => status == EvseStatus.available;

  @override
  List<Object?> get props => [evseId, status, connectorType, powerType];
}
