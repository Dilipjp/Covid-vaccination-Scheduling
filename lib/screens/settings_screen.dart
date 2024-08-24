import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 10),
          _buildSettingsSectionTitle('Account'),
          _buildSettingsTile(
            context,
            icon: Icons.person,
            title: 'Profile',
            subtitle: 'View and edit your profile',
            onTap: () {
              // Navigate to profile settings
            },
          ),
          _buildSettingsTile(
            context,
            icon: Icons.lock,
            title: 'Change Password',
            subtitle: 'Update your password',
            onTap: () {
              // Navigate to change password screen
            },
          ),
          const SizedBox(height: 20),
          _buildSettingsSectionTitle('Notifications'),
          _buildSettingsTile(
            context,
            icon: Icons.notifications,
            title: 'Notification Preferences',
            subtitle: 'Manage your notifications',
            onTap: () {
              // Navigate to notification settings
            },
          ),
          _buildSettingsTile(
            context,
            icon: Icons.do_not_disturb,
            title: 'Do Not Disturb',
            subtitle: 'Set up do not disturb mode',
            onTap: () {
              // Navigate to DND settings
            },
          ),
          const SizedBox(height: 20),
          _buildSettingsSectionTitle('General'),
          _buildSettingsTile(
            context,
            icon: Icons.language,
            title: 'Language',
            subtitle: 'Choose your preferred language',
            onTap: () {
              // Navigate to language settings
            },
          ),
          _buildSettingsTile(
            context,
            icon: Icons.color_lens,
            title: 'Theme',
            subtitle: 'Switch between light and dark mode',
            onTap: () {
              // Navigate to theme settings
            },
          ),
          const SizedBox(height: 20),
          _buildSettingsSectionTitle('Support'),
          _buildSettingsTile(
            context,
            icon: Icons.help,
            title: 'Help & Support',
            subtitle: 'Get help or contact support',
            onTap: () {
              // Navigate to help & support
            },
          ),
          _buildSettingsTile(
            context,
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            subtitle: 'Read our privacy policy',
            onTap: () {
              // Navigate to privacy policy
            },
          ),
          const SizedBox(height: 20),
          _buildSettingsSectionTitle('Account Actions'),
          _buildSettingsTile(
            context,
            icon: Icons.logout,
            title: 'Log Out',
            subtitle: 'Sign out of your account',
            onTap: () {
              // Handle log out
            },
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  // Helper method to build settings section titles
  Widget _buildSettingsSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  // Helper method to build settings tiles
  Widget _buildSettingsTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
        bool isDestructive = false,
      }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: isDestructive ? Colors.red : Colors.deepPurple),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDestructive ? Colors.red : Colors.black,
          ),
        ),
        subtitle: Text(subtitle),
        onTap: onTap,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
