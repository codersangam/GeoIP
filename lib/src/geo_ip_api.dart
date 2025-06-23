import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/geo_ip_model.dart';

enum GeoIpDataType { ipOnly, fullJson }

class GeoIpAPI {
  /// Get the geolocation data for the current user.
  ///
  /// By default, the full JSON response is returned. If [endpoint] is set to
  /// [GeoIpDataType.ipOnly], only the IP address is returned.
  ///
  /// Optional [client] can be used to customize the HTTP request.
  static Future<GeoIpModel> getData({
    GeoIpDataType endpoint = GeoIpDataType.fullJson,
    http.Client? client,
  }) async {
    client ??= http.Client();
    final url = _getGeoIpUrl(endpoint);

    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        if (endpoint == GeoIpDataType.ipOnly) {
          return GeoIpModel(ip: response.body.replaceAll('"', ''));
        } else {
          return geoIpModelFromJson(response.body);
        }
      }
      debugPrint("geolocation api ${response.statusCode}");
      return GeoIpModel();
    } catch (e) {
      debugPrint(e.toString());
      return GeoIpModel();
    }
  }

  /// Returns the appropriate URL for the given [GeoIpDataType].
  ///
  /// Currently, `GeoIpDataType.ipOnly` returns the root URL, and
  /// `GeoIpDataType.fullJson` returns the URL with the `/json` path.
  ///
  /// This function is not intended to be used outside of this library.
  static String _getGeoIpUrl(GeoIpDataType endpoint) {
    switch (endpoint) {
      case GeoIpDataType.ipOnly:
        return 'https://api.geoipapi.com';
      case GeoIpDataType.fullJson:
        return 'https://api.geoipapi.com/json';
    }
  }
}
