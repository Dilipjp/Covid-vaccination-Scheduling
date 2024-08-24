import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy user data
    final String userName = 'John Doe';
    final String userEmail = 'johndoe@example.com';
    final String userPhone = '+1 (123) 456-7890';
    final String userAddress = '123 Main St, Springfield, USA';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile picture
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile_pic.png'),
                backgroundColor: Colors.grey[200],
              ),
              const SizedBox(height: 20),

              // User name
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // User email
              Text(
                userEmail,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),

              // Divider
              const Divider(height: 20, thickness: 2),

              // User details section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    _buildProfileDetailRow(Icons.phone, 'Phone', userPhone),
                    const SizedBox(height: 10),
                    _buildProfileDetailRow(Icons.location_on, 'Address', userAddress),
                    const SizedBox(height: 10),
                    _buildProfileDetailRow(Icons.email, 'Email', userEmail),
                  ],
                ),
              ),

              // Divider
              const Divider(height: 20, thickness: 2),

              // Action buttons
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    _buildActionButton(Icons.edit, 'Edit Profile', () {
                      // Handle edit profile action
                    }),
                    const SizedBox(height: 10),
                    _buildActionButton(Icons.lock, 'Change Password', () {
                      // Handle change password action
                    }),
                    const SizedBox(height: 10),
                    _buildActionButton(Icons.logout, 'Log Out', () {
                      // Handle logout action
                    }, isDestructive: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build profile detail rows
  Widget _buildProfileDetailRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.deepPurple, size: 30),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  // Helper method to build action buttons
  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap,
      {bool isDestructive = false}) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: isDestructive ? Colors.red : Colors.white),
      label: Text(
        label,
        style: TextStyle(
          color: isDestructive ? Colors.red : Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: isDestructive ? Colors.red : Colors.white, backgroundColor: isDestructive ? Colors.white : Colors.deepPurple,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: isDestructive
              ? const BorderSide(color: Colors.red)
              : BorderSide.none,
        ),
      ),
    );
  }
}
