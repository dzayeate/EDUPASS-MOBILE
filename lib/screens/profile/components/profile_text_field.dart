import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool enabled;

  const ProfileTextField({
    super.key,
    required this.label,
    required this.placeholder,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          enabled: enabled,
          decoration: InputDecoration(
            hintText: placeholder,
            filled: !enabled,
            fillColor: enabled ? Colors.white : Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
