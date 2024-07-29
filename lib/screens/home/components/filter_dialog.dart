import 'package:edupass_mobile/controllers/auth/login_controller.dart';
import 'package:edupass_mobile/controllers/auth/update_user_controller.dart';
import 'package:edupass_mobile/controllers/competition/get/get_comp_controller.dart';
import 'package:edupass_mobile/screens/profile/components/profile_date_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  bool webCategory = false;
  bool uiUxCategory = false;
  bool mobileCategory = false;
  bool zoomPlatform = false;
  bool gmeetPlatform = false;
  bool jakartaLocation = false;
  bool bandungLocation = false;
  bool yogyakartaLocation = false;

  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
  }

  void _resetOtherCheckboxes(String selected) {
    setState(() {
      if (selected != 'webCategory') webCategory = false;
      if (selected != 'uiUxCategory') uiUxCategory = false;
      if (selected != 'mobileCategory') mobileCategory = false;
      if (selected != 'zoomPlatform') zoomPlatform = false;
      if (selected != 'gmeetPlatform') gmeetPlatform = false;
      if (selected != 'jakartaLocation') jakartaLocation = false;
      if (selected != 'bandungLocation') bandungLocation = false;
      if (selected != 'yogyakartaLocation') yogyakartaLocation = false;
    });
  }

  void _applyFilter() {
    String filter = '';
    if (webCategory) filter = 'web';
    if (uiUxCategory) filter = 'ui/ux';
    if (mobileCategory) filter = 'mobile';
    if (zoomPlatform) filter = 'zoom';
    if (gmeetPlatform) filter = 'gmeet';
    if (jakartaLocation) filter = 'Jakarta';
    if (bandungLocation) filter = 'Bandung';
    if (yogyakartaLocation) filter = 'Yogyakarta';

    String date = _dateController.text;
    if (date.isNotEmpty) {
      filter = date;
    }

    debugPrint('Selected filter: $filter');

    Provider.of<GetCompetitionController>(context, listen: false)
        .fetchFilteredCompetitions(filter);
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
            'Category',
            'Web',
            webCategory,
            (value) {
              setState(() {
                webCategory = value!;
                if (value) _resetOtherCheckboxes('webCategory');
              });
            },
          ),
          _buildCheckbox(
            '',
            'UI/UX',
            uiUxCategory,
            (value) {
              setState(() {
                uiUxCategory = value!;
                if (value) _resetOtherCheckboxes('uiUxCategory');
              });
            },
          ),
          _buildCheckbox(
            '',
            'Mobile',
            mobileCategory,
            (value) {
              setState(() {
                mobileCategory = value!;
                if (value) _resetOtherCheckboxes('mobileCategory');
              });
            },
          ),
          const SizedBox(height: 16),
          _buildCheckbox(
            'Platform',
            'Zoom',
            zoomPlatform,
            (value) {
              setState(() {
                zoomPlatform = value!;
                if (value) _resetOtherCheckboxes('zoomPlatform');
              });
            },
          ),
          _buildCheckbox(
            '',
            'GMeet',
            gmeetPlatform,
            (value) {
              setState(() {
                gmeetPlatform = value!;
                if (value) _resetOtherCheckboxes('gmeetPlatform');
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
                if (value) _resetOtherCheckboxes('jakartaLocation');
              });
            },
          ),
          _buildCheckbox(
            '',
            'Bandung',
            bandungLocation,
            (value) {
              setState(() {
                bandungLocation = value!;
                if (value) _resetOtherCheckboxes('bandungLocation');
              });
            },
          ),
          _buildCheckbox(
            '',
            'Yogyakarta',
            yogyakartaLocation,
            (value) {
              setState(() {
                yogyakartaLocation = value!;
                if (value) _resetOtherCheckboxes('yogyakartaLocation');
              });
            },
          ),
          const SizedBox(height: 16),
          ProfileDateField(
            label: 'Select Date',
            placeholder: 'YYYY-MM-DD',
            controller: _dateController,
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
                      webCategory = false;
                      uiUxCategory = false;
                      mobileCategory = false;
                      zoomPlatform = false;
                      gmeetPlatform = false;
                      jakartaLocation = false;
                      bandungLocation = false;
                      yogyakartaLocation = false;
                      _dateController.clear();
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
                    _applyFilter();
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
