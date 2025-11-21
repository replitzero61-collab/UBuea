import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ub_t/features/resources/presentation/bloc/resource_bloc.dart';
import 'package:ub_t/features/resources/presentation/bloc/resource_event.dart';
import 'package:ub_t/features/resources/presentation/bloc/resource_state.dart';
import 'package:ub_t/features/resources/presentation/widgets/resource_download_button.dart';
import 'package:ub_t/core/common/entities/resource.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:ub_t/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:ub_t/features/payment/presentation/bloc/payment_event.dart';
import 'package:ub_t/features/payment/presentation/bloc/payment_state.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class ResourceDetailPage extends StatefulWidget {
  final String resourceId;
  const ResourceDetailPage({Key? key, required this.resourceId})
    : super(key: key);

  @override
  State<ResourceDetailPage> createState() => _ResourceDetailPageState();
}

class _ResourceDetailPageState extends State<ResourceDetailPage> {
  String? _localPdfPath;
  bool _downloading = false;

  @override
  void initState() {
    super.initState();
    context.read<ResourceBloc>().add(LoadResourceById(widget.resourceId));
    // Check premium status on open
    context.read<PaymentBloc>().add(CheckPremiumStatusEvent());
  }

  Future<void> _downloadAndOpenPdf(String url) async {
    setState(() => _downloading = true);
    try {
      final response = await http.get(Uri.parse(url));
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/resource_${widget.resourceId}.pdf');
      await file.writeAsBytes(response.bodyBytes);
      setState(() => _localPdfPath = file.path);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to open PDF: $e')));
    } finally {
      setState(() => _downloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resource Detail')),
      body: BlocBuilder<ResourceBloc, ResourceState>(
        builder: (context, state) {
          if (state is ResourceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ResourceLoaded) {
            final Resource resource = state.resource;
            return BlocBuilder<PaymentBloc, PaymentState>(
              builder: (context, paymentState) {
                if (paymentState is PaymentLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (paymentState is NotPremiumUser) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('This resource is for premium users.'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/paywall'),
                          child: const Text('Go Premium'),
                        ),
                      ],
                    ),
                  );
                }
                // PremiumUser or unknown (default to allow)
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resource.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text('Course: ${resource.courseCode}'),
                      Text('Type: ${resource.type}'),
                      Text('Uploaded: ${resource.uploadedAt.toLocal()}'),
                      Text('Size: ${resource.fileSizeFormatted}'),
                      const SizedBox(height: 16),
                      ResourceDownloadButton(
                        fileUrl: resource.fileUrl,
                        fileName: resource.title,
                      ),
                      if (resource.type == 'pdf') ...[
                        const SizedBox(height: 16),
                        _localPdfPath == null
                            ? ElevatedButton.icon(
                                icon: _downloading
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Icon(Icons.picture_as_pdf),
                                label: Text(
                                  _downloading ? 'Opening...' : 'Open PDF',
                                ),
                                onPressed: _downloading
                                    ? null
                                    : () =>
                                          _downloadAndOpenPdf(resource.fileUrl),
                              )
                            : Expanded(
                                child: PDFView(filePath: _localPdfPath!),
                              ),
                      ],
                    ],
                  ),
                );
              },
            );
          } else if (state is ResourceError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Resource not found.'));
        },
      ),
    );
  }
}
