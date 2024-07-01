import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserAvatarField extends StatelessWidget {
  final void Function(String filePath) onFileSelected;

  const UserAvatarField({super.key, required this.onFileSelected});

  void _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      if (file.size <= 5 * 1024 * 1024) {
        // Max 5MB
        onFileSelected(file.path!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Menambahkan Image')),
        );
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
    return GestureDetector(
      onTap: () => _pickFile(context),
      child: Container(
        padding: const EdgeInsets.all(4), // Border width
        decoration: BoxDecoration(
          color: Colors.grey.shade200, // Border color
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: Icon(CupertinoIcons.camera_fill,
              size: 50, color: Colors.grey.shade500),
        ),
      ),
    );
  }
}
