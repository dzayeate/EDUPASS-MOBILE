import 'package:edupass_mobile/api/get_user/get_user_service.dart';

class UserDetailsFetcher {
  final GetUserService _userService = GetUserService();

  Future<List<Map<String, String>>> fetchUserDetails(
      List<dynamic> users) async {
    List<Map<String, String>> userDetailsList = [];

    for (var user in users) {
      var userDetails = await _userService.getOrganizer(user['userId']);
      if (userDetails != null) {
        var biodata = userDetails['biodate'];
        userDetailsList.add({
          'firstName': biodata['firstName'],
          'lastName': biodata['lastName']
        });
      }
    }

    return userDetailsList;
  }
}
