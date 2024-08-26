import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class CertificationScreen extends StatelessWidget {
  final String imagePath = 'assets/images/certificate.png';

  const CertificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Licenses & Certifications",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Placeholder',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // handle filter action
                  },
                  icon: const Icon(Icons.tune, color: Colors.black),
                  label: const Text('Filters',
                      style: TextStyle(color: Colors.black)),
                ),
                const SizedBox(
                    width: 10), // Menambahkan jarak antara ikon dan teks
              ],
            ),
            const SizedBox(height: 20),
            Image.asset(imagePath),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final ByteData bytes = await rootBundle.load(imagePath);
                    final Uint8List list = bytes.buffer.asUint8List();

                    final tempDir = await getTemporaryDirectory();
                    final file =
                        await File('${tempDir.path}/image.png').create();
                    file.writeAsBytesSync(list);

                    // handle save to local action
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Image saved to ${file.path}')),
                    );
                  },
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text('Save as Images',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .black, // Mengubah warna latar belakang menjadi pink
                    elevation: 0,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final ByteData bytes = await rootBundle.load(imagePath);
                    final Uint8List list = bytes.buffer.asUint8List();

                    final tempDir = await getTemporaryDirectory();
                    final file =
                        await File('${tempDir.path}/image.png').create();
                    file.writeAsBytesSync(list);

                    // Share.shareFiles([file.path],
                    //     text: 'Check out my certificate!');
                  },
                  icon: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  label: const Text('Send to Email',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .black, // Mengubah warna latar belakang menjadi pink
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
