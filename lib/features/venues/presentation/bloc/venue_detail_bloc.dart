import 'package:flutter_bloc/flutter_bloc.dart';
import 'venue_detail_event.dart';
import 'venue_detail_state.dart';
import '../../domain/usecases/get_venue_by_id.dart';

class VenueDetailBloc extends Bloc<VenueDetailEvent, VenueDetailState> {
  final GetVenueById getVenueById;
  VenueDetailBloc(this.getVenueById) : super(VenueDetailInitial()) {
    on<LoadVenueDetail>((event, emit) async {
      emit(VenueDetailLoading());
      try {
        final venue = await getVenueById(event.venueId);
        emit(VenueDetailLoaded(venue));
      } catch (e) {
        emit(VenueDetailError('Failed to load venue details'));
      }
    });
  }
}
