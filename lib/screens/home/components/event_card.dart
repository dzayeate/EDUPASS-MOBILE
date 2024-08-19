import 'package:edupass_mobile/screens/home/detail_comp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventCard extends StatelessWidget {
  final String id;
  final String title;
  final String startDate;
  final String endDate;
  final String location;
  final String peopleRegistered;
  final String label;
  final String labelTwo;
  final String? imageUrl; // imageUrl now can be null

  const EventCard({
    super.key,
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.peopleRegistered,
    required this.label,
    required this.labelTwo,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if the image is from network or local
    final bool isNetworkImage =
        imageUrl != null && imageUrl!.startsWith("http");

    // Choose the correct image widget based on the source
    final Widget imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
      child: isNetworkImage
          ? Image.network(
              imageUrl!, // Image from network
              width: 100, // Adjust this value based on your design
              height: 150,
              fit: BoxFit.cover,
              // fit: BoxFit.contain,
            )
          : Image.asset(
              'assets/images/competition_1.png', // Default image
              width: 100, // Adjust this value based on your design
              height: 150,
              fit: BoxFit.cover,
            ),
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageWidget,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          label,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          labelTwo,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.event, size: 16),
                      const SizedBox(width: 8),
                      Text(startDate),
                      const SizedBox(width: 8),
                      const Text("s/d"),
                      const SizedBox(width: 8),
                      Text(endDate),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16),
                      const SizedBox(width: 8),
                      Text(location),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.people_alt_sharp, size: 16),
                      const SizedBox(width: 8),
                      Text(peopleRegistered),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailCompScreen(id: id)),
                        );
                        debugPrint("ID Carried $id");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo, // Background color
                      ),
                      child: const Text(
                        'View Details',
                        style: TextStyle(
                          color: Colors.white, // Text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
