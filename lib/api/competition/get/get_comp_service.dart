import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:edupass_mobile/utils/constant.dart';

class GetCompetitionService {
  final Dio _dio;

  GetCompetitionService() : _dio = Dio() {
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<Map<String, dynamic>> getCompetitions(int page, int length) async {
    try {
      final response = await _dio.get(
<<<<<<< HEAD
        '${baseUrl}competition/findCompetition',
=======
        'http://103.141.61.6/competition/findCompetition',
>>>>>>> main
        queryParameters: {
          'page': page,
          'length': length,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load competitions');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // search kompetisi
  Future<Map<String, dynamic>> searchCompetitions(String query) async {
    try {
      final response = await _dio.get(
<<<<<<< HEAD
        '${baseUrl}competition/findCompetition',
=======
        'http://103.141.61.6/competition/findCompetition',
>>>>>>> main
        queryParameters: {
          'page': 1,
          'length': 10,
          'search': query,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to search competitions');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Filter Search
  Future<Map<String, dynamic>> searchCompetitionsByFilter(String filter) async {
    try {
      final response = await _dio.get(
<<<<<<< HEAD
        '${baseUrl}competition/findCompetition',
=======
        'http://103.141.61.6/competition/findCompetition',
>>>>>>> main
        queryParameters: {
          'page': 1,
          'length': 5,
          'search': filter,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to search competitions by filter');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Search By Id
  Future<Map<String, dynamic>> getCompetitionDetail(String id) async {
    try {
      final response = await _dio.get(
<<<<<<< HEAD
        '${baseUrl}competition/findCompetition',
=======
        'http://103.141.61.6/competition/findCompetition',
>>>>>>> main
        queryParameters: {
          'page': 1,
          'length': 1,
          'search': id,
        },
      );

      if (response.statusCode == 200) {
        if (response.data['data'] != null && response.data['data'].isNotEmpty) {
          return response.data['data'][0];
        } else {
          throw Exception('No competition found with the given ID');
        }
      } else {
        throw Exception('Failed to load competition detail');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
