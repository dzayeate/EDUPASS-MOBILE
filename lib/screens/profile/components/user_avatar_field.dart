import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as img;

class UserAvatarField extends StatelessWidget {
  final void Function(String filePath) onFileSelected;
  final String? imagePath;

  const UserAvatarField(
      {super.key, required this.onFileSelected, this.imagePath});

  void _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      if (file.size <= 5 * 1024 * 1024) {
        // Membaca data file ke dalam byte array
        final imageBytes = File(file.path!).readAsBytesSync();
        // Mendecode gambar untuk mendapatkan dimensi
        final image = img.decodeImage(imageBytes);

        if (image != null && image.width == 300 && image.height == 300) {
          // Jika ukuran sesuai, panggil callback dan tampilkan pesan sukses
          onFileSelected(file.path!);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Berhasil Menambahkan Image')),
          );
        } else {
          // Jika ukuran tidak sesuai, tampilkan pesan kesalahan
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Image harus berukuran 300x300 pixels')),
          );
        }
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
          backgroundImage: imagePath != null && imagePath!.isNotEmpty
              ? (imagePath!.startsWith('http')
                  ? NetworkImage(imagePath!)
                  : FileImage(File(imagePath!))) as ImageProvider
              : null,
          child: imagePath == null || imagePath!.isEmpty
              ? Icon(CupertinoIcons.camera_fill,
                  size: 50, color: Colors.grey.shade500)
              : null,
        ),
      ),
    );
  }
}
