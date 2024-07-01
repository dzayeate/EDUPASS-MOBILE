import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownField extends StatefulWidget {
  final String label;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final TextEditingController? controller;

  const DropdownField(
      {super.key,
      required this.label,
      required this.items,
      this.onChanged,
      this.controller});

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                hint: Text(
                  widget.label,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                value: selectedValue,
                items: widget.items
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item,
                              style: GoogleFonts.poppins(fontSize: 14)),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                  if (widget.controller != null) {
                    widget.controller!.text = value ?? '';
                  }
                  if (widget.onChanged != null) {
                    widget.onChanged!(value);
                  }
                }),
          ),
        ),
      ],
    );
  }
}
