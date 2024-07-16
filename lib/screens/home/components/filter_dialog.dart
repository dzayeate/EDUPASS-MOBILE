import 'package:edupass_mobile/controllers/auth/login_controller.dart';
import 'package:edupass_mobile/controllers/auth/update_user_controller.dart';
import 'package:edupass_mobile/screens/profile/components/profile_date_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  bool uiUxDesignerType = false;
  bool websiteType = false;
  bool uiUxDesignerTopic = false;
  bool websiteTopic = false;
  bool jakartaLocation = false;
  bool jawaBaratLocation = false;
  bool jawaTengahLocation = false;

  late UpdateUserController _controller;

  @override
  void initState() {
    super.initState();
    _controller = UpdateUserController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildCheckbox(
            'Type of Competition',
            'UI UX Designer',
            uiUxDesignerType,
            (value) {
              setState(() {
                uiUxDesignerType = value!;
              });
            },
          ),
          _buildCheckbox(
            '',
            'Website',
            websiteType,
            (value) {
              setState(() {
                websiteType = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          _buildCheckbox(
            'Topic of Competition',
            'UI UX Designer',
            uiUxDesignerTopic,
            (value) {
              setState(() {
                uiUxDesignerTopic = value!;
              });
            },
          ),
          _buildCheckbox(
            '',
            'Website',
            websiteTopic,
            (value) {
              setState(() {
                websiteTopic = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          _buildCheckbox(
            'Locations',
            'Jakarta',
            jakartaLocation,
            (value) {
              setState(() {
                jakartaLocation = value!;
              });
            },
          ),
          _buildCheckbox(
            '',
            'Jawa Barat',
            jawaBaratLocation,
            (value) {
              setState(() {
                jawaBaratLocation = value!;
              });
            },
          ),
          _buildCheckbox(
            '',
            'Jawa Tengah',
            jawaTengahLocation,
            (value) {
              setState(() {
                jawaTengahLocation = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          ProfileDateField(
            label: 'Select Date',
            placeholder: 'YYYY-MM-DD',
            controller: _controller.birthDateController,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    // Clear filter logic here
                    setState(() {
                      uiUxDesignerType = false;
                      websiteType = false;
                      uiUxDesignerTopic = false;
                      websiteTopic = false;
                      jakartaLocation = false;
                      jawaBaratLocation = false;
                      jawaTengahLocation = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, // Button background color
                    // Button text color
                  ),
                  child: Text(
                    'Clear Filter',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )),
              ElevatedButton(
                  onPressed: () {
                    // Apply filter logic here
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, // Button background color
                    // Button text color
                  ),
                  child: Text(
                    'Apply Filter',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(
      String title, String label, bool value, Function(bool?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
            ),
            Text(label),
          ],
        ),
      ],
    );
  }
}
