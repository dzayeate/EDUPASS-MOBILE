import 'dart:io';

import 'package:dio/io.dart';
import 'package:mime/mime.dart';
import 'package:dio/dio.dart';
import 'package:edupass_mobile/api/shared_preferences/biodate_id_manager.dart';
import 'package:edupass_mobile/api/shared_preferences/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:edupass_mobile/utils/constant.dart';

class RegisterCompetitionService {
  final TokenManager tokenManager = TokenManager();
  final BiodateIdManager biodateIdManager = BiodateIdManager();

  final Dio _dio;

  RegisterCompetitionService() : _dio = Dio() {
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

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

      var response = await _dio.post(
        "${baseUrl}competition/register/peserta",
        data: FormData.fromMap(formDataMap),
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $token"
          },
        ),
      );

      if (response.statusCode == 201) {
        // // Update successful
        // if (response.data is Map<String, dynamic>) {
        //   Map<String, dynamic> responseData = response.data;
        //   Map<String, dynamic> data = responseData['data'];

        //   return true;
        // } else {
        //   throw Exception('Failed to parse data');
        // }
        return true;
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception(e.response?.data['message']);
      } else {
        throw Exception('${e.response?.data['message']}');
      }
    }
  }
}
