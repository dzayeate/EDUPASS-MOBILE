import 'dart:io';
import 'package:mime/mime.dart';
import 'package:dio/dio.dart';
import 'package:edupass_mobile/api/shared_preferences/biodate_id_manager.dart';
import 'package:edupass_mobile/api/shared_preferences/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

class RegisterCompetitionService {
// register
  Future<bool> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required String birthDate,
    required String gender,
    required String phone,
    required String address,
    required String province,
    required String regencies,
    required String image,
    required String institutionName,
    required String pupils,
    required String field,
    required String proof,
  }) async {
    try {
      var response = await Dio().post(
        "http://192.168.1.5:3000/competition/register/peserta",
        data: FormData.fromMap({
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "firstName": "",
          "lastName": "",
          "birthDate": "",
          "gender": "",
          "phone": "",
          "address": "",
          "province": "",
          "regencies": "",
          "image": "",
          "institutionName": "",
          "field": "",
          "pupils": "",
          "proof": ""
        }),
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      if (response.statusCode == 201) {
        // Registration successful
        return true;
      } else {
        throw Exception('Failed to register: ${response.data['message']}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        debugPrint('Error 400: ${e.response?.data}');
        throw Exception('Registration failed: ${e.response?.data['message']}');
      } else {
        debugPrint('Error: ${e.toString()}');
        throw Exception('Failed to register');
      }
    }
  }
}
