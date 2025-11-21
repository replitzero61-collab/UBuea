import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceDownloadButton extends StatelessWidget {
  final String fileUrl;
  final String? fileName;
  const ResourceDownloadButton({Key? key, required this.fileUrl, this.fileName})
    : super(key: key);

  Future<void> _downloadFile(BuildContext context) async {
    final uri = Uri.parse(fileUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch file URL.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.download),
      label: Text(fileName ?? 'Download'),
      onPressed: () => _downloadFile(context),
    );
  }
}
