import 'package:flutter/material.dart';

class ResourceDetailPage extends StatelessWidget {
  final String resourceId;
  const ResourceDetailPage({Key? key, required this.resourceId})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Connect to ResourceBloc and display real resource details
    return Scaffold(
      appBar: AppBar(title: const Text('Resource Detail')),
      body: Center(
        child: Text('Resource details for $resourceId will appear here.'),
      ),
    );
  }
}
