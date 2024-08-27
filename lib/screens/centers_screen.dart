import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'add_center_screen.dart';
import 'edit_center_screen.dart';

class CentersScreen extends StatelessWidget {
  const CentersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Centers'),
        centerTitle: true,
        actions: [
          if (user?.email == 'admin@gmail.com') // Show Add button only for admin
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _navigateToAddCenter(context);
              },
            ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('centers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading centers'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No centers available'));
          }

          final centers = snapshot.data!.docs;

          return ListView.builder(
            itemCount: centers.length,
            itemBuilder: (context, index) {
              final center = centers[index];
              return _buildCenterTile(context, center, user);
            },
          );
        },
      ),
    );
  }

  // Helper method to build a center tile
  Widget _buildCenterTile(BuildContext context, DocumentSnapshot center, User? user) {
    final name = center['name'];
    final location = center['location'];
    final vaccine = center['vaccine'];
    final availability = center['availability'];

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.local_hospital, color: Colors.deepPurple, size: 36),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Location: $location'),
            Text('Vaccine: $vaccine'),
            Text('Availability: $availability doses available'),
          ],
        ),
        trailing: user?.email == 'admin@gmail.com'
            ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _navigateToEditCenter(context, center);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteCenter(context, center.id);
              },
            ),
          ],
        )
            : const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Handle navigation to details or booking page
        },
      ),
    );
  }

  void _navigateToAddCenter(BuildContext context) {
    // Navigate to the add center screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddCenterScreen()),
    );
  }

  void _navigateToEditCenter(BuildContext context, DocumentSnapshot center) {
    // Navigate to the edit center screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCenterScreen(
          centerId: center.id,
          name: center['name'],
          location: center['location'],
          vaccine: center['vaccine'],
          availability: center['availability'],
        ),
      ),
    );
  }

  void _deleteCenter(BuildContext context, String centerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Center'),
          content: const Text('Are you sure you want to delete this center?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('centers').doc(centerId).delete();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
