import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:edupass_mobile/models/event/event_model.dart';
import 'package:flutter/material.dart';
import 'package:edupass_mobile/utils/constant.dart';

class GetScheduledCompetitionService {
  final Dio _dio;

  GetScheduledCompetitionService() : _dio = Dio() {
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
// Get All Competition ( Pagination )
  Future<List<EventModel>> fetchCompetitionEvents() async {
    try {
      final response = await _dio.get(
        '${baseUrl}competition/findScheduleCompetition',
        queryParameters: {
          'page': 1,
          'length': 10,
        },
        options: Options(
          headers: {
            'accept': 'application/json',
          },
        ),
      );

      List<EventModel> events = (response.data['data'] as List)
          .map((event) => EventModel.fromJson(event))
          .toList();

      return events;
    } catch (e) {
      debugPrint('Error fetching competition events: $e');
      return [];
    }
  }
}
