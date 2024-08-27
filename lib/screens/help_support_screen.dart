import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSection(
            context: context,
            title: 'FAQs',
            content: 'Find answers to the most common questions we receive.',
            icon: Icons.help_outline,
            onTap: () {
              // Navigate to the FAQs screen or section
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FAQsScreen(),
                ),
              );
            },
          ),
          _buildSection(
            context: context,
            title: 'Contact Us',
            content: 'Get in touch with our support team for further assistance.',
            icon: Icons.contact_mail,
            onTap: () {
              // Navigate to the Contact Us screen or section
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ContactUsScreen(),
                ),
              );
            },
          ),
          _buildSection(
            context: context,
            title: 'Report a Problem',
            content: 'Let us know if you encounter any issues with the app.',
            icon: Icons.report_problem,
            onTap: () {
              // Navigate to the Report a Problem screen or section
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ReportProblemScreen(),
                ),
              );
            },
          ),
          _buildSection(
            context: context,
            title: 'App Resources',
            content: 'Access guides, tutorials, and other resources.',
            icon: Icons.library_books,
            onTap: () {
              // Navigate to the App Resources screen or section
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ResourcesScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required String content,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Icon(icon, color: Colors.purple),
        title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
        subtitle: Text(content, style: Theme.of(context).textTheme.bodyMedium),
        onTap: onTap,
      ),
    );
  }
}

// Sample screens for navigation

class FAQsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
        ),
      ),
      body: Center(
        child: Text('Frequently Asked Questions'),
      ),
    );
  }
}

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
        ),
      ),
      body: Center(
        child: Text('Contact Us Information'),
      ),
    );
  }
}

class ReportProblemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report a Problem'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
        ),
      ),
      body: Center(
        child: Text('Report a Problem Information'),
      ),
    );
  }
}

class ResourcesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Resources'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
        ),
      ),
      body: Center(
        child: Text('App Resources Information'),
      ),
    );
  }
}
