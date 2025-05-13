import 'package:bitstone_contest/models/detection_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetectionCard extends StatelessWidget {
  final DetectionModel detection;
  const DetectionCard({super.key, required this.detection});

  String formatDetectionName(String input) {
    final parts = input.split('_');
    if (parts.isEmpty) return input;
    final capitalized = parts.first[0].toUpperCase() + parts.first.substring(1);
    final rest = parts.skip(1).join(' ');
    return '$capitalized $rest';
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = "";
    if (detection.resolvedAt != null) {
      formattedDate = DateFormat(
        'yyyy-MM-dd – kk:mm',
      ).format(detection.resolvedAt!);
    } else {
      formattedDate = "";
    }

    final originalName = detection.className;
    final refactoredName = formatDetectionName(detection.className);
    Color textColor = Color.fromARGB(255, 245, 78, 123);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Found problem:",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text("$refactoredName", style: TextStyle(color: textColor)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Status:",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    detection.isResolved != null
                        ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.greenAccent,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Solved"),
                          ),
                        )
                        : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Not Solved"),
                          ),
                        ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Resolved at:",
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    detection.resolvedAt != null
                        ? Text("$formattedDate")
                        : Text("Not solved"),
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
