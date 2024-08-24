import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CentersScreen extends StatelessWidget {
  const CentersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centers'),
        centerTitle: true,
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
              return _buildCenterTile(center);
            },
          );
        },
      ),
    );
  }

  // Helper method to build a center tile
  Widget _buildCenterTile(DocumentSnapshot center) {
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
            Text('Availability: $availability'),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Handle navigation to details or booking page
        },
      ),
    );
  }
}
