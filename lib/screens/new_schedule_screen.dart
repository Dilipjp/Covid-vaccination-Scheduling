import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewScheduleScreen extends StatefulWidget {
  @override
  _NewScheduleScreenState createState() => _NewScheduleScreenState();
}

class _NewScheduleScreenState extends State<NewScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _vaccineName;
  DateTime? _date;
  String? _additionalInfo;
  String? _selectedCenter;
  List<String> _centers = []; // List of centers to be fetched from Firestore

  @override
  void initState() {
    super.initState();
    _fetchCenters();
  }

  Future<void> _fetchCenters() async {
    final snapshot = await FirebaseFirestore.instance.collection('centers').get();
    final List<String> centers = snapshot.docs.map((doc) => doc['name'] as String).toList();
    setState(() {
      _centers = centers;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _date) {
      setState(() {
        _date = pickedDate;
      });
    }
  }

  void _saveSchedule() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_date == null || _selectedCenter == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please complete all fields')),
        );
        return;
      }

      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference docRef = FirebaseFirestore.instance.collection('schedules').doc();

      await docRef.set({
        'id': docRef.id,
        'userId': userId,
        'vaccineName': _vaccineName,
        'date': _date!.toIso8601String(),
        'additionalInfo': _additionalInfo,
        'center': _selectedCenter,  // Save center name directly
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Schedule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Vaccine Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter vaccine name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _vaccineName = value;
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _date == null
                          ? 'Select Date'
                          : 'Date: ${_date!.toLocal().toString().split(' ')[0]}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCenter,
                hint: Text('Select Center'),
                items: _centers.map((center) {
                  return DropdownMenuItem<String>(
                    value: center,
                    child: Text(center),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCenter = value;
                  });
                },
                validator: (value) => value == null ? 'Please select a center' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Additional Info'),
                onSaved: (value) {
                  _additionalInfo = value;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveSchedule,
                child: Text('Save Schedule'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
