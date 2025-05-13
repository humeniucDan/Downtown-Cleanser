import 'package:bitstone_contest/models/photo_model.dart';
import 'package:bitstone_contest/pages/view_a_report_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ImageHistoryCard extends StatefulWidget {
  final PhotoModel image;
  const ImageHistoryCard({super.key, required this.image});

  @override
  State<ImageHistoryCard> createState() => _ImageHistoryCardState();
}

class _ImageHistoryCardState extends State<ImageHistoryCard> {
  Color textColor = Color.fromARGB(255, 245, 78, 123);
  @override
  Widget build(BuildContext context) {
    String formattedDate =
        widget.image.postedAt != null
            ? DateFormat('yyyy-MM-dd').format(widget.image.postedAt!)
            : 'NA';
    bool isResolved = widget.image.isProcessed;
    int numberOfProblems = widget.image.detections.length;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Report number: ${widget.image.id}",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Posted at: $formattedDate",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Problems found: $numberOfProblems",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewReport(photo: widget.image),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: textColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  "View Report",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
