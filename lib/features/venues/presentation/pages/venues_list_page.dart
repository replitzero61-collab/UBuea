import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/venue_bloc.dart';
import 'venue_detail_page.dart';

class VenuesListPage extends StatefulWidget {
  const VenuesListPage({Key? key}) : super(key: key);

  @override
  State<VenuesListPage> createState() => _VenuesListPageState();
}

class _VenuesListPageState extends State<VenuesListPage> {
  String _search = '';

  @override
  void initState() {
    super.initState();
    // Add LoadVenues event after first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VenueBloc>().add(LoadVenues());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VenueBloc>(
      create: (context) => VenueBloc(
        // TODO: Inject GetAllVenues use case here
        // Example: RepositoryProvider.of<GetAllVenues>(context)
        // For now, throw UnimplementedError
        throw UnimplementedError('Provide GetAllVenues use case'),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Venues')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search venues...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) => setState(() => _search = val.trim()),
              ),
            ),
            Expanded(
              child: BlocBuilder<VenueBloc, VenueState>(
                builder: (context, state) {
                  if (state is VenueLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is VenueLoaded) {
                    final venues = state.venues
                        .where(
                          (v) => v.name.toLowerCase().contains(
                            _search.toLowerCase(),
                          ),
                        )
                        .toList();
                    if (venues.isEmpty) {
                      return const Center(child: Text('No venues found.'));
                    }
                    return ListView.builder(
                      itemCount: venues.length,
                      itemBuilder: (context, index) {
                        final venue = venues[index];
                        return ListTile(
                          leading:
                              venue.imageUrl != null &&
                                  venue.imageUrl!.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    venue.imageUrl!,
                                    width: 48,
                                    height: 48,
                                    fit: BoxFit.cover,
                                    errorBuilder: (c, e, s) =>
                                        const Icon(Icons.image),
                                  ),
                                )
                              : const Icon(Icons.location_on),
                          title: Text(venue.name),
                          subtitle: Text(
                            [venue.building, venue.floor]
                                .where((e) => e != null && e.isNotEmpty)
                                .join(', '),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    VenueDetailPage(venueId: venue.name),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is VenueError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
