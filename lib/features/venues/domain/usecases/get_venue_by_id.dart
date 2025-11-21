import 'package:ub_t/core/common/entities/venue.dart';
import '../repository/venue_repository.dart';

class GetVenueById {
  final VenueRepository repository;
  GetVenueById(this.repository);

  Future<Venue> call(String id) async {
    return await repository.getVenueById(id);
  }
}
