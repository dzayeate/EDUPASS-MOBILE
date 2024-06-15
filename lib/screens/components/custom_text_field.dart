import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool alignLabelWithHint;
  final int maxLines;
  final bool readOnly;

  // ignore: use_super_parameters
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.alignLabelWithHint = false,
    this.maxLines = 1,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        alignLabelWithHint: alignLabelWithHint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo, width: 2.0),
        ),
      ),
      maxLines: maxLines,
      readOnly: readOnly,
    );
  }
}
