import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
// UploadImageField

class UploadImageField extends StatefulWidget {
  const UploadImageField({super.key, required this.onFileSelected});

  final void Function(String filePath) onFileSelected;

  @override
  State<UploadImageField> createState() => _UploadImageFieldState();
}

class _UploadImageFieldState extends State<UploadImageField> {
  String? _fileName; // Variabel untuk menyimpan nama file
  File? _selectedFile; // Variabel untuk menyimpan data file path

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      if (file.size <= 5 * 1024 * 1024) {
        // Max 5MB
        setState(() {
          _fileName = file.name; // Set nama file untuk ditampilkan di UI
          _selectedFile =
              File(file.path!); // Simpan file path dalam variabel _selectedFile
        });
        widget.onFileSelected(
            file.path!); // Pass the actual file path to the callback
      } else {
        // Show error message if file size exceeds 5MB
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File size exceeds 5MB')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Background Foto',
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
                      'Click to upload', // Tampilkan nama file atau prompt untuk upload
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'JPEG, JPG or PNG (max 5MB)',
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
