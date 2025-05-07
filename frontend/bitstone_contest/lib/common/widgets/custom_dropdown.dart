import 'package:flutter/material.dart';

class CustomDropdownField extends StatefulWidget {
  final String label;
  final List<String> options;
  final Function(String) onChanged;

  const CustomDropdownField({
    required this.label,
    required this.options,
    required this.onChanged,
  });

  @override
  _CustomDropdownFieldState createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  String? selectedValue;
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            setState(() {
              isDropdownOpen = !isDropdownOpen;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedValue ?? 'Select role',
                  style: TextStyle(fontSize: 16),
                ),
                Icon(
                  isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
              ],
            ),
          ),
        ),
        if (isDropdownOpen)
          Container(
            margin: EdgeInsets.only(top: 0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children:
                  widget.options
                      .asMap()
                      .entries
                      .map(
                        (entry) => Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedValue = entry.value;
                                  isDropdownOpen = false;
                                });
                                widget.onChanged(entry.value);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                child: Text(
                                  entry.value,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            if (entry.key != widget.options.length - 1)
                              Divider(height: 1, color: Colors.grey),
                          ],
                        ),
                      )
                      .toList(),
            ),
          ),
      ],
    );
  }
}
