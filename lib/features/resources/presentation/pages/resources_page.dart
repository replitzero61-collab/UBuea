import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ub_t/features/resources/presentation/bloc/resource_bloc.dart';
import 'package:ub_t/features/resources/presentation/bloc/resource_event.dart';
import 'package:ub_t/features/resources/presentation/bloc/resource_state.dart';
import 'package:ub_t/features/resources/presentation/widgets/resource_list_item.dart';

class ResourcesPage extends StatefulWidget {
  const ResourcesPage({Key? key}) : super(key: key);

  @override
  State<ResourcesPage> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  String _search = '';
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    // TODO: Replace with actual course code from user context
    context.read<ResourceBloc>().add(const LoadResourcesByCourse('ALL'));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resources')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search resources...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) => setState(() => _search = value),
            ),
          ),
          Expanded(
            child: BlocBuilder<ResourceBloc, ResourceState>(
              builder: (context, state) {
                if (state is ResourceLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ResourcesLoaded) {
                  final filtered = state.resources.where((r) {
                    final q = _search.toLowerCase();
                    return r.title.toLowerCase().contains(q) ||
                        r.courseCode.toLowerCase().contains(q);
                  }).toList();
                  if (filtered.isEmpty) {
                    return const Center(child: Text('No resources found.'));
                  }
                  return ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => Divider(height: 1),
                    itemBuilder: (context, i) {
                      final resource = filtered[i];
                      return ResourceListItem(
                        resource: resource,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/resource-detail',
                            arguments: resource.id,
                          );
                        },
                      );
                    },
                  );
                } else if (state is ResourceError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text('No resources loaded.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
