import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:edupass_mobile/api/competition/get/get_comp_service.dart';
import 'package:edupass_mobile/controllers/competition/post/register_comp_controller.dart';
import 'package:edupass_mobile/screens/components/custom_number_field.dart';
import 'package:edupass_mobile/screens/components/custom_text_field.dart';
import 'package:edupass_mobile/screens/components/upload_file_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class CompetitionMhsRegis extends StatefulWidget {
  final String id;
  const CompetitionMhsRegis({super.key, required this.id});

  @override
  State<CompetitionMhsRegis> createState() => _CompetitionMhsRegisState();
}

class _CompetitionMhsRegisState extends State<CompetitionMhsRegis> {
  final RegisterCompetitionController controller =
      RegisterCompetitionController();
  String? _selectedFilePath;
  bool isInfoChecked = false;
  bool isAgreeChecked = false;
  bool isTeam = false;
  List<Widget> anggotaFields = [];
  List<TextEditingController> anggotaControllers = [];

  final GetCompetitionService _competitionService = GetCompetitionService();

  bool _isLoading = true;
  String? _errorMessage;
  Map<String, dynamic>? _competitionDetail;

  @override
  void initState() {
    super.initState();
    _fetchCompetitionDetail();
  }

  Future<void> _fetchCompetitionDetail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final data = await _competitionService.getCompetitionDetail(widget.id);
      setState(() {
        _competitionDetail = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _handleFileSelected(String filePath) {
    setState(() {
      _selectedFilePath = filePath;
      // update controller
      controller.setFilePath(filePath);
    });
    debugPrint('File path: $filePath');
  }

  void _removeAnggotaField(int index) {
    setState(() {
      if (index >= 0 && index < anggotaControllers.length) {
        anggotaControllers.removeAt(index);
        anggotaFields.removeAt(index);
      }
    });
  }

  void _addAnggotaField() {
    if (controller.teamSize.text.isNotEmpty) {
      int maxAnggota = int.tryParse(controller.teamSize.text) ?? 0;
      if (anggotaFields.length < maxAnggota) {
        TextEditingController newController = TextEditingController();
        anggotaControllers.add(newController);
        anggotaFields.add(
          Column(
            children: [
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Masukkan Email Anggota',
                hintText: 'johndoe@gmail.com',
                controller: newController,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  _removeAnggotaField(anggotaFields.length - 1);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Warna latar belakang tombol
                ),
                child: const Text(
                  'Hapus Anggota',
                  style: TextStyle(color: Colors.white), // Warna teks
                ),
              ),
            ],
          ),
        );
      } else {
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: AwesomeSnackbarContent(
              titleFontSize: 17,
              messageFontSize: 15,
              title: 'Perhatian!',
              message: 'Jumlah anggota maksimal sudah tercapai.',
              contentType: ContentType.warning,
            ),
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } else {
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AwesomeSnackbarContent(
            titleFontSize: 17,
            messageFontSize: 15,
            title: 'Perhatian!',
            message: 'Masukkan jumlah anggota terlebih dahulu.',
            contentType: ContentType.warning,
          ),
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...', style: GoogleFonts.poppins(fontSize: 20)),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error', style: GoogleFonts.poppins(fontSize: 20)),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_errorMessage!),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _fetchCompetitionDetail,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Tambahkan navigasi kembali
          },
        ),
        title: Text(
          "Pendaftaran Event",
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Text(
              _competitionDetail!['name'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _competitionDetail!['description'],
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 36),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const Icon(Ionicons.calendar_outline, color: Colors.indigo),
                  const SizedBox(width: 8),
                  Text(
                    'Schedule : ${_competitionDetail!['startDate']} s/d ${_competitionDetail!['endDate']}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const Icon(Ionicons.time_outline, color: Colors.indigo),
                  const SizedBox(width: 8),
                  Text(
                    'Schedule : ${_competitionDetail!['startTime']} s/d ${_competitionDetail!['endTime']}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Selesaikan form registrasi dibawah ini',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: 'Asal Lokasi',
              hintText: 'Bandung',
              readOnly: false,
              controller: controller.domicile,
            ),
            const SizedBox(height: 16),
            CustomNumberField(
              labelText: 'Masukkan Nomor Telepon',
              hintText: '082123123',
              readOnly: false,
              controller: controller.phoneNumber,
            ),
            const SizedBox(height: 30),
            UploadFileField(
              onFileSelected: _handleFileSelected,
              allowedExtensions: const [
                'pdf',
              ], // Allow images and PDFs
            ),
            const SizedBox(height: 24),
            if (_selectedFilePath != null) ...[
              Text('Selected file: $_selectedFilePath'),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Registrasi sebagai tim',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Checkbox(
                  value: isTeam,
                  onChanged: (bool? value) {
                    setState(() {
                      isTeam = value ?? false;
                    });
                  },
                ),
              ],
            ),
            if (isTeam) ...[
              CustomTextField(
                labelText: 'Nama Tim',
                hintText: 'Masukkan Nama Tim',
                readOnly: false,
                controller: controller.nameTeam,
              ),
              const SizedBox(height: 16),
              CustomNumberField(
                labelText: 'Jumlah Anggota',
                hintText: '3 Anggota',
                readOnly: false,
                controller: controller.teamSize,
              ),
              const SizedBox(height: 16),
              Column(
                children: anggotaFields,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _addAnggotaField();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Tambahkan Anggota',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: const Offset(-8, 0),
                  child: Checkbox(
                    value: isInfoChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isInfoChecked = value ?? false;
                      });
                    },
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Saya menyatakan bahwa informasi yang saya berikan adalah benar dan dapat dipertanggung jawabkan',
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: const Offset(-8, 0),
                  child: Checkbox(
                    value: isAgreeChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isAgreeChecked = value ?? false;
                      });
                    },
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Saya setuju untuk mematuhi semua aturan dan regulasi yang ditetapkan oleh penyelenggara kompetisi',
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                int maxAnggota = int.tryParse(controller.teamSize.text) ?? 0;
                if (isTeam && controller.nameTeam.text.trim().isEmpty) {
                  final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 70),
                      child: AwesomeSnackbarContent(
                        titleFontSize: 17,
                        messageFontSize: 15,
                        title: 'Perhatian!',
                        message:
                            'Nama Tim wajib diisi untuk registrasi sebagai tim.',
                        contentType: ContentType.warning,
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                  return;
                }

                if (isInfoChecked &&
                    isAgreeChecked &&
                    (anggotaFields.length == maxAnggota || !isTeam)) {
                  Navigator.pop(
                    context,
                  );
                  controller.register(context, widget.id, isTeam,
                      anggotaFields.length, anggotaControllers);
                } else {
                  // String message =
                  //     'You must accept the terms and conditions to proceed.';
                  final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 70),
                      child: AwesomeSnackbarContent(
                        titleFontSize: 17,
                        messageFontSize: 15,
                        title: 'Perhatian!',
                        message:
                            'Anda harus menyetujui terms and conditions untuk melanjutkan.',
                        contentType: ContentType.warning,
                      ),
                    ),
                  );

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);

                  if (isTeam && anggotaFields.length != maxAnggota) {
                    // message =
                    //     'Jumlah anggota harus sesuai dengan yang diisi di kolom jumlah anggota.';
                    final snackBar = SnackBar(
                      /// need to set following properties for best effect of awesome_snackbar_content
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 70),
                        child: AwesomeSnackbarContent(
                          titleFontSize: 17,
                          messageFontSize: 15,
                          title: 'Perhatian!',
                          message:
                              'Jumlah anggota harus sesuai dengan yang diisi di kolom jumlah anggota.',
                          contentType: ContentType.warning,
                        ),
                      ),
                    );

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  }
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text(message),
                  //   ),
                  // );
                }
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Submit',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
