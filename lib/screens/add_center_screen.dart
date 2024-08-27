import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCenterScreen extends StatefulWidget {
  const AddCenterScreen({Key? key}) : super(key: key);

  @override
  _AddCenterScreenState createState() => _AddCenterScreenState();
}

class _AddCenterScreenState extends State<AddCenterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _vaccineController = TextEditingController();
  final TextEditingController _availabilityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _addCenter() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('centers').add({
        'name': _nameController.text.trim(),
        'location': _locationController.text.trim(),
        'vaccine': _vaccineController.text.trim(),
        'availability': _availabilityController.text.trim(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Center added successfully')),
      );

      // Clear the fields
      _nameController.clear();
      _locationController.clear();
      _vaccineController.clear();
      _availabilityController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Center'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Center Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the center name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _vaccineController,
                decoration: const InputDecoration(labelText: 'Vaccine'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the vaccine';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _availabilityController,
                decoration: const InputDecoration(labelText: 'Availability'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the availability';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addCenter,
                child: const Text('Add Center'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
