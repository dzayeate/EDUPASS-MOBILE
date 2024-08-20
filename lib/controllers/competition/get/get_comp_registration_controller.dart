import 'package:edupass_mobile/api/competition/get/get_comp_registration_service.dart';
import 'package:edupass_mobile/models/event/comp_registration_model.dart';

class CompRegistrationController {
  final FindCompetitionService _service;

  CompRegistrationController(this._service);

  Future<List<CompetitionRegistration>> getRegistrations(String userId) async {
    return await _service.fetchRegistrations(userId);
  }
}
