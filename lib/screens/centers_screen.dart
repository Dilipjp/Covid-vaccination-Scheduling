import 'package:flutter/material.dart';

class CentersScreen extends StatelessWidget {
  const CentersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centers'),
      ),
      body: const Center(
        child: Text(
          'List of Centers will be shown here!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
