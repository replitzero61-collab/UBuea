import 'package:flutter/material.dart';

class ClashWarningWidget extends StatelessWidget {
  final bool show;
  final String? message;

  const ClashWarningWidget({Key? key, this.show = false, this.message})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      color: Colors.red[100],
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message ?? 'Warning: Some selected courses have a time clash.',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
