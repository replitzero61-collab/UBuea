import 'package:ub_t/core/common/entities/venue.dart';
import '../../domain/repository/venue_repository.dart';
import '../datasources/venue_remote_data_source.dart';

class VenueRepositoryImpl implements VenueRepository {
  final VenueRemoteDataSource remoteDataSource;
  VenueRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Venue>> getAllVenues() async {
    return await remoteDataSource.getAllVenues();
  }

  @override
  Future<Venue> getVenueById(String id) async {
    return await remoteDataSource.getVenueById(id);
  }
}
