import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditCenterScreen extends StatefulWidget {
  final String centerId;
  final String name;
  final String location;
  final String vaccine;
  final String availability;

  const EditCenterScreen({
    Key? key,
    required this.centerId,
    required this.name,
    required this.location,
    required this.vaccine,
    required this.availability,
  }) : super(key: key);

  @override
  _EditCenterScreenState createState() => _EditCenterScreenState();
}

class _EditCenterScreenState extends State<EditCenterScreen> {
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _vaccineController;
  late TextEditingController _availabilityController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _locationController = TextEditingController(text: widget.location);
    _vaccineController = TextEditingController(text: widget.vaccine);
    _availabilityController = TextEditingController(text: widget.availability);
  }

  Future<void> _updateCenter() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection('centers')
          .doc(widget.centerId)
          .update({
        'name': _nameController.text.trim(),
        'location': _locationController.text.trim(),
        'vaccine': _vaccineController.text.trim(),
        'availability': _availabilityController.text.trim(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Center updated successfully')),
      );

      Navigator.of(context).pop(); // Navigate back after saving
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Center'),
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
                onPressed: _updateCenter,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
