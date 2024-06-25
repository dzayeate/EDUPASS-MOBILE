import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:edupass_mobile/utils/event_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListCompetitions extends StatelessWidget {
  const ListCompetitions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const EduPassApp(initialPageIndex: 1),
              ),
            );
          },
        ),
        title: Text(
          'List Competitions',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Event Cards
            Expanded(
              child: ListView(
                children: const [
                  EventCard(
                    title: 'NSPACE 2024 : UI/UX COMPETITION',
                    date: '11 Juli 2024',
                    location: 'Kampus FT',
                    peopleRegistered: '50 Orang Terdaftar',
                    label: 'Lomba',
                    label2: 'UI/UX Design',
                    imageUrl:
                        'assets/images/competition_1.png', // Adjust image asset
                  ),
                  EventCard(
                    title: 'NSPACE 2024 : Web COMPETITION',
                    date: '11 Juli 2024',
                    location: 'Silicon Valley',
                    peopleRegistered: '50 Orang Terdaftar',
                    label: 'Lomba',
                    label2: 'UI/UX Design',
                    imageUrl:
                        'assets/images/competition_2.png', // Adjust image asset
                  ),
                  EventCard(
                    title: 'MObil lejen',
                    date: '11 Juli 2024',
                    location: 'Di rumah',
                    peopleRegistered: '50 Orang Terdaftar',
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
    );
  }
}
