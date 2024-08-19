import 'package:flutter/material.dart';

class ActivityEmpty extends StatelessWidget {
  const ActivityEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty-box.png', // Pastikan path ini sesuai dengan lokasi gambar Anda
            width: 150, // Sesuaikan ukuran gambar sesuai kebutuhan
            height: 150,
          ),
          const SizedBox(height: 20),
          const Text(
            'Yuk, Ikut event untuk pertama kalinya',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            'Nanti semua eventmu bakal kesimpen disini dan bisa download sertifikat. tinggal pencet!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
