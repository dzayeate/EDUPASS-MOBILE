import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomUploadFile extends StatelessWidget {
  final String hintText;

  const CustomUploadFile({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            // Add file picker functionality here
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  hintText,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.file_open, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
