import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/Schedule.dart';

class EditScheduleScreen extends StatefulWidget {
  final Schedule schedule;

  const EditScheduleScreen({Key? key, required this.schedule}) : super(key: key);

  @override
  _EditScheduleScreenState createState() => _EditScheduleScreenState();
}

class _EditScheduleScreenState extends State<EditScheduleScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _dateController;
  late TextEditingController _additionalInfoController;

  String? _selectedCenter; // To hold the selected center
  List<String> _centers = []; // To hold the list of centers

  String? _selectedVaccine; // To hold the selected vaccine
  final List<String> _vaccines = [
    '1st Vaccine',
    '2nd Vaccine',
    '3rd Vaccine',
    '4th Vaccine'
  ];

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with the current schedule's details
    _dateController = TextEditingController(
      text: widget.schedule.date.toLocal().toString().split(' ')[0],
    );
    _additionalInfoController = TextEditingController(text: widget.schedule.additionalInfo);

    _selectedCenter = widget.schedule.center; // Preselect the current center
    _selectedVaccine = widget.schedule.vaccineName; // Preselect the current vaccine

    _fetchCenters(); // Fetch the list of centers from Firestore
  }

  @override
  void dispose() {
    _dateController.dispose();
    _additionalInfoController.dispose();
    super.dispose();
  }

  // Fetch the list of centers from Firestore
  Future<void> _fetchCenters() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('centers').get();

      List<String> centers = querySnapshot.docs.map((doc) => doc['name'] as String).toList();

      setState(() {
        _centers = centers;
      });
    } catch (e) {
      print("Error fetching centers: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load centers.')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != DateTime.parse(_dateController.text)) {
      setState(() {
        _dateController.text = picked.toLocal().toString().split(' ')[0]; // format as yyyy-mm-dd
      });
    }
  }

  Future<void> _updateSchedule() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Parse the date string back to DateTime
        DateTime parsedDate = DateTime.parse(_dateController.text);

        // Convert the DateTime to a Timestamp
        Timestamp timestamp = Timestamp.fromDate(parsedDate);

        // Update the schedule in Firestore
        await FirebaseFirestore.instance
            .collection('schedules')
            .doc(widget.schedule.id)
            .update({
          'vaccineName': _selectedVaccine,
          'date': timestamp,
          'center': _selectedCenter,
          'additionalInfo': _additionalInfoController.text,
        });

        Navigator.pop(context); // Go back to the previous screen
      } catch (e) {
        print("Error updating schedule: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update schedule.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Schedule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedVaccine,
                decoration: const InputDecoration(labelText: 'Vaccine Name'),
                items: _vaccines.map((String vaccine) {
                  return DropdownMenuItem<String>(
                    value: vaccine,
                    child: Text(vaccine),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedVaccine = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a vaccine';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date (yyyy-mm-dd)',
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedCenter,
                decoration: const InputDecoration(labelText: 'Center'),
                items: _centers.map((String center) {
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a center';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _additionalInfoController,
                decoration: const InputDecoration(labelText: 'Additional Info'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter additional info';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateSchedule,
                child: const Text('Update Schedule'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
