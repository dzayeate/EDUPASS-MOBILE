import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDateField extends StatefulWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final bool enabled;

  const CustomDateField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.controller,
    this.enabled = true,
  });

  @override
  _CustomDateFieldState createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: widget.controller,
            enabled: widget.enabled,
            readOnly: true,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: widget.placeholder,
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.shade100,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
            onTap: () async {
              if (widget.enabled) {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    widget.controller.text = formattedDate;
                  });
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
