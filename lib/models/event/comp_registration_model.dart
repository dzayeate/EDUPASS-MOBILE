class CompetitionRegistration {
  final String id;
  final String competitionId;
  final String nameTeam;
  final String domicile;
  final String phoneNumber;
  final bool isTeam;
  final int? teamSize;
  final String competitionName;
  final DateTime createdAt;

  CompetitionRegistration({
    required this.id,
    required this.competitionId,
    required this.nameTeam,
    required this.domicile,
    required this.phoneNumber,
    required this.isTeam,
    required this.competitionName,
    this.teamSize,
    required this.createdAt,
  });

  factory CompetitionRegistration.fromJson(Map<String, dynamic> json) {
    return CompetitionRegistration(
      id: json['id'],
      competitionId: json['competitionId'],
      nameTeam: json['nameTeam'] ?? '',
      domicile: json['domicile'],
      phoneNumber: json['phoneNumber'],
      isTeam: json['isTeam'],
      competitionName: json['competition']['name'] ?? '',
      teamSize: json['teamSize'] ?? null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
