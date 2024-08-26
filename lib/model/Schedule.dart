class Schedule {
  final String id;
  final DateTime date;
  final String vaccineName;
  final String center; // Changed from VaccinationCenter to String
  final String additionalInfo;
  final String userId;

  Schedule({
    required this.id,
    required this.date,
    required this.vaccineName,
    required this.center, // Handle as string
    required this.additionalInfo,
    required this.userId,
  });

  factory Schedule.fromMap(Map<String, dynamic> data) {
    return Schedule(
      id: data['id'] ?? '',
      date: DateTime.parse(data['date']), // Ensure the date is parsed correctly
      vaccineName: data['vaccineName'] ?? '',
      center: data['center'] ?? '', // Just store the string as it is
      additionalInfo: data['additionalInfo'] ?? '',
      userId: data['userId'] ?? '',
    );
  }
}
