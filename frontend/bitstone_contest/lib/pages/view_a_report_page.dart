import 'package:bitstone_contest/common/widgets/detection_card.dart';
import 'package:bitstone_contest/models/photo_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ViewReport extends StatefulWidget {
  final PhotoModel photo;
  const ViewReport({super.key, required this.photo});

  @override
  State<ViewReport> createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _descriptionKey = GlobalKey();

  void _scrollToDescription() {
    Scrollable.ensureVisible(
      _descriptionKey.currentContext!,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      'yyyy-MM-dd – kk:mm',
    ).format(widget.photo.postedAt);

    int numberOfDetections = widget.photo.detections.length;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 254, 55, 108),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 32),
            child: Image.asset("assets/logo-500x500.png", height: 200),
          ),
        ),
        elevation: 2,
      ),
      backgroundColor: const Color.fromARGB(255, 245, 78, 123),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Report # ${widget.photo.id}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 6.0,
                      right: 6.0,
                      top: 8.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      widget.photo.isProcessed == false
                          ? "Thanks for sending the report. Your image will be processed shortly. Thanks for saving the city!"
                          : "Thanks for sending the report. Your image has been processed and you can see the information right now. Thanks for saving the city!",
                      style: TextStyle(
                        color: Color.fromARGB(255, 245, 78, 123),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
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
              ),
              Container(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Additional report data:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (widget.photo.lat != null && widget.photo.lng != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Color.fromARGB(255, 245, 78, 123),
                              ),
                              Text(
                                'Location: ${widget.photo.lat.toStringAsFixed(2)}, ${widget.photo.lng.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 245, 78, 123),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (widget.photo.postedAt != null)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.av_timer_rounded,
                              color: Color.fromARGB(255, 245, 78, 123),
                            ),
                            Text(
                              'Uploaded: ${formattedDate}',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 245, 78, 123),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              Center(
                child:
                    widget.photo.isProcessed
                        ? Column(
                          children: [
                            Text(
                              "See report details:",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_downward,
                                size: 36,
                                color: Colors.white,
                              ),
                              onPressed: _scrollToDescription,
                            ),
                          ],
                        )
                        : Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Waiting to process ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              LoadingAnimationWidget.bouncingBall(
                                color: Colors.white,
                                size: 22,
                              ),
                            ],
                          ),
                        ),
              ),

              if (widget.photo.isProcessed)
                Container(
                  key: _descriptionKey,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 8,
                    ),
                    child: Text(
                      numberOfDetections == 1
                          ? "Your photo has been processed and we have found $numberOfDetections problem."
                          : "Your photo has been processed and we have found $numberOfDetections problems.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 245, 78, 123),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

              SizedBox(height: 12), // optional spacing between sections
              // Separate section for the detection cards
              Column(
                children:
                    widget.photo.detections
                        .map((detection) => DetectionCard(detection: detection))
                        .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
