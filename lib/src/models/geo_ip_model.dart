// To parse this JSON data, do
//
//     final geoIpModel = geoIpModelFromJson(jsonString);

import 'dart:convert';

GeoIpModel geoIpModelFromJson(String str) =>
    GeoIpModel.fromJson(json.decode(str));

String geoIpModelToJson(GeoIpModel data) => json.encode(data.toJson());

class GeoIpModel {
  String? ip;
  String? type;
  Country? country;
  Location? location;
  Asn? asn;

  GeoIpModel({this.ip, this.type, this.country, this.location, this.asn});

  factory GeoIpModel.fromJson(Map<String, dynamic> json) => GeoIpModel(
        ip: json["ip"],
        type: json["type"],
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        asn: json["asn"] == null ? null : Asn.fromJson(json["asn"]),
      );

  Map<String, dynamic> toJson() => {
        "ip": ip,
        "type": type,
        "country": country?.toJson(),
        "location": location?.toJson(),
        "asn": asn?.toJson(),
      };
}

class Asn {
  int? number;
  String? name;
  String? network;
  String? type;

  Asn({this.number, this.name, this.network, this.type});

  factory Asn.fromJson(Map<String, dynamic> json) => Asn(
        number: json["number"],
        name: json["name"],
        network: json["network"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "network": network,
        "type": type,
      };
}

class Country {
  bool? isEuMember;
  String? currencyCode;
  String? continent;
  String? name;
  String? countryCode;
  String? state;
  String? city;
  dynamic zip;
  String? timezone;

  Country({
    this.isEuMember,
    this.currencyCode,
    this.continent,
    this.name,
    this.countryCode,
    this.state,
    this.city,
    this.zip,
    this.timezone,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        isEuMember: json["is_eu_member"],
        currencyCode: json["currency_code"],
        continent: json["continent"],
        name: json["name"],
        countryCode: json["country_code"],
        state: json["state"],
        city: json["city"],
        zip: json["zip"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "is_eu_member": isEuMember,
        "currency_code": currencyCode,
        "continent": continent,
        "name": name,
        "country_code": countryCode,
        "state": state,
        "city": city,
        "zip": zip,
        "timezone": timezone,
      };
}

class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
