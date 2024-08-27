import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Introduction'),
              const Text(
                'We value your privacy and are committed to protecting your personal data. '
                    'This Privacy Policy explains how we collect, use, and share information about you.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('Data Collection'),
              const Text(
                'We may collect the following types of information:\n\n'
                    '1. Personal Information: Name, email address, phone number, etc.\n'
                    '2. Usage Data: Information on how you interact with our app.\n'
                    '3. Device Data: Information about the device you use to access our app.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('Use of Information'),
              const Text(
                'We use the collected data to:\n\n'
                    '1. Provide and maintain our service.\n'
                    '2. Improve, personalize, and expand our app.\n'
                    '3. Communicate with you, either directly or through one of our partners.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('Data Sharing'),
              const Text(
                'We do not share your personal data with third parties except in the following cases:\n\n'
                    '1. With your consent.\n'
                    '2. For legal reasons, such as complying with laws or responding to legal requests.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('Security'),
              const Text(
                'We implement a variety of security measures to protect your personal data. '
                    'However, no method of transmission over the Internet, or method of electronic storage, is 100% secure.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('Your Rights'),
              const Text(
                'You have the right to:\n\n'
                    '1. Access the personal data we hold about you.\n'
                    '2. Request the correction of inaccurate data.\n'
                    '3. Request the deletion of your personal data.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('Contact Us'),
              const Text(
                'If you have any questions about this Privacy Policy, please contact us at:\n\n'
                    'Email: support@example.com\n'
                    'Phone: +123 456 7890',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build section titles
  Widget _buildSectionTitle(String title) {
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
}
