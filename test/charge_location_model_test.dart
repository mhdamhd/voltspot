import 'package:flutter_test/flutter_test.dart';
import 'package:voltspot/modules/charge_locations/data/models/charge_location_model.dart';
import 'package:voltspot/modules/charge_locations/domain/entities/charge_location_entity.dart';

void main() {
  group('ChargeLocationModel.toEntity', () {
    test('maps full JSON including nested EVSEs', () {
      final json = {
        "address": "Dam Square 1",
        "city": "Amsterdam",
        "country": "NL",
        "latitude": 52.3731,
        "longitude": 4.8922,
        "evses": [
          {"evseId": "NL*ABC*1", "status": "AVAILABLE", "connectorType": "CCS", "powerType": "DC"},
          {"evseId": "NL*ABC*2", "status": "OCCUPIED", "connectorType": "Type2", "powerType": "AC"},
          {"evseId": "NL*ABC*3", "status": "UNKNOWN", "connectorType": "CHAdeMO", "powerType": "DC"},
        ]
      };

      final model = ChargeLocationModel.fromJson(json);
      final entity = model.toEntity();

      expect(entity.address, "Dam Square 1");
      expect(entity.city, "Amsterdam");
      expect(entity.country, "NL");
      expect(entity.latitude, 52.3731);
      expect(entity.longitude, 4.8922);
      expect(entity.evses.length, 3);

      expect(entity.evses[0].evseId, "NL*ABC*1");
      expect(entity.evses[0].status, EvseStatus.available);
      expect(entity.evses[1].status, EvseStatus.unavailable); // OCCUPIED -> unavailable
      expect(entity.evses[2].status, EvseStatus.unknown);     // fallback
    });

    test('applies defaults on null fields', () {
      final json = {
        // address/city/country missing -> should fall back to ''
        // lat/long missing -> defaults you coded: 33/33
        "evses": []
      };

      final model = ChargeLocationModel.fromJson(json);
      final entity = model.toEntity();

      expect(entity.address, '');
      expect(entity.city, '');
      expect(entity.country, '');
      expect(entity.latitude, 33);   // ⚠ consider changing these defaults later
      expect(entity.longitude, 33);
      expect(entity.evses, isEmpty);
    });
  });

  group('Evses.toEntity', () {
    test('maps status string to enum', () {
      expect(Evses(status: 'AVAILABLE').toEntity().status, EvseStatus.available);
      expect(Evses(status: 'occupied').toEntity().status, EvseStatus.unavailable);
      expect(Evses(status: 'weird').toEntity().status, EvseStatus.unknown);
    });

    test('maps fields and applies empty defaults', () {
      final e = Evses(evseId: 'X', connectorType: null, powerType: null).toEntity();
      expect(e.evseId, 'X');
      expect(e.connectorType, '');
      expect(e.powerType, '');
    });
  });
}
