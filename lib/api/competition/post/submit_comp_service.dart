import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:edupass_mobile/api/shared_preferences/token_manager.dart';
import 'package:edupass_mobile/utils/constant.dart';

class SubmitCompetitionService {
  final TokenManager tokenManager = TokenManager();

  final Dio _dio;

  SubmitCompetitionService() : _dio = Dio() {
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  // register competition
  Future<bool> submitCompetition({
    required String registrationId,
    required String url,
  }) async {
    String? token = await tokenManager.getToken();

    try {
      // Create a Map for form data
      var response = await _dio.post(
        "${baseUrl}competition/submission",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
        data: {
          "registrationId": registrationId,
          "url": url,
        },
      );

      if (response.statusCode == 201) {
        // Update successful

        return true;
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception(e.response?.data['message']);
      } else {
        throw Exception('Failed to Register Competition');
      }
    }
  }
}
