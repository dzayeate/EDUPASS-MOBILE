import 'package:edupass_mobile/components/event_card.dart';
import 'package:edupass_mobile/navigations/bottom_nav_bar.dart';
import 'package:edupass_mobile/screens/scan_qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Hi, Dzikry!',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Placeholder',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.tune),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Register Event Card
            Card(
              child: ListTile(
                leading: Image.asset(
                    'assets/images/event_image.png'), // Adjust image asset
                title: const Text(
                  'Let\'s Register Your First Event!',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Register Event',
                      style: TextStyle(fontSize: 12)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Event Cards
            Expanded(
              child: ListView(
                children: const [
                  EventCard(
                    title: 'NSPACE 2024 : UI/UX COMPETITION',
                    date: '11 Juli 2024',
                    location: 'Kampus FT',
                    label: 'Lomba',
                    label2: 'UI/UX Design',
                    imageUrl:
                        'assets/images/competition_1.png', // Adjust image asset
                  ),
                  EventCard(
                    title: 'NSPACE 2024 : Web COMPETITION',
                    date: '11 Juli 2024',
                    location: 'Silicon Valley',
                    label: 'Lomba',
                    label2: 'UI/UX Design',
                    imageUrl:
                        'assets/images/competition_2.png', // Adjust image asset
                  ),
                  EventCard(
                    title: 'MObil lejen',
                    date: '11 Juli 2024',
                    location: 'Di rumah',
                    label: 'Lomba',
                    label2: 'E-sport',
                    imageUrl:
                        'assets/images/competition_2.png', // Adjust image asset
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle FAB action here
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScanQrCode()),
          );
        },
        backgroundColor: Colors
            .deepPurpleAccent[200], // Customize the background color if needed
        child: const Icon(Icons.qr_code_scanner,
            color: Colors.white), // QR scan icon
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
