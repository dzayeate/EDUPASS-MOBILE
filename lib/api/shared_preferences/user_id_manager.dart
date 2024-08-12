import 'package:shared_preferences/shared_preferences.dart';

class UserIdManager {
  Future<void> saveId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  Future<String?> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    // debugPrint('Retrieved userId: $userId');
    return userId;
  }

  Future<void> deleteId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
  }

  // Fungsi untuk memeriksa userId
  Future<void> checkUserId() async {
    String? userId = await getId();
    // debugPrint('userId yang tersimpan: $userId');
  }
}
