import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String id;
  final String userId;
  final String vaccineName;
  final DateTime date;
  final String additionalInfo;
  final String center;

  Schedule({
    required this.id,
    required this.userId,
    required this.vaccineName,
    required this.date,
    required this.additionalInfo,
    required this.center,
  });

  factory Schedule.fromMap(Map<String, dynamic> data) {
    return Schedule(
      id: data['id'] ?? '',
      userId: data['userId'] ?? '',
      vaccineName: data['vaccineName'] ?? '',
      date: (data['date'] as Timestamp).toDate(), // Convert Timestamp to DateTime
      additionalInfo: data['additionalInfo'] ?? '',
      center: data['center'] ?? '',
    );
  }
}
