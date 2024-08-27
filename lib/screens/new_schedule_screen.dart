import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  List<String> _centers = [];

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
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
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
      if (_date == null || _selectedCenter == null || _vaccineName == null) {
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
        'date': Timestamp.fromDate(_date!), // Convert DateTime to Timestamp
        'additionalInfo': _additionalInfo,
        'center': _selectedCenter,
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
              DropdownButtonFormField<String>(
                value: _vaccineName,
                hint: Text('Select Vaccine'),
                items: [
                  '1st Vaccine',
                  '2nd Vaccine',
                  '3rd Vaccine',
                  '4th Vaccine'
                ].map((vaccine) {
                  return DropdownMenuItem<String>(
                    value: vaccine,
                    child: Text(vaccine),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _vaccineName = value;
                  });
                },
                validator: (value) => value == null ? 'Please select a vaccine' : null,
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
