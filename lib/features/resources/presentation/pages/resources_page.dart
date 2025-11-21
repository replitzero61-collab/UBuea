import 'package:flutter/material.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Connect to ResourceBloc and display real data
    return Scaffold(
      appBar: AppBar(title: const Text('Resources')),
      body: Center(child: Text('Resources list will appear here.')),
    );
  }
}
