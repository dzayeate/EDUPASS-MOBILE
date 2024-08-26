import 'package:edupass_mobile/api/shared_preferences/user_id_manager.dart';
import 'package:mime/mime.dart';
import 'package:dio/dio.dart';
import 'package:edupass_mobile/api/shared_preferences/biodate_id_manager.dart';
import 'package:edupass_mobile/api/shared_preferences/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

class AuthService {
  static String? token;
  static String? bioDateId;
  static String? idUser;

  final TokenManager tokenManager = TokenManager();
  final BiodateIdManager biodateIdManager = BiodateIdManager();
  final UserIdManager userIdManager = UserIdManager();

// forget password
  Future<bool> forgetPassword({
    required String email,
  }) async {
    try {
      var response = await Dio().post(
        "http://192.168.1.4:3000/user/forgot-password",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        data: {
          "email": email,
        },
      );
      if (response.statusCode == 201) {
        // Send Email successful
        return true;
      } else {
        throw Exception('Email Berhasil Dikirim: ${response.data['message']}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        debugPrint('Error 400: ${e.response?.data}');
        throw Exception('Invalid email');
      } else {
        debugPrint('Error: ${e.toString()}');
        throw Exception('Failed to send Email');
      }
    }
  }

// login
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await Dio().post(
        "http://192.168.1.4:3000/auth/login",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          Map<String, dynamic> responseData = response.data;
          Map<String, dynamic> data = responseData['data'];
          token = data['token'];
          bioDateId = data['biodateId'];
          idUser = data['id'];

          // Simpan token ke SharedPreferences
          await tokenManager.saveToken(token!);

          // Simpan biodateId ke SharedPreferences
          await biodateIdManager.saveBiodateId(bioDateId!);

          // Simpan token ke SharedPreferences
          await userIdManager.saveId(idUser!);

          // Verify that biodateId was saved correctly
          String? savedBiodateId = await biodateIdManager.getBiodateId();
          debugPrint('Saved BiodateId: $savedBiodateId');

          // Verify that User ID was saved correctly
          String? savedUserId = await userIdManager.getId();
          debugPrint('Saved BiodateId: $savedUserId');

          return true;
        } else {
          throw Exception('Failed to parse data');
        }
      } else if (response.statusCode == 401) {
        throw Exception(response.data['message'] ?? 'Unauthorized');
      } else {
        throw Exception('Failed to login');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        debugPrint('Error 400: ${e.response?.data}');
        throw Exception('Invalid email or password');
      } else {
        debugPrint('Error: ${e.toString()}');
        throw Exception('Failed to login');
      }
    }
  }

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
        "http://192.168.1.4:3000/auth/register",
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

// Update Bio
  Future<bool> updateBio({
    required String firstName,
    required String lastName,
    required String birthDate,
    required String gender,
    required String phone,
    required String address,
    required String province,
    required String regencies,
    required String institutionName,
    required String pupils,
    required String field,
    String? image,
    String? proof,
  }) async {
    String? token = await tokenManager.getToken();
    String? bioDateId = await biodateIdManager.getBiodateId();
    try {
      // Create a Map for form data
      Map<String, dynamic> formDataMap = {
        "firstName": firstName,
        "lastName": lastName,
        "birthDate": birthDate,
        "gender": gender,
        "phone": phone,
        "address": address,
        "province": province,
        "regencies": regencies,
        "institutionName": institutionName,
        "field": field,
        "pupils": pupils,
      };

      // Get MIME type for the proof file and add to formDataMap if not null
      if (proof != null && proof.isNotEmpty) {
        String? proofMimeType = lookupMimeType(proof);
        if (proofMimeType != null) {
          // Check if the file is a PDF, JPG, JPEG, or PNG
          if (proofMimeType == 'application/pdf' ||
              proofMimeType == 'image/jpeg' ||
              proofMimeType == 'image/jpg' ||
              proofMimeType == 'image/png') {
            MultipartFile proofMultipartFile = await MultipartFile.fromFile(
              proof,
              filename: 'proof.${proofMimeType.split('/').last}',
              contentType: MediaType.parse(proofMimeType),
            );
            formDataMap["proof"] = proofMultipartFile;
          } else {
            debugPrint('The file is not a valid type');
            throw Exception('The file is not a valid type');
          }
        } else {
          debugPrint('Invalid proof MIME type');
          throw Exception('Invalid proof MIME type');
        }
      }
      // Get MIME type for the files and add to formDataMap if not null
      // if (proof != null && proof.isNotEmpty) {
      //   String? proofMimeType = lookupMimeType(proof);
      //   if (proofMimeType != null) {
      //     MultipartFile proofMultipartFile = await MultipartFile.fromFile(
      //       proof,
      //       filename: 'proof.pdf',
      //       contentType: MediaType.parse(proofMimeType),
      //     );
      //     formDataMap["proof"] = proofMultipartFile;
      //   } else {
      //     debugPrint('Invalid proof MIME type');
      //   }
      // }

      if (image != null && image.isNotEmpty) {
        String? imageMimeType = lookupMimeType(image);
        if (imageMimeType != null) {
          MultipartFile imageMultipartFile = await MultipartFile.fromFile(
            image,
            filename: 'image.png',
            contentType: MediaType.parse(imageMimeType),
          );
          formDataMap["image"] = imageMultipartFile;
        } else {
          debugPrint('Invalid image MIME type');
        }
      }

      var response = await Dio().put(
        "http://192.168.1.4:3000/user/update-biodate?id=$bioDateId",
        data: FormData.fromMap(formDataMap),
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $token"
          },
        ),
      );

      if (response.statusCode == 200) {
        // Update successful
        return true;
      } else {
        throw Exception('Failed to Update Bio : ${response.data['message']}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        debugPrint('Error 400: ${e.response?.data}');
        throw Exception('Update Bio failed: ${e.response?.data['message']}');
      } else {
        debugPrint('Error: ${e.toString()}');
        throw Exception('Failed to Update Bio');
      }
    }
  }

// logout
  Future<void> logout() async {
    String? token = await tokenManager.getToken();
    try {
      var response = await Dio().post(
        "http://192.168.1.4:3000/auth/logout",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (response.statusCode == 200) {
        // Hapus token dari SharedPreferences
        await tokenManager.deleteToken();
        await biodateIdManager.deleteBiodateId();
      } else {
        throw Exception('Failed to logout');
      }
    } on DioException catch (e) {
      debugPrint('Error: ${e.toString()}');
      throw Exception('Failed to logout');
    }
  }

// change password
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    String? token = await tokenManager.getToken();
    try {
      var response = await Dio().post(
        "http://192.168.1.4:3000/user/change-password",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
        data: {
          "oldPassword": oldPassword,
          "newPassword": newPassword,
          "confirmPassword": confirmPassword,
        },
      );
      if (response.statusCode == 200) {
        // Hapus token dari SharedPreferences
        return true;
      } else {
        throw Exception('Failed to change password');
      }
    } on DioException catch (e) {
      debugPrint('Error: ${e.toString()}');
      throw Exception('Failed to change password');
    }
  }

  // change role
  Future<bool> changeRole({
    required String roleName,
  }) async {
    String? token = await tokenManager.getToken();
    try {
      var response = await Dio().post(
        "http://192.168.1.4:3000/user/change-role",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
        data: {
          "roleName": roleName,
        },
      );
      if (response.statusCode == 200) {
        // Hapus token dari SharedPreferences
        return true;
      } else {
        throw Exception('Failed to change role');
      }
    } on DioException catch (e) {
      debugPrint('Error: ${e.toString()}');
      throw Exception('Failed to change role');
    }
  }
}
