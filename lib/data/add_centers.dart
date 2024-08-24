import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Call the function to add centers to Firestore
  await addCentersToFirestore();

  print('All centers have been added!');
}

Future<void> addCentersToFirestore() async {
  // Get a reference to the Firestore collection
  CollectionReference centers = FirebaseFirestore.instance.collection('centers');

  // List of sample centers
  List<Map<String, String>> sampleCenters = [
    {
      "name": "City Health Clinic",
      "location": "123 Main St, Springfield",
      "vaccine": "Pfizer",
      "availability": "100 doses available"
    },
    {
      "name": "Downtown Medical Center",
      "location": "456 Elm St, Springfield",
      "vaccine": "Moderna",
      "availability": "50 doses available"
    },
    {
      "name": "Northside Hospital",
      "location": "789 Oak St, Springfield",
      "vaccine": "Johnson & Johnson",
      "availability": "75 doses available"
    },
    {
      "name": "Springfield Community Health",
      "location": "321 Maple St, Springfield",
      "vaccine": "Pfizer",
      "availability": "200 doses available"
    },
    {
      "name": "Eastside Family Clinic",
      "location": "654 Pine St, Springfield",
      "vaccine": "Moderna",
      "availability": "120 doses available"
    },
    {
      "name": "West End Health Center",
      "location": "987 Cedar St, Springfield",
      "vaccine": "Pfizer",
      "availability": "80 doses available"
    },
    {
      "name": "South Health Services",
      "location": "111 Birch St, Springfield",
      "vaccine": "Johnson & Johnson",
      "availability": "90 doses available"
    },
    {
      "name": "Riverside Medical Center",
      "location": "222 Willow St, Springfield",
      "vaccine": "Pfizer",
      "availability": "150 doses available"
    },
    {
      "name": "Central Health Hub",
      "location": "333 Ash St, Springfield",
      "vaccine": "Moderna",
      "availability": "110 doses available"
    },
    {
      "name": "Lakeside Community Clinic",
      "location": "444 Spruce St, Springfield",
      "vaccine": "Pfizer",
      "availability": "130 doses available"
    }
  ];

  // Add each center to Firestore
  for (var center in sampleCenters) {
    await centers.add(center);
    print('Added center: ${center['name']}');
  }
}
