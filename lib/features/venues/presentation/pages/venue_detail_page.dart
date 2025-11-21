import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/venue_detail_bloc.dart';
import '../bloc/venue_detail_event.dart';
import '../bloc/venue_detail_state.dart';

class VenueDetailPage extends StatelessWidget {
  final String venueId;
  const VenueDetailPage({Key? key, required this.venueId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VenueDetailBloc>(
      create: (context) => VenueDetailBloc(
        // TODO: Inject GetVenueById use case here
        throw UnimplementedError('Provide GetVenueById use case'),
      )..add(LoadVenueDetail(venueId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Venue Details')),
        body: BlocBuilder<VenueDetailBloc, VenueDetailState>(
          builder: (context, state) {
            if (state is VenueDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is VenueDetailLoaded) {
              final venue = state.venue;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    venue.imageUrl != null && venue.imageUrl!.isNotEmpty
                        ? Image.network(
                            venue.imageUrl!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => Container(
                              height: 200,
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.image, size: 100),
                              ),
                            ),
                          )
                        : Container(
                            height: 200,
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.image, size: 100),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        venue.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        [
                          venue.building,
                          venue.floor,
                        ].where((e) => e != null && e.isNotEmpty).join(', '),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(venue.description ?? 'No description.'),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Courses held here:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // TODO: Replace with real courses list for this venue
                  ],
                ),
              );
            } else if (state is VenueDetailError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
