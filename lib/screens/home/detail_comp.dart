import 'package:intl/intl.dart';
import 'package:edupass_mobile/api/competition/get/get_comp_service.dart';
import 'package:edupass_mobile/screens/competition_task/comp_registration/comp_regis_mhs.dart';
import 'package:edupass_mobile/screens/home/components/detail_comp_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:share_plus/share_plus.dart';

class DetailCompScreen extends StatefulWidget {
  final String id;

  const DetailCompScreen({required this.id, super.key});

  @override
  State<DetailCompScreen> createState() => _DetailCompScreenState();
}

class _DetailCompScreenState extends State<DetailCompScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GetCompetitionService _competitionService = GetCompetitionService();

  bool _isLoading = true;
  String? _errorMessage;
  Map<String, dynamic>? _competitionDetail;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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

    // Pengecekan tanggal
    DateTime today = DateTime.now();
    DateTime startDate =
        DateFormat('yyyy-MM-dd').parse(_competitionDetail!['startDate']);
    DateTime endDate =
        DateFormat('yyyy-MM-dd').parse(_competitionDetail!['endDate']);

    bool isCompetitionOpen =
        today.isAfter(startDate) && today.isBefore(endDate);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_competitionDetail!['name'],
              style: GoogleFonts.poppins(fontSize: 20)),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Ionicons.arrow_back, color: Colors.black),
            onPressed: () {
              // Handle back button press
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage(
                          'assets/images/image-detail.png'), // Ubah sesuai dengan path gambar Anda
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _competitionDetail!['category'],
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _competitionDetail!['platform'],
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  _competitionDetail!['name'],
                  style: GoogleFonts.poppins(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  _competitionDetail!['description'],
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Ionicons.calendar_outline, color: Colors.indigo),
                    const SizedBox(width: 8),
                    Text(
                      _competitionDetail!['startDate'],
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    const Text("s/d"),
                    const SizedBox(width: 8),
                    Text(
                      _competitionDetail!['endDate'],
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Ionicons.time_outline, color: Colors.indigo),
                    const SizedBox(width: 8),
                    Text(
                      _competitionDetail!['startTime'],
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    const Text("s/d"),
                    const SizedBox(width: 8),
                    Text(
                      _competitionDetail!['endTime'],
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Ionicons.location_outline, color: Colors.indigo),
                    const SizedBox(width: 8),
                    Text(
                      _competitionDetail!['location'],
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.people, color: Colors.indigo),
                    const SizedBox(width: 8),
                    Text(
                      '${_competitionDetail!['registrationCount'].toString()} Orang Terdaftar',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white, // Change background color to white
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Grey shadow
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(
                    'Biaya Pendaftaran Gratis',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.indigo[900],
                    ),
                  ),
                ),

                const SizedBox(height: 28),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ), // Warna latar belakang TabBar
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor:
                        Colors.white, // Warna indikator (garis bawah tab)
                    labelColor: Colors.white, // Warna teks yang dipilih
                    unselectedLabelColor:
                        Colors.black, // Warna teks yang tidak dipilih
                    tabs: const [
                      Tab(text: 'Deskripsi'),
                      Tab(text: 'Hadiah'),
                    ],
                    indicator: BoxDecoration(
                      color: Colors
                          .indigo, // Warna latar belakang tab yang dipilih
                      borderRadius:
                          BorderRadius.circular(30), // Membuat sudut membulat
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,

                    // Memperluas indikator ke ukuran tab
                  ),
                ),

                // Pemisahan Garis bawah tab dengan scrollable tab
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height:
                      300, // Specify a height for TabBarView to make it scrollable
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      DescriptionTab(
                        description: _competitionDetail!['description'],
                        mentors: _competitionDetail!['mentor'],
                        sponsors: _competitionDetail!['sponsor'],
                      ),
                      const PrizesTab(),
                    ],
                  ),
                ),
                const SizedBox(
                    height: 16), // Add some spacing before the buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Ionicons.share_social,
                            color: Colors.black),
                        onPressed: () {
                          // Handle share button press
                          final url =
                              'http://192.168.1.4:3000/competition/findCompetition?page=1&length=1&search=${widget.id}';
                          Share.share('Check out this competition: $url');
                        },
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        constraints: const BoxConstraints(),
                        iconSize: 32,
                        splashColor: Colors.indigo,
                        tooltip: 'Share',
                      ),
                    ),
                    const SizedBox(
                        width: 16), // Add some spacing between the buttons
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isCompetitionOpen
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CompetitionMhsRegis(
                                            id: widget.id,
                                          )),
                                );
                              }
                            : null, // Button tidak aktif jika kompetisi ditutup
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12), // Adjust padding here
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.indigo, // Background color
                        ),
                        child: Text(
                          isCompetitionOpen
                              ? 'Daftar Sekarang'
                              : 'Kompetisi Ditutup',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
