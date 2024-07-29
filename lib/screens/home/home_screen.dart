import 'package:edupass_mobile/api/get_user/get_user_service.dart';
import 'package:edupass_mobile/controllers/competition/get/get_comp_controller.dart';
import 'package:edupass_mobile/screens/notification/notification_screen.dart';
import 'package:edupass_mobile/utils/event_card.dart';
import 'package:edupass_mobile/screens/home/components/filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<String> _futureFirstName;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _futureFirstName = _fetchFirstName();

    // Add scroll listener
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Provider.of<GetCompetitionController>(context, listen: false).loadMore();
    }
  }

  Future<String> _fetchFirstName() async {
    try {
      final userService = GetUserService();
      final userData = await userService.getUserByBiodateId();
      if (userData != null &&
          userData['biodate']['firstName'] != null &&
          userData['biodate']['firstName'].isNotEmpty) {
        return userData['biodate']['firstName'];
      } else {
        return 'user';
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
      return 'user';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fetch competitions when HomeScreen is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetCompetitionController>(context, listen: false)
          .fetchCompetitions();
    });

    return WillPopScope(
      onWillPop: () async {
        // Menangani ketika tombol back ditekan
        SystemNavigator.pop(); // Keluar dari aplikasi
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: FutureBuilder<String>(
            future: _futureFirstName,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text(
                  'Loading...',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(
                  'Hi, user!',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else {
                final firstName = snapshot.data!;
                return Text(
                  'Hi, $firstName!',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bar
              TextField(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    Provider.of<GetCompetitionController>(context,
                            listen: false)
                        .searchCompetitions(value);
                  } else {
                    Provider.of<GetCompetitionController>(context,
                            listen: false)
                        .fetchCompetitions();
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Placeholder',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.tune),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const FilterSheet(),
                      );
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Register Event Card
              Card(
                color: Colors.indigo,
                child: ListTile(
                  leading: Image.asset(
                      'assets/images/event_image.png'), // Adjust image asset
                  title: const Text(
                    'Let\'s Register Your First Event!',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Register Event',
                        style: TextStyle(fontSize: 12, color: Colors.black)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Event Cards
              Expanded(
                child: Consumer<GetCompetitionController>(
                  builder: (context, competitionController, child) {
                    if (competitionController.isLoading &&
                        competitionController.competitions.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (competitionController.errorMessage != null) {
                      return Center(
                          child: Text(competitionController.errorMessage!));
                    }

                    if (competitionController.competitions.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Kompetisi tidak ditemukan',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<GetCompetitionController>(context,
                                        listen: false)
                                    .fetchCompetitions();
                              },
                              child: Text('Refresh'),
                            ),
                          ],
                        ),
                      );
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount:
                                competitionController.competitions.length +
                                    (competitionController.isLoading ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index ==
                                  competitionController.competitions.length) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final competition =
                                  competitionController.competitions[index];
                              return EventCard(
                                id: competition['id'],
                                title: competition['name'],
                                date: competition['date'],
                                location: competition['location'],
                                peopleRegistered:
                                    '', // Data ini tidak ada di API
                                label: competition[
                                    'category'], // Data ini tidak ada di API
                                label2: competition[
                                    'platform'], // Data ini tidak ada di API
                                imageUrl:
                                    'assets/images/competition_1.png', // Adjust image asset

                                // imageUrl: competition['banner'] != null &&
                                //         competition['banner'].isNotEmpty
                                //     ? Image.network(
                                //         competition['banner'],
                                //         width: 100,
                                //         height: 165,
                                //         fit: BoxFit.cover,
                                //       )
                                //     : Image.asset(
                                //         'assets/images/competition_1.png',
                                //         width: 100,
                                //         height: 165,
                                //         fit: BoxFit.cover,
                                //       ), // Adjust image asset
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
