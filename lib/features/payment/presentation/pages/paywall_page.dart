import 'package:flutter/material.dart';

class PaywallPage extends StatelessWidget {
  const PaywallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Premium Feature')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This feature is for premium users only.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/payment'),
              child: const Text('Go Premium'),
            ),
          ],
        ),
      ),
    );
  }
}
