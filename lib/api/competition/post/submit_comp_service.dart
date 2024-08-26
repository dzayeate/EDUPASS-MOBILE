import 'package:dio/dio.dart';
import 'package:edupass_mobile/api/competition/post/register_comp_service.dart';
import 'package:edupass_mobile/api/shared_preferences/token_manager.dart';

class SubmitCompetitionService {
  final TokenManager tokenManager = TokenManager();

  // register competition
  Future<bool> submitCompetition({
    required String registrationId,
    required String url,
  }) async {
    String? token = await tokenManager.getToken();

    try {
      // Create a Map for form data
      var response = await Dio().post(
        "http://192.168.1.4:3000/competition/submission",
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
