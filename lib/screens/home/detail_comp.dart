import 'package:edupass_mobile/screens/comp_registration/comp_regis_mhs.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:edupass_mobile/screens/home/components/detail_comp_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class DetailCompScreen extends StatefulWidget {
  const DetailCompScreen({super.key});

  @override
  State<DetailCompScreen> createState() => _DetailCompScreenState();
}

class _DetailCompScreenState extends State<DetailCompScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lomba UI UX', style: GoogleFonts.poppins(fontSize: 20)),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Ionicons.arrow_back, color: Colors.black),
            onPressed: () {
              // Handle back button press
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => EduPassApp(initialPageIndex: 0),
                ),
              );
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
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Competition UI/UX',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.pink[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Education',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'NSPACE 2024: UI/UX COMPETITION',
                  style: GoogleFonts.poppins(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'KOMINFO',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Ionicons.calendar_outline, color: Colors.indigo),
                    SizedBox(width: 8),
                    Text(
                      '11 Juli 2024',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Ionicons.location_outline, color: Colors.indigo),
                    SizedBox(width: 8),
                    Text(
                      'Bandung',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white, // Change background color to white
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Grey shadow
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(
                    'Registration fee is IDR 50,000 per team.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.indigo[900],
                    ),
                  ),
                ),

                SizedBox(height: 28),
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
                      Tab(text: 'Description'),
                      Tab(text: 'Prizes'),
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
                SizedBox(
                  height:
                      400, // Specify a height for TabBarView to make it scrollable
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      DescriptionTab(),
                      PrizesTab(),
                    ],
                  ),
                ),
                SizedBox(height: 16), // Add some spacing before the buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(Ionicons.share_social, color: Colors.black),
                        onPressed: () {
                          // Handle share button press
                        },
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        constraints: BoxConstraints(),
                        iconSize: 32,
                        splashColor: Colors.indigo,
                        tooltip: 'Share',
                      ),
                    ),
                    SizedBox(width: 16), // Add some spacing between the buttons
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle join now button press
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CompetitionMhsRegis()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 12), // Adjust padding here
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.indigo, // Background color
                        ),
                        child: Text(
                          'Join Now',
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.white),
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
