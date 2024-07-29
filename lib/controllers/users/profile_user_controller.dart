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
}
