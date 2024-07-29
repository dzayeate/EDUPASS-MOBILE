import 'package:edupass_mobile/api/competition/get/get_comp_service.dart';
import 'package:flutter/material.dart';

class GetCompetitionController with ChangeNotifier {
  final GetCompetitionService _competitionService = GetCompetitionService();

  List<dynamic> _competitions = [];
  bool _isLoading = false;
  String? _errorMessage;
  int _currentPage = 1;
  int _length = 2; // Batasi jumlah data per halaman
  int _total = 0;
  bool _isLoadMore = false;

  List<dynamic> get competitions => _competitions;
  bool get isLoading => _isLoading || _isLoadMore;
  String? get errorMessage => _errorMessage;
  int get currentPage => _currentPage;
  int get total => _total;

  // get all competition
  Future<void> fetchCompetitions() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _competitionService.getCompetitions(1, _length);
      _competitions = data['data'];
      _total = data['total'];
      _currentPage = 1; // Reset current page
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // search competition
  Future<void> searchCompetitions(String query) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _competitionService.searchCompetitions(query);
      _competitions = data['data'];
      _total = data['total'];
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // filter search
  Future<void> fetchFilteredCompetitions(String filter) async {
    _isLoading = true;
    notifyListeners();
    try {
      final data = await _competitionService.searchCompetitionsByFilter(filter);
      _competitions = data['data']; // Memastikan data sesuai dengan respons API
      _total = data['total'];
      _errorMessage = null;
      debugPrint('Filtered Competitions: $_competitions');
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('Error fetching filtered competitions: $_errorMessage');
    }
    _isLoading = false;
    notifyListeners();
  }

  void loadMore() async {
    if (_competitions.length < _total && !_isLoadMore) {
      _currentPage++;
      _isLoadMore = true;
      notifyListeners();

      try {
        final data =
            await _competitionService.getCompetitions(_currentPage, _length);
        _competitions.addAll(data['data']);
      } catch (e) {
        _errorMessage = e.toString();
      } finally {
        _isLoadMore = false;
        notifyListeners();
      }
    }
  }
}
