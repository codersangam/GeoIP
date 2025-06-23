import 'package:flutter_test/flutter_test.dart';
import 'package:geoip/geoip.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  group('GeoIP API Tests', () {
    test('returns GeoIpModel when status is 200', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          json.encode({
            "ip": "8.8.8.8",
            "type": "IPv4",
            "country": {
              "is_eu_member": false,
              "currency_code": "USD",
              "continent": "North America",
              "name": "United States",
              "country_code": "US",
              "state": "California",
              "city": "Mountain View",
              "zip": "94043",
              "timezone": "America/Los_Angeles",
            },
            "location": {"latitude": 37.386, "longitude": -122.0838},
            "asn": {
              "number": 15169,
              "name": "Google LLC",
              "network": "8.8.8.0/24",
              "type": "Business",
            },
          }),
          200,
        );
      });

      final result = await GeoIpAPI.getData(client: mockClient);

      expect(result.ip, "8.8.8.8");
      expect(result.country?.name, "United States");
      expect(result.location?.latitude, 37.386);
    });

    test('returns empty model when status is not 200', () async {
      final mockClient = MockClient((request) async {
        return http.Response("Not Found", 404);
      });

      final result = await GeoIpAPI.getData(client: mockClient);

      expect(result.ip, isNull);
    });
  });
}
