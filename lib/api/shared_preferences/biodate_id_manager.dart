import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiodateIdManager {
  Future<void> saveBiodateId(String biodateId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('biodateId', biodateId);
  }

  Future<String?> getBiodateId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? biodateId = prefs.getString('biodateId');
    debugPrint('Retrieved BiodateId: $biodateId');
    return biodateId;
  }

  Future<void> deleteBiodateId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('biodateId');
  }

  // Fungsi untuk memeriksa biodateId
  Future<void> checkBiodateId() async {
    String? biodateId = await getBiodateId();
    debugPrint('BiodateId yang tersimpan: $biodateId');
  }
}
