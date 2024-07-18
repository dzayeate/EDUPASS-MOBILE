import 'package:edupass_mobile/controllers/competition/get/get_comp_controller.dart';
import 'package:edupass_mobile/screens/notification/notification_screen.dart';
import 'package:edupass_mobile/utils/event_card.dart';
import 'package:edupass_mobile/screens/home/components/filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          title: Text(
            'Hi, John!',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
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
                    if (competitionController.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (competitionController.errorMessage != null) {
                      return Center(
                          child: Text(competitionController.errorMessage!));
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount:
                                competitionController.competitions.length,
                            itemBuilder: (context, index) {
                              final competition =
                                  competitionController.competitions[index];
                              return EventCard(
                                id: competition['id'],
                                title: competition['name'],
                                date: competition['date'],
                                location: competition['location'],
                                peopleRegistered:
                                    '', // Data ini tidak ada di API
                                label: '', // Data ini tidak ada di API
                                label2: '', // Data ini tidak ada di API
                                imageUrl:
                                    'assets/images/competition_1.png', // Adjust image asset
                              );
                            },
                          ),
                        ),
                        if (competitionController.competitions.length <
                            competitionController.total)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Provider.of<GetCompetitionController>(context,
                                        listen: false)
                                    .loadMore();
                              },
                              child: Text('Load More'),
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
