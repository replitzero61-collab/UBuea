import 'package:ub_t/core/common/entities/venue.dart';
import '../repository/venue_repository.dart';

class GetAllVenues {
  final VenueRepository repository;
  GetAllVenues(this.repository);

  Future<List<Venue>> call() async {
    return await repository.getAllVenues();
  }
}
