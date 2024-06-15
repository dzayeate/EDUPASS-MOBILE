import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionTab extends StatelessWidget {
  const DescriptionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(8), // You can adjust the radius value as needed
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'We are proud to present the UI/UX Competition 2024 which will be held in Bandung! This is a golden opportunity for students to showcase their talent and creativity in user interface and user experience design. Here are the full details of the competition:',
                  style: GoogleFonts.inter(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Registration and Fee:',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '• Registration fee is IDR 50,000 per team.',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                Text(
                  '• Each team can consist of 1 to 3 members.',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  'Participant Categories:',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '• Open to university and high school students from all over Indonesia.',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  'Participant Benefits:',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '• Cash prizes for the winners.',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                Text(
                  '• Certificates for all participants.',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  'Terms and Conditions:',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '• Each team must submit an original UI/UX design that has not been published before.',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                Text(
                  '• The design should reflect innovation and creativity in solving user problems.',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                Text(
                  '• Design presentations will be held in Bandung on [Presentation Date].',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  'Registration Process:',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '• Fill out the registration form completely and pay the registration fee of IDR 50,000 to the following account: [Bank Details]',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                Text(
                  '• After making the payment, send the payment proof to: [Registration Email]',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  'Further Information:',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'For more information, contact us via email: dzikry@gmail.com or phone: 08776651725375',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const SizedBox(height: 16),
                Text(
                  'SPEAKERS',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.person, size: 20), // Adjust the size if needed
                    SizedBox(width: 8),
                    Text(
                      'Nama mentor',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 10), // Add spacing between the rows
                Row(
                  children: [
                    Icon(Icons.person, size: 20), // Adjust the size if needed
                    SizedBox(width: 8),
                    Text(
                      'Nama mentor',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Organizer',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.people, size: 20), // Adjust the size if needed
                    SizedBox(width: 8),
                    Text(
                      'Organizer',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 10), // Add spacing between the rows
                Row(
                  children: [
                    Icon(Icons.people, size: 20), // Adjust the size if needed
                    SizedBox(width: 8),
                    Text(
                      'Organizer',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PrizesTab extends StatelessWidget {
  const PrizesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(15), // Adjust the radius value as needed
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Inner padding for content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Icon(Icons.check, color: Colors.indigo),
                    SizedBox(width: 8),
                    Text(
                      '1st Place: IDR 2.000.000 + Certificate',
                      style: GoogleFonts.inter(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.check, color: Colors.indigo),
                    SizedBox(width: 8),
                    Text(
                      '2nd Place: IDR 1.500.000 + Certificate',
                      style: GoogleFonts.inter(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.check, color: Colors.indigo),
                    SizedBox(width: 8),
                    Text(
                      '3rd Place: IDR 1.000.000 + Certificate',
                      style: GoogleFonts.inter(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
