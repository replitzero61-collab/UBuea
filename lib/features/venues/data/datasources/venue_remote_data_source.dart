import 'package:ub_t/core/common/entities/venue.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class VenueRemoteDataSource {
  Future<List<Venue>> getAllVenues();
  Future<Venue> getVenueById(String id);
}

class VenueRemoteDataSourceImpl implements VenueRemoteDataSource {
  final _client = Supabase.instance.client;

  @override
  Future<List<Venue>> getAllVenues() async {
    final data = await _client.from('venues').select();
    final list = data as List<dynamic>;
    return list
        .map(
          (json) => Venue(
            name: json['name'],
            description: json['description'],
            imageUrl: json['image_url'],
            building: json['building'],
            floor: json['floor'],
            courses: (json['courses'] as List?)?.cast<String>(),
          ),
        )
        .toList();
  }

  @override
  Future<Venue> getVenueById(String id) async {
    final result = await _client
        .from('venues')
        .select()
        .eq('name', id)
        .maybeSingle();
    if (result == null) {
      throw Exception('Venue not found');
    }
    final json = result as Map<String, dynamic>;
    return Venue(
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
      building: json['building'],
      floor: json['floor'],
      courses: (json['courses'] as List?)?.cast<String>(),
    );
  }
}
