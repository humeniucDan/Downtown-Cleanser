import 'package:bitstone_contest/models/photo_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ImageHistoryCard extends StatefulWidget {
  final PhotoModel image;
  const ImageHistoryCard({super.key, required this.image});

  @override
  State<ImageHistoryCard> createState() => _ImageHistoryCardState();
}

class _ImageHistoryCardState extends State<ImageHistoryCard> {
  @override
  Widget build(BuildContext context) {
    String formattedDate =
        widget.image.postedAt != null
            ? DateFormat('yyyy-MM-dd').format(widget.image.postedAt!)
            : 'NA';
    bool isResolved = widget.image.isProcessed;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Posted at: $formattedDate"),
          Text("Status:"),
          isResolved ? Text("Resolved") : Text("Not Resolved"),
        ],
      ),
    );
  }
}
