import 'package:dio/dio.dart';
import 'package:edupass_mobile/api/shared_preferences/biodate_manager.dart';
import 'package:edupass_mobile/api/shared_preferences/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static String? token;
  static String? bioDateId;

  final TokenManager tokenManager = TokenManager();
  final BiodateIdManager biodateIdManager = BiodateIdManager();

// forget password
  Future<bool> forgetPassword({
    required String email,
  }) async {
    try {
      var response = await Dio().post(
        "http://192.168.1.5:3000/user/forgot-password",
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
        "http://192.168.1.5:3000/auth/login",
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

          // Simpan token ke SharedPreferences
          await tokenManager.saveToken(token!);

          // Simpan biodateId ke SharedPreferences
          await biodateIdManager.saveBiodateId(bioDateId!);

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
        "http://192.168.1.5:3000/auth/register",
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
    required String image,
    required String institutionName,
    required String pupils,
    required String field,
    required String proof,
  }) async {
    String? token = await tokenManager.getToken();
    String? bioDateId = await biodateIdManager.getBiodateId();
    try {
      var response = await Dio().put(
        "http://192.168.1.5:3000/user/update-biodate?id=$bioDateId",
        data: FormData.fromMap({
          "firstName": firstName,
          "lastName": lastName,
          "birthDate": birthDate,
          "gender": gender,
          "phone": phone,
          "address": address,
          "province": province,
          "regencies": regencies,
          "image": image,
          "institutionName": institutionName,
          "field": field,
          "pupils": pupils,
          "proof": proof,
        }),
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $token"
          },
        ),
      );

      if (response.statusCode == 201) {
        // Registration successful
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
        "http://192.168.1.5:3000/auth/logout",
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
        "http://192.168.1.5:3000/user/change-password",
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
}
  // // SharedPrefs Token
  // Future<void> saveToken(String token) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('token', token);
  // }

  // Future<String?> getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token');
  // }

  // Future<void> deleteToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('token');
  // }

  // Future<bool> isLoggedIn() async {
  //   String? token = await getToken();
  //   return token != null;
  // }

  // // Fungsi untuk memeriksa token
  // Future<void> checkToken() async {
  //   String? token = await getToken();
  //   debugPrint('Token yang tersimpan: $token');
  // }

  // // SharedPrefs Biodate Id
  // Future<void> savebiodateId(String biodateId) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('biodateId', biodateId);
  // }

  // Future<String?> getbiodateId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('biodateId');
  // }

  // Future<void> deletebiodateId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('biodateId');
  // }

  // // Fungsi untuk memeriksa biodateId
  // Future<void> checkbiodateId() async {
  //   String? biodateId = await getbiodateId();
  //   debugPrint('biodateId yang tersimpan: $biodateId');
  // }


//   Future<bool> register({
//     required String email,
//     required String password,
//     required String confirmPassword,
//     required String roleName,
//     required String firstName,
//     required String lastName,
//     required String nik,
//     required String institutionName,
//     required String institutionLevel,
//     required String province,
//     required String regencies,
//     required String studyField,
//     required String reason,
//     required String image,
//   }) async {
//     try {
//       var response = await Dio().post(
//         "http://192.168.1.7:3000/auth/register",
//         data: FormData.fromMap({
//           "email": email,
//           "password": password,
//           "confirmPassword": confirmPassword,
//           "roleName": roleName,
//           "firstName": firstName,
//           "lastName": lastName,
//           "nik": nik,
//           "institutionName": institutionName,
//           "institutionLevel": institutionLevel,
//           "province": province,
//           "regencies": regencies,
//           "studyField": studyField,
//           "reason": reason,
//           "image": image,
//         }),
//         options: Options(
//           headers: {
//             "Content-Type": "multipart/form-data",
//           },
//         ),
//       );

//       if (response.statusCode == 201) {
//         // Registration successful
//         return true;
//       } else {
//         throw Exception('Failed to register: ${response.data['message']}');
//       }
//     } on DioException catch (e) {
//       if (e.response?.statusCode == 400) {
//         debugPrint('Error 400: ${e.response?.data}');
//         throw Exception('Registration failed: ${e.response?.data['message']}');
//       } else {
//         debugPrint('Error: ${e.toString()}');
//         throw Exception('Failed to register');
//       }
//     }
//   }
// }
// }
