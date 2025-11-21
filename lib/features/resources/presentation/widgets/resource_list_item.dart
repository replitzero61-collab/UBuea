import 'package:flutter/material.dart';
import 'package:ub_t/core/common/entities/resource.dart';

class ResourceListItem extends StatelessWidget {
  final Resource resource;
  final VoidCallback? onTap;
  const ResourceListItem({Key? key, required this.resource, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        resource.type == 'pdf' ? Icons.picture_as_pdf : Icons.insert_drive_file,
      ),
      title: Text(resource.title),
      subtitle: Text('${resource.courseCode} • ${resource.fileSizeFormatted}'),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
