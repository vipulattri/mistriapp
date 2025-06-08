import 'package:flutter/material.dart';
import '../models/mistri.dart';
import '../services/api_service.dart';

class EditMistriScreen extends StatefulWidget {
  final Mistri mistri;

  const EditMistriScreen({required this.mistri});

  @override
  _EditMistriScreenState createState() => _EditMistriScreenState();
}

class _EditMistriScreenState extends State<EditMistriScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String skill;
  late String phone;
  late String location;
  late int experience;

  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    name = widget.mistri.name;
    skill = widget.mistri.skill;
    phone = widget.mistri.phone;
    location = widget.mistri.location;
    experience = widget.mistri.experience;
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Mistri updatedMistri = Mistri(
        name: name,
        skill: skill,
        phone: phone,
        location: location,
        experience: experience,
      );

      try {
        await apiService.updateMistri(widget.mistri.id!, updatedMistri);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Mistri')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (val) => name = val!.trim(),
                validator: (val) =>
                    val!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                initialValue: skill,
                decoration: InputDecoration(labelText: 'Skill'),
                onSaved: (val) => skill = val!.trim(),
                validator: (val) =>
                    val!.isEmpty ? 'Please enter skill' : null,
              ),
              TextFormField(
                initialValue: phone,
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                onSaved: (val) => phone = val!.trim(),
                validator: (val) =>
                    val!.isEmpty ? 'Please enter phone' : null,
              ),
              TextFormField(
                initialValue: location,
                decoration: InputDecoration(labelText: 'Location'),
                onSaved: (val) => location = val!.trim(),
                validator: (val) =>
                    val!.isEmpty ? 'Please enter location' : null,
              ),
              TextFormField(
                initialValue: experience.toString(),
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
                child: Text('Update Mistri'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
