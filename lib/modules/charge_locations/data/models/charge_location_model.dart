import 'package:voltspot/core/models/base_model.dart';
import 'package:voltspot/modules/charge_locations/domain/entities/charge_location_entity.dart';

class ChargeLocationModel extends BaseModel<ChargeLocationEntity> {
  ChargeLocationModel({
      this.address, 
      this.city, 
      this.country, 
      this.latitude, 
      this.longitude, 
      this.evses,});

  ChargeLocationModel.fromJson(dynamic json) {
    address = json['address'];
    city = json['city'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['evses'] != null) {
      evses = [];
      json['evses'].forEach((v) {
        evses?.add(Evses.fromJson(v));
      });
    }
  }
  String? address;
  String? city;
  String? country;
  num? latitude;
  num? longitude;
  List<Evses>? evses;
ChargeLocationModel copyWith({  String? address,
  String? city,
  String? country,
  num? latitude,
  num? longitude,
  List<Evses>? evses,
}) => ChargeLocationModel(  address: address ?? this.address,
  city: city ?? this.city,
  country: country ?? this.country,
  latitude: latitude ?? this.latitude,
  longitude: longitude ?? this.longitude,
  evses: evses ?? this.evses,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['city'] = city;
    map['country'] = country;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    if (evses != null) {
      map['evses'] = evses?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  ChargeLocationEntity toEntity() {
    return ChargeLocationEntity(address: address ?? '', city: city ?? '', country: country ?? '', latitude: latitude ?? 33, longitude: longitude ?? 33, evses: evses?.map((e) => e.toEntity()).toList() ?? []);
  }

}

class Evses extends BaseModel<EvseEntity>{
  Evses({
      this.evseId, 
      this.status, 
      this.connectorType, 
      this.powerType,});

  Evses.fromJson(dynamic json) {
    evseId = json['evseId'];
    status = json['status'];
    connectorType = json['connectorType'];
    powerType = json['powerType'];
  }
  String? evseId;
  String? status;
  String? connectorType;
  String? powerType;
Evses copyWith({  String? evseId,
  String? status,
  String? connectorType,
  String? powerType,
}) => Evses(  evseId: evseId ?? this.evseId,
  status: status ?? this.status,
  connectorType: connectorType ?? this.connectorType,
  powerType: powerType ?? this.powerType,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['evseId'] = evseId;
    map['status'] = status;
    map['connectorType'] = connectorType;
    map['powerType'] = powerType;
    return map;
  }

  @override
  EvseEntity toEntity() {
    return EvseEntity(evseId: evseId ?? '', status: (status ?? '').toEvseStatus(), connectorType: connectorType ?? '', powerType: powerType ?? '');
  }

}