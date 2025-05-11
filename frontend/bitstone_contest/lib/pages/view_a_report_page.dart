import 'package:bitstone_contest/models/photo_model.dart';
import 'package:flutter/material.dart';

class ViewReport extends StatefulWidget {
  final PhotoModel photo;
  const ViewReport({super.key, required this.photo});

  @override
  State<ViewReport> createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Detail', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 245, 78, 123),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 78, 123),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 1,
                  maxScale: 5,
                  child: Image.network(
                    widget.photo.isProcessed == false
                        ? widget.photo.rawImageUrl
                        : widget.photo.annotatedImageUrl!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    },
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Center(child: Text("Failed to load image")),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.photo.lat != null && widget.photo.lng != null)
                      Text(
                        'Location: ${widget.photo.lat}, ${widget.photo.lng}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    if (widget.photo.postedAt != null)
                      Text(
                        'Uploaded: ${widget.photo.postedAt}',
                        style: const TextStyle(color: Colors.black87),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
