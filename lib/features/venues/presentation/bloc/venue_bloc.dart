import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ub_t/core/common/entities/venue.dart';
import '../../domain/usecases/get_all_venues.dart';

part 'venue_event.dart';
part 'venue_state.dart';

class VenueBloc extends Bloc<VenueEvent, VenueState> {
  final GetAllVenues getAllVenues;
  VenueBloc(this.getAllVenues) : super(VenueInitial()) {
    on<LoadVenues>((event, emit) async {
      emit(VenueLoading());
      try {
        final venues = await getAllVenues();
        emit(VenueLoaded(venues));
      } catch (e) {
        emit(VenueError('Failed to load venues'));
      }
    });
  }
}
