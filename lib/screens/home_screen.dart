import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/Schedule.dart';
import 'new_schedule_screen.dart';

class HomeScreen extends StatelessWidget {
  final String title;

  const HomeScreen({Key? key, required this.title}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/sign-in');
  }

  Stream<List<Schedule>> _getSchedules() {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('schedules')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      print('Documents fetched: ${snapshot.docs.length}');
      return snapshot.docs.map((doc) {
        print('Document data: ${doc.data()}');
        return Schedule.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String userEmail = user?.email ?? 'No Email';

    // Define a list of colors to use for the cards
    final List<Color> cardColors = [
      Colors.teal[100]!,
      Colors.orange[100]!,
      Colors.purple[100]!,
      Colors.blue[100]!,
      Colors.green[100]!,
      Colors.red[100]!,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: StreamBuilder<List<Schedule>>(
        stream: _getSchedules(),
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
                final schedule = snapshot.data![index];
                // Choose a color based on the index
                final color = cardColors[index % cardColors.length];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  color: color,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.vaccines, color: Colors.green[800]),
                            const SizedBox(width: 8.0),
                            Text(
                              schedule.vaccineName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
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
                                'Additional Info: ${schedule.additionalInfo}',
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
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => NewScheduleScreen()),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Add Schedule',
      ),
    );
  }
}
