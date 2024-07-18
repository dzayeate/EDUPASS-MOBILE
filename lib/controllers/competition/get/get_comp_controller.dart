import 'package:edupass_mobile/api/competition/get/get_comp_service.dart';
import 'package:flutter/material.dart';

class GetCompetitionController with ChangeNotifier {
  final GetCompetitionService _competitionService = GetCompetitionService();

  List<dynamic> _competitions = [];
  bool _isLoading = false;
  String? _errorMessage;
  int _currentPage = 1;
  int _length = 10;
  int _total = 0;

  List<dynamic> get competitions => _competitions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get currentPage => _currentPage;
  int get total => _total;

  // get all competition
  Future<void> fetchCompetitions() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data =
          await _competitionService.getCompetitions(_currentPage, _length);
      _competitions = data['data'];
      _total = data['total'];
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

  void loadMore() {
    if (_competitions.length < _total) {
      _currentPage++;
      fetchCompetitions();
    }
  }
}
