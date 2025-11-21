import 'package:ub_t/core/common/entities/venue.dart';

abstract class VenueRepository {
  Future<List<Venue>> getAllVenues();
  Future<Venue> getVenueById(String id);
}
