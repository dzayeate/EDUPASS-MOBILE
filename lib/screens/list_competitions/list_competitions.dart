import 'package:edupass_mobile/controllers/competition/get/get_comp_controller.dart';
import 'package:edupass_mobile/screens/home/components/event_card.dart';
import 'package:edupass_mobile/screens/home/components/filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ListCompetitions extends StatefulWidget {
  const ListCompetitions({super.key});

  @override
  State<ListCompetitions> createState() => _ListCompetitionsState();
}

class _ListCompetitionsState extends State<ListCompetitions> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'List Competitions',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              onChanged: (value) {
                if (value.isNotEmpty) {
                  Provider.of<GetCompetitionController>(context, listen: false)
                      .searchCompetitions(value);
                } else {
                  Provider.of<GetCompetitionController>(context, listen: false)
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
            // Event Cards
            Expanded(
              child: Consumer<GetCompetitionController>(
                builder: (context, competitionController, child) {
                  if (competitionController.isLoading &&
                      competitionController.competitions.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
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
                          const Text(
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
                            child: const Text('Refresh'),
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
                          itemCount: competitionController.competitions.length +
                              (competitionController.isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index ==
                                competitionController.competitions.length) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final competition =
                                competitionController.competitions[index];
                            // Mendapatkan previewUrl dan melakukan validasi
                            final String? previewUrl =
                                competition['thumbnail']['previewUrl'] != "null"
                                    ? competition['thumbnail']['previewUrl']
                                    : null;
                            return EventCard(
                              id: competition['id'],
                              title: competition['name'],
                              startDate: competition['startDate'],
                              endDate: competition['endDate'],
                              location: competition['location'],
                              peopleRegistered: competition['registrationCount']
                                  .toString(), // Data ini tidak ada di API
                              label: competition[
                                  'category'], // Data ini tidak ada di API
                              labelTwo: competition[
                                  'platform'], // Data ini tidak ada di API
                              imageUrl: previewUrl != null
                                  ? previewUrl.replaceFirst(
                                      "localhost", "192.168.1.4")
                                  : null,
                              // imageUrl:
                              //     'assets/images/competition_1.png', // Adjust image asset

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
    );
  }
}
