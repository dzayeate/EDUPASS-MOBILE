import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DropdownField extends StatefulWidget {
  final String label;
  const DropdownField({super.key, required this.label});

  @override
  _DropdownFieldState createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            widget.label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          value: selectedCity,
          items: [
            DropdownMenuItem(
              value: 'Jakarta',
              child: Text('Jakarta', style: GoogleFonts.poppins(fontSize: 14)),
            ),
            DropdownMenuItem(
              value: 'Surabaya',
              child: Text('Surabaya', style: GoogleFonts.poppins(fontSize: 14)),
            ),
            DropdownMenuItem(
              value: 'Bandung',
              child: Text('Bandung', style: GoogleFonts.poppins(fontSize: 14)),
            ),
            DropdownMenuItem(
              value: 'Medan',
              child: Text('Medan', style: GoogleFonts.poppins(fontSize: 14)),
            ),
            DropdownMenuItem(
              value: 'Makassar',
              child: Text('Makassar', style: GoogleFonts.poppins(fontSize: 14)),
            ),
            DropdownMenuItem(
              value: 'Yogyakarta',
              child:
                  Text('Yogyakarta', style: GoogleFonts.poppins(fontSize: 14)),
            ),
            DropdownMenuItem(
              value: 'Semarang',
              child: Text('Semarang', style: GoogleFonts.poppins(fontSize: 14)),
            ),
            DropdownMenuItem(
              value: 'Palembang',
              child:
                  Text('Palembang', style: GoogleFonts.poppins(fontSize: 14)),
            ),
            DropdownMenuItem(
              value: 'Denpasar',
              child: Text('Denpasar', style: GoogleFonts.poppins(fontSize: 14)),
            ),
            DropdownMenuItem(
              value: 'Balikpapan',
              child:
                  Text('Balikpapan', style: GoogleFonts.poppins(fontSize: 14)),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedCity = value;
            });
          },
        ),
      ),
    );
  }
}
