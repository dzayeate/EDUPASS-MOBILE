import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final bool alignLabelWithHint;
  final int maxLines;
  final bool readOnly;
  final bool enabled;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final double borderRadius;

  const CustomTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.alignLabelWithHint = false,
    this.maxLines = 1,
    this.readOnly = false,
    this.enabled = true,
    this.textStyle,
    this.labelStyle,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Text(
            labelText!,
            style: labelStyle ??
                GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: TextField(
            controller: controller,
            enabled: enabled,
            readOnly: readOnly,
            maxLines: maxLines,
            style: textStyle ?? const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: alignLabelWithHint ? labelText : null,
              hintText: hintText,
              alignLabelWithHint: alignLabelWithHint,
              filled: true,
              fillColor:
                  Colors.transparent, // Transparent to see container color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.grey.shade100),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.indigo, width: 2.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }
}


// Old Version

// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final String labelText;
//   final String hintText;
//   final bool alignLabelWithHint;
//   final int maxLines;
//   final bool readOnly;
//   final TextEditingController? controller;

//   const CustomTextField({
//     super.key,
//     required this.labelText,
//     required this.hintText,
//     this.controller,
//     this.alignLabelWithHint = false,
//     this.maxLines = 1,
//     this.readOnly = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: labelText,
//         hintText: hintText,
//         alignLabelWithHint: alignLabelWithHint,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         focusedBorder: const OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.indigo, width: 2.0),
//         ),
//       ),
//       maxLines: maxLines,
//       readOnly: readOnly,
//     );
//   }
// }
