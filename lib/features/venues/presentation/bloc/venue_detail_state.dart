import 'package:equatable/equatable.dart';
import 'package:ub_t/core/common/entities/venue.dart';

abstract class VenueDetailState extends Equatable {
  const VenueDetailState();
  @override
  List<Object?> get props => [];
}

class VenueDetailInitial extends VenueDetailState {}

class VenueDetailLoading extends VenueDetailState {}

class VenueDetailLoaded extends VenueDetailState {
  final Venue venue;
  const VenueDetailLoaded(this.venue);
  @override
  List<Object?> get props => [venue];
}

class VenueDetailError extends VenueDetailState {
  final String message;
  const VenueDetailError(this.message);
  @override
  List<Object?> get props => [message];
}
