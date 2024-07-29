import 'package:mime/mime.dart';
import 'package:dio/dio.dart';
import 'package:edupass_mobile/api/shared_preferences/biodate_id_manager.dart';
import 'package:edupass_mobile/api/shared_preferences/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

class RegisterCompetitionService {
  static String? token;
  static String? bioDateId;

  final TokenManager tokenManager = TokenManager();
  final BiodateIdManager biodateIdManager = BiodateIdManager();

  // register competition
  Future<bool> registerCompetition({
    required String competitionId,
    required String domicile,
    required String phoneNumber,
    String? docs,
    required bool isTeam,
    required int teamSize,
    required List<String> teamMembers,
  }) async {
    String? token = await tokenManager.getToken();
    String? bioDateId = await biodateIdManager.getBiodateId();
    try {
      // Create a Map for form data
      Map<String, dynamic> formDataMap = {
        "competitionId": competitionId,
        "domicile": domicile,
        "phoneNumber": phoneNumber,
        "isTeam": isTeam,
        "teamSize": isTeam ? teamSize : 0,
        "teamMembers": teamMembers.join(','),
      };

      // Get MIME type for the files and add to formDataMap if not null
      if (docs != null && docs.isNotEmpty) {
        String? proofMimeType = lookupMimeType(docs);
        if (proofMimeType != null) {
          // Check if the file is a PDF
          if (proofMimeType == 'application/pdf') {
            MultipartFile proofMultipartFile = await MultipartFile.fromFile(
              docs,
              filename: 'docs.pdf',
              contentType: MediaType.parse(proofMimeType),
            );
            formDataMap["supportingDocuments"] = proofMultipartFile;
          } else {
            debugPrint('The file is not a PDF');
            throw Exception('The file is not a PDF');
          }
        } else {
          debugPrint('Invalid proof MIME type');
          throw Exception('Invalid proof MIME type');
        }
      }

      debugPrint('Sending registration data to server: $formDataMap');

      var response = await Dio().post(
        "http://192.168.1.4:3000/competition/register/peserta",
        data: FormData.fromMap(formDataMap),
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $token"
          },
        ),
      );

      if (response.statusCode == 201) {
        // Update successful
        return true;
      } else {
        throw Exception(
            'Failed to Register Competition: ${response.data['message']}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        debugPrint('Error 400: ${e.response?.data}');
        throw Exception(
            'Register Competition failed: ${e.response?.data['message']}');
      } else {
        debugPrint('Error: ${e.toString()}');
        throw Exception('Failed to Register Competition');
      }
    }
  }
}
