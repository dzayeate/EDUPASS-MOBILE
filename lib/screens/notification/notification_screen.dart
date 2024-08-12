import 'package:edupass_mobile/models/notification/notification_model.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final List<NotificationModel> notifications = [
    NotificationModel(
      message:
          'Selamat datang di aplikasi EduPas! Terima kasih telah mendaftar. Kami siap membantu Anda dalam mengikuti berbagai event menarik.',
      date: '07/02/2024',
      imageUrl:
          'https://i.pravatar.cc/150?img=4', // Replace with your image URL
    ),
    // Add more notifications here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const EduPassApp(initialPageIndex: 0),
              ),
            );
          },
        ),
        title: Text(
          'Notifikasi',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(notification.imageUrl),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.message,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.date,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
