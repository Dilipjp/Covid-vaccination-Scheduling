import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'editprofile_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _name;
  String? _phone;
  String? _address;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();

    setState(() {
      _name = userDoc['name'];
      _phone = userDoc['contact'];
      _address = userDoc['address'];
      _email = FirebaseAuth.instance.currentUser!.email;
    });
  }

  void _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          name: _name ?? '',
          phone: _phone ?? '',
          address: _address ?? '',
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _name = result['name'];
        _phone = result['phone'];
        _address = result['address'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: _name == null || _phone == null || _address == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/image/profile.png'),
            ),
            const SizedBox(height: 16),
            Text(
              _name ?? '',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _email ?? '',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              leading: Icon(Icons.phone, color: Theme.of(context).primaryColor),
              title: Text('Phone', style: const TextStyle(fontSize: 18)),
              subtitle: Text(_phone ?? '', style: const TextStyle(fontSize: 16)),
            ),
            const Divider(),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              leading: Icon(Icons.home, color: Theme.of(context).primaryColor),
              title: Text('Address', style: const TextStyle(fontSize: 18)),
              subtitle: Text(_address ?? '', style: const TextStyle(fontSize: 16)),
            ),
            const Divider(),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _navigateToEditProfile,
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
