import 'package:dio/dio.dart';
import 'package:edupass_mobile/api/shared_preferences/biodate_id_manager.dart';
import 'package:edupass_mobile/api/shared_preferences/token_manager.dart';
import 'package:flutter/material.dart';

class GetUserService {
  final TokenManager tokenManager = TokenManager();
  final BiodateIdManager biodateIdManager = BiodateIdManager();

  Future<Map<String, dynamic>?> getUserByBiodateId() async {
    String? biodate = await biodateIdManager.getBiodateId();
    try {
      var response = await Dio().get(
        "http://192.168.1.5:3000/user/getUser",
        queryParameters: {"page": 1, "length": 1, "queryParameters": biodate},
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> userDataList = response.data['data'];
        if (userDataList.isNotEmpty) {
          // Cari user berdasarkan biodateId
          var userData = userDataList.firstWhere(
              (user) => user['biodate']['id'] == biodate,
              orElse: () => null);
          return userData;
        } else {
          throw Exception('User not found');
        }
      } else {
        throw Exception('Failed to get user data');
      }
    } on DioException catch (e) {
      debugPrint('Error: $e');
      throw Exception('Failed to get user data');
    }
  }

  // Future<Map<String, dynamic>?> getUserByBiodateId() async {
  //   String? biodateId = await biodateIdManager.getBiodateId();
  //   try {
  //     var response = await Dio().get(
  //       "http://192.168.1.5:3000/user/getUser?page=1&length=1&search=$biodateId",
  //       options: Options(
  //         headers: {
  //           "Content-Type": "application/json",
  //         },
  //       ),
  //     );

  //     //  // Debug print to check URL and query parameters
  //     // debugPrint('Hitting URL: $url with query parameters: $queryParameters');
  //     // // Debug print to check the response
  //     // debugPrint('Response: ${response.data}');
  //     if (response.statusCode == 200) {
  //       List<dynamic> userDataList = response.data['data'];
  //       if (userDataList.isNotEmpty) {
  //         var userData = userDataList.first;
  //         return userData;
  //       } else {
  //         throw Exception('User not found');
  //       }
  //     } else {
  //       throw Exception('Failed to get user data');
  //     }
  //   } on DioException catch (e) {
  //     debugPrint('Error: $e');
  //     throw Exception('Failed to get user data');
  //   }
  // }

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
