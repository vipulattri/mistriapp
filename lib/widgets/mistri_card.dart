import 'package:flutter/material.dart';
import '../models/mistri.dart';

class MistriCard extends StatelessWidget {
  final Mistri mistri;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MistriCard({
    Key? key,
    required this.mistri,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        title: Text(mistri.name),
        subtitle: Text('${mistri.skill} | ${mistri.location}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
