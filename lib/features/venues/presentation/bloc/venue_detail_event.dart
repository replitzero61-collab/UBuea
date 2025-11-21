import 'package:equatable/equatable.dart';

abstract class VenueDetailEvent extends Equatable {
  const VenueDetailEvent();
  @override
  List<Object?> get props => [];
}

class LoadVenueDetail extends VenueDetailEvent {
  final String venueId;
  const LoadVenueDetail(this.venueId);
  @override
  List<Object?> get props => [venueId];
}
