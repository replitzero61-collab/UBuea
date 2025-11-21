import 'package:ub_t/core/common/entities/venue.dart';

class VenueModel extends Venue {
  const VenueModel({
    required super.name,
    super.description,
    super.imageUrl,
    super.building,
    super.floor,
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      name: json['name'] ?? '',
      description: json['description'],
      imageUrl: json['image_url'],
      building: json['building'],
      floor: json['floor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'building': building,
      'floor': floor,
    };
  }

  Venue toEntity() {
    return Venue(
      name: name,
      description: description,
      imageUrl: imageUrl,
      building: building,
      floor: floor,
    );
  }
}
