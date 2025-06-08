import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/mistri.dart';

class ApiService {
  final String baseUrl = "http://localhost:5000/api/mistris";

  Future<List<Mistri>> fetchMistris() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((m) => Mistri.fromJson(m)).toList();
    } else {
      throw Exception('Failed to load mistris');
    }
  }

  Future<void> addMistri(Mistri mistri) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(mistri.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add mistri');
    }
  }

  Future<void> updateMistri(String id, Mistri mistri) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(mistri.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update mistri');
    }
  }

  Future<void> deleteMistri(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete mistri');
    }
  }
}
