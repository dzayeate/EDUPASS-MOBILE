import 'package:mime/mime.dart';
import 'package:dio/dio.dart';
import 'package:edupass_mobile/api/shared_preferences/biodate_id_manager.dart';
import 'package:edupass_mobile/api/shared_preferences/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterCompetitionService {
  static String? registrationId;

  final TokenManager tokenManager = TokenManager();
  final BiodateIdManager biodateIdManager = BiodateIdManager();
  final RegistrationIdManager regsitrationIdManager = RegistrationIdManager();

  // register competition
  Future<bool> registerCompetition({
    required String competitionId,
    required String domicile,
    required String phoneNumber,
    String? docs,
    String? teamName,
    required bool isTeam,
    required int teamSize,
    required List<String> teamMembers,
  }) async {
    String? token = await tokenManager.getToken();
    try {
      // Create a Map for form data
      Map<String, dynamic> formDataMap = {
        "competitionId": competitionId,
        "domicile": domicile,
        "phoneNumber": phoneNumber,
        "isTeam": isTeam,
        "nameTeam": teamName ?? "",
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
        if (response.data is Map<String, dynamic>) {
          Map<String, dynamic> responseData = response.data;
          Map<String, dynamic> data = responseData['data'];
          registrationId = data['id'];

          // Simpan token ke SharedPreferences
          await regsitrationIdManager.saveId(registrationId!);

          return true;
        } else {
          throw Exception('Failed to parse data');
        }
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

class RegistrationIdManager {
  Future<void> saveId(String registrationId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('registrationId', registrationId);
  }

  Future<String?> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? registrationId = prefs.getString('registrationId');
    // debugPrint('Retrieved registrationId: $registrationId');
    return registrationId;
  }

  Future<void> deleteId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('registrationId');
  }

  // Fungsi untuk memeriksa registrationId
  Future<void> checkregistrationId() async {
    String? registrationId = await getId();
    // debugPrint('registrationId yang tersimpan: $registrationId');
  }
}
