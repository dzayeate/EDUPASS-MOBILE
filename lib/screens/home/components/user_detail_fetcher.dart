import 'package:edupass_mobile/api/get_user/get_user_service.dart';
import 'package:flutter/material.dart';

class UserDetailsFetcher {
  final GetUserService _userService = GetUserService();

  Future<List<Map<String, String>>> fetchUserDetails(
      List<dynamic> users) async {
    List<Map<String, String>> userDetailsList = [];

    for (var user in users) {
      try {
        var userDetails = await _userService.getOrganizer(user['userId']);

        if (userDetails != null && userDetails['biodate'] != null) {
          var biodata = userDetails['biodate'];
          userDetailsList.add({
            'firstName': biodata['firstName'] ?? '',
            'lastName': biodata['lastName'] ?? '',
          });
        } else {
          debugPrint('No user details found for userId: ${user['userId']}');
        }
      } catch (e) {
        debugPrint('Error fetching details for userId ${user['userId']}: $e');
      }
    }

    return userDetailsList;
  }
}
