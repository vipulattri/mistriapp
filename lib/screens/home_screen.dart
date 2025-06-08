import 'package:flutter/material.dart';
import '../models/mistri.dart';
import '../services/api_service.dart';
import '../widgets/mistri_card.dart';
import 'add_mistri_screen.dart';
import 'edit_mistri_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Mistri>> _mistris;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadMistris();
  }

  void _loadMistris() {
    setState(() {
      _mistris = apiService.fetchMistris();
    });
  }

  void _deleteMistri(String id) async {
    try {
      await apiService.deleteMistri(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Deleted successfully')),
      );
      _loadMistris();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Delete failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mistri.com - Manage Mistris'),
      ),
      body: FutureBuilder<List<Mistri>>(
        future: _mistris,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final mistris = snapshot.data ?? [];
          if (mistris.isEmpty) {
            return Center(child: Text('No Mistris found.'));
          }
          return ListView.builder(
            itemCount: mistris.length,
            itemBuilder: (context, index) {
              final mistri = mistris[index];
              return MistriCard(
                mistri: mistri,
                onEdit: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditMistriScreen(mistri: mistri),
                    ),
                  );
                  if (result == true) _loadMistris();
                },
                onDelete: () => _deleteMistri(mistri.id!),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddMistriScreen()),
          );
          if (result == true) _loadMistris();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
