import 'package:flutter/material.dart';
import '../models/mistri.dart';
import '../services/api_service.dart';

class AddMistriScreen extends StatefulWidget {
  @override
  _AddMistriScreenState createState() => _AddMistriScreenState();
}

class _AddMistriScreenState extends State<AddMistriScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  String name = '';
  String skill = '';
  String phone = '';
  String location = '';
  int experience = 0;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Mistri mistri = Mistri(
        name: name,
        skill: skill,
        phone: phone,
        location: location,
        experience: experience,
      );
      try {
        await apiService.addMistri(mistri);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Mistri')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (val) => name = val!.trim(),
                validator: (val) =>
                    val!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Skill'),
                onSaved: (val) => skill = val!.trim(),
                validator: (val) =>
                    val!.isEmpty ? 'Please enter skill' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                onSaved: (val) => phone = val!.trim(),
                validator: (val) =>
                    val!.isEmpty ? 'Please enter phone' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location'),
                onSaved: (val) => location = val!.trim(),
                validator: (val) =>
                    val!.isEmpty ? 'Please enter location' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Experience (years)'),
                keyboardType: TextInputType.number,
                onSaved: (val) => experience = int.tryParse(val!) ?? 0,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Enter experience';
                  if (int.tryParse(val) == null) return 'Enter a valid number';
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Add Mistri'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
