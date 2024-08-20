import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as img; // Import the image package

class UploadFileField extends StatefulWidget {
  const UploadFileField({
    super.key,
    required this.onFileSelected,
    this.initialFileName,
    required this.allowedExtensions, // Add allowedExtensions parameter
  });

  final void Function(String filePath) onFileSelected;
  final String? initialFileName; // Optional initial file name
  final List<String> allowedExtensions; // Allowed file extensions

  @override
  State<UploadFileField> createState() => _UploadFileFieldState();
}

class _UploadFileFieldState extends State<UploadFileField> {
  String? _fileName; // Variable to store the file name
  File? _selectedFile; // Variable to store the file data path

  @override
  void initState() {
    super.initState();
    _fileName = widget.initialFileName; // Set the initial file name
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: widget.allowedExtensions, // Use dynamic extensions
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;

      if (file.size > 5 * 1024 * 1024) {
        // Max 5MB
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File size exceeds 5MB')),
        );
        return;
      }

      final filePath = file.path!;
      final fileExtension = file.extension?.toLowerCase();

      if (fileExtension == 'jpg' ||
          fileExtension == 'jpeg' ||
          fileExtension == 'png') {
        // Check image dimensions only for image files
        final imageBytes = await File(filePath).readAsBytes();
        final image = img.decodeImage(imageBytes);

        if (image == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unable to process image')),
          );
          return;
        }

        // Additional checks for image (if needed)
        // if (image.width != 300 || image.height != 300) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Image must be 300x300 pixels')),
        //   );
        //   return;
        // }
      } else if (fileExtension == 'pdf') {
        // Additional checks for PDF (if needed)
      }

      setState(() {
        _fileName = file.name; // Set file name for display in the UI
        _selectedFile =
            File(filePath); // Save file path in _selectedFile variable
      });
      widget.onFileSelected(
          filePath); // Pass the actual file path to the callback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dokumen Pendukung',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickFile,
          child: Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade600),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cloud_upload, size: 32, color: Colors.indigo),
                const SizedBox(height: 8),
                Text(
                  _fileName ??
                      'Click to upload', // Display file name or upload prompt
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Format File : ${widget.allowedExtensions.join(', ').toUpperCase()} (max 5MB)',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
