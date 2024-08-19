import 'package:edupass_mobile/api/get_user/get_user_service.dart';
import 'package:flutter/material.dart';

class ProfileUserController extends ChangeNotifier {
  final GetUserService userService = GetUserService();
  Map<String, dynamic>? userData;
  bool isLoading = true;

  ProfileUserController() {
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final data = await userService.getUserByBiodateId();
      userData = data;
      debugPrint('Usedata: $userData');
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void retryFetchUserData() {
    isLoading = true;
    notifyListeners();
    _fetchUserData();
  }

  bool isStudentOrMahasiswa() {
    final roleName = userData?['role']?['name'];
    return roleName == 'Siswa' || roleName == 'Mahasiswa';
  }

  List<ActivityField> getUserActivities() {
    if (userData != null && userData!['activities'] != null) {
      final activities = userData!['activities'] as List<dynamic>;
      return activities.map((json) => ActivityField.fromJson(json)).toList();
    }
    return [];
  }
}

class ActivityField {
  final String competitionName;
  final String competitionStartDate;
  final String competitionEndDate;
  final String status;

  ActivityField({
    required this.competitionName,
    required this.competitionStartDate,
    required this.competitionEndDate,
    required this.status,
  });

  factory ActivityField.fromJson(Map<String, dynamic> json) {
    return ActivityField(
      competitionName: json['competitionName'],
      competitionStartDate: json['competitionStartDate'],
      competitionEndDate: json['competitionEndDate'],
      status: json['status'],
    );
  }
}
