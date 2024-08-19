import 'package:edupass_mobile/screens/home/components/user_detail_fetcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionTab extends StatefulWidget {
  final String description;
  final List<dynamic> mentors;
  final List<dynamic> sponsors;

  const DescriptionTab({
    required this.description,
    required this.mentors,
    required this.sponsors,
    super.key,
  });

  @override
  State<DescriptionTab> createState() => _DescriptionTabState();
}

class _DescriptionTabState extends State<DescriptionTab> {
  final UserDetailsFetcher _userDetailsFetcher = UserDetailsFetcher();
  List<Map<String, String>> _mentorNames = [];
  List<Map<String, String>> _sponsorNames = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    try {
      List<Map<String, String>> mentorNames =
          await _userDetailsFetcher.fetchUserDetails(widget.mentors);
      List<Map<String, String>> sponsorNames =
          await _userDetailsFetcher.fetchUserDetails(widget.sponsors);

      setState(() {
        _mentorNames = mentorNames;
        _sponsorNames = sponsorNames;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Text(_errorMessage!),
      );
    }
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
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: const BorderRadius.all(
              Radius.circular(8), // You can adjust the radius value as needed
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.description,
                  style: GoogleFonts.inter(fontSize: 16),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'SPEAKERS',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                buildMentorsList(),
                const SizedBox(height: 16),
                Text(
                  'ORGANIZER',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                buildSponsorsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMentorsList() {
    if (widget.mentors.isEmpty) {
      return Text(
        'Diberi tahu lebih lanjut',
        style: GoogleFonts.poppins(fontSize: 14),
      );
    }
    return Column(
      children: _mentorNames
          .map(
            (mentor) => Row(
              children: [
                const Icon(Icons.person, color: Colors.indigo, size: 20),
                const SizedBox(width: 8),
                Text(
                  '${mentor['firstName']} ${mentor['lastName']}',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget buildSponsorsList() {
    if (widget.sponsors.isEmpty) {
      return Text(
        'Diberi tahu lebih lanjut',
        style: GoogleFonts.poppins(fontSize: 14),
      );
    }
    return Column(
      children: _sponsorNames
          .map(
            (sponsor) => Row(
              children: [
                const Icon(Icons.people, color: Colors.indigo, size: 20),
                const SizedBox(width: 8),
                Text(
                  '${sponsor['firstName']} ${sponsor['lastName']}',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ],
            ),
          )
          .toList(),
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
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: const BorderRadius.all(
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
                      'Juara 1 : IDR 3.000.000 + Sertifikat',
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
                      'Juara 2 : IDR 1.500.000 + Sertifikat',
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
                      'Juara 3 : IDR 500.000 + Sertifikat',
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
