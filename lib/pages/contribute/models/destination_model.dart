// To parse this JSON data, do
//
//     final destination = destinationFromJson(jsonString);

import 'dart:convert';

Destination destinationFromJson(String str) =>
    Destination.fromJson(json.decode(str));

String destinationToJson(Destination data) => json.encode(data.toJson());

class Destination {
  int id;
  String name;
  List<String> images;
  String location;
  double rating;
  bool starred;
  String? description;
  String? altitude;
  bool? hasDeathZone;
  String? firstClimber;
  String? firstClimbedDate;
  String? countryFlagImg;

  Destination({
    required this.id,
    required this.name,
    required this.images,
    required this.location,
    required this.rating,
    required this.starred,
    this.description,
    this.altitude,
    this.hasDeathZone,
    this.firstClimber,
    this.firstClimbedDate,
    this.countryFlagImg,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        id: json["id"],
        name: json["name"],
        images: List<String>.from(json["images"].map((x) => x)),
        location: json["location"],
        rating: json["rating"]?.toDouble(),
        starred: json["starred"],
        description: json["description"],
        altitude: json["altitude"],
        hasDeathZone: json["has_death_zone"],
        firstClimber: json["first_climber"],
        firstClimbedDate: json["first_climbed_date"],
        countryFlagImg: json["country_flag_img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "images": List<dynamic>.from(images.map((x) => x)),
        "location": location,
        "rating": rating,
        "starred": starred,
        "description": description,
        "altitude": altitude,
        "has_death_zone": hasDeathZone,
        "first_climber": firstClimber,
        "first_climbed_date": firstClimbedDate,
        "country_flag_img": countryFlagImg,
      };
}
