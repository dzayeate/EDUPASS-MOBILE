import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:edupass_mobile/api/shared_preferences/biodate_id_manager.dart';
import 'package:edupass_mobile/api/shared_preferences/token_manager.dart';
import 'package:edupass_mobile/api/shared_preferences/user_id_manager.dart';
import 'package:edupass_mobile/utils/constant.dart';
import 'package:flutter/material.dart';

class GetUserService {
  final TokenManager tokenManager = TokenManager();
  final BiodateIdManager biodateIdManager = BiodateIdManager();
  final UserIdManager userIdManager = UserIdManager();

  final Dio _dio;

  GetUserService() : _dio = Dio() {
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<Map<String, dynamic>?> getUserByBiodateId() async {
    String? biodateId = await biodateIdManager.getBiodateId();
    // debugPrint('Biodate before API call: $biodateId');

    String? userId = await userIdManager.getId();
    // debugPrint('UserId before API call: $userId');

    if (biodateId == null || userId == null) {
      throw Exception('BiodateId or UserId is null');
    }

    try {
      var response = await _dio.get(
        "${baseUrl}user/getUser",
        queryParameters: {"page": 1, "length": 1, "search": userId},
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      // debugPrint('API Response: ${response.data}');

      if (response.statusCode == 200) {
        List<dynamic> userDataList = response.data['data'];
        // debugPrint('UserDataList: $userDataList');

        if (userDataList.isNotEmpty) {
          var userData = userDataList[0]; // Langsung ambil data pertama
          // debugPrint('UserData: $userData');
          return userData;
        } else {
          debugPrint('UserDataList is empty');
          throw Exception('User not found');
        }
      } else {
        debugPrint(
            'Failed to get user data, status code: ${response.statusCode}');
        throw Exception('Failed to get user data');
      }
    } on DioException catch (e) {
      debugPrint('Error: $e');
      throw Exception('Failed to get user data');
    }
  }

// Get Mentor & Sponsor
  Future<Map<String, dynamic>?> getOrganizer(String userId) async {
    try {
      var response = await _dio.get(
        "${baseUrl}user/getUser",
        queryParameters: {"page": 1, "length": 1, "search": userId},
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> userDataList = response.data['data'];

        if (userDataList.isNotEmpty) {
          return userDataList[0];
        } else {
          throw Exception('User not found');
        }
      } else {
        throw Exception('Failed to get user data');
      }
    } catch (e) {
      throw Exception('Failed to get user data: $e');
    }
  }

// Contoh penggunaan:
  void getUser() async {
    try {
      Map<String, dynamic>? userData = await getUserByBiodateId();
      if (userData != null) {
        debugPrint('User data: $userData');
        // Di sini Anda dapat memproses data user, termasuk biodata
      } else {
        debugPrint('User not found');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
