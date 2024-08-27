import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/Schedule.dart';
import 'new_schedule_screen.dart';
import 'edit_schedule_screen.dart';

class Weather {
  final String description;
  final double temperature;
  final String icon;

  Weather({required this.description, required this.temperature, required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
      icon: json['weather'][0]['icon'],
    );
  }
}

Future<Weather?> fetchWeather(String cityName) async {
  final apiKey = 'e0e474f8371d0c089d99da6a85a699fc';
  final url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return Weather.fromJson(json);
  } else {
    return null;
  }
}

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Weather?>? _weatherFuture;
  String userName = '';

  @override
  void initState() {
    super.initState();
    _weatherFuture = fetchWeather('Montreal'); // Replace with your desired city
    _getUserName();
  }

  Future<void> _getUserName() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        userName = userDoc['name'] ?? 'No Name';
      });
    }
  }

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/sign-in');
  }

  Stream<List<Map<String, dynamic>>> _getSchedules(User? user) {
    String userId = user!.uid;

    if (user.email == 'admin@gmail.com') {
      return FirebaseFirestore.instance
          .collection('schedules')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();
      });
    } else {
      return FirebaseFirestore.instance
          .collection('schedules')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();
      });
    }
  }

  Future<String> _getUserNameById(String userId) async {
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      return userDoc['name'] ?? 'No Name';
    } catch (e) {
      print("Error fetching user name: $e");
      return 'No Name';
    }
  }

  Future<void> _deleteSchedule(String scheduleId) async {
    try {
      await FirebaseFirestore.instance
          .collection('schedules')
          .doc(scheduleId)
          .delete();
    } catch (e) {
      print("Error deleting schedule: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    final List<Color> cardColors = [
      Colors.lightBlueAccent,
      Colors.lightGreenAccent,
      Colors.green,
      Colors.lime,
      Colors.yellow,
      Colors.purple,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<Weather?>(
            future: _weatherFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading weather data.'));
              } else if (snapshot.hasData) {
                final weather = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Image.network(
                        'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Today\'s Weather: ${weather.description}',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${weather.temperature.toStringAsFixed(1)}°C',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('No weather data available.'));
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Welcome, $userName',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Here is your schedule list. Manage your appointments, add new ones, or edit existing ones.',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 16.0), // Space between the welcome message and schedule list
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _getSchedules(user),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No schedules available.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final scheduleData = snapshot.data![index];
                      final schedule = Schedule.fromMap(scheduleData);
                      final color = cardColors[index % cardColors.length];

                      return FutureBuilder<String>(
                        future: _getUserNameById(scheduleData['userId']),
                        builder: (context, userSnapshot) {
                          String displayName = 'No Name';
                          if (userSnapshot.connectionState == ConnectionState.done) {
                            displayName = userSnapshot.data ?? 'No Name';
                          }

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            color: color,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.vaccines, color: Colors.green[800]),
                                          const SizedBox(width: 8.0),
                                          Text(
                                            schedule.vaccineName,  // This should display the vaccine name
                                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit, color: Colors.blue),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) => EditScheduleScreen(schedule: schedule),
                                                ),
                                              );
                                            },
                                            tooltip: 'Edit Schedule',
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: () {
                                              _deleteSchedule(schedule.id); // Pass the schedule ID to delete
                                            },
                                            tooltip: 'Delete Schedule',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  if (user?.email == 'admin@gmail.com') ...[
                                    Row(
                                      children: [
                                        Icon(Icons.person, color: Colors.blueGrey),
                                        const SizedBox(width: 8.0),
                                        Text(
                                          'Name: $displayName', // Display the user name if admin
                                          style: const TextStyle(color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ],
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today, color: Colors.blue[800]),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        'Date: ${schedule.date.toLocal().toString().split(' ')[0]}',
                                        style: const TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, color: Colors.red[800]),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        'Center: ${schedule.center}',
                                        style: const TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Icon(Icons.info, color: Colors.orange[800]),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: Text(
                                          'Notes: ${schedule.additionalInfo ?? 'None'}',
                                          style: const TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => NewScheduleScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
