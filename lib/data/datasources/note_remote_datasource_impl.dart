import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/note_model.dart';
import 'note_remote_datasource.dart';

class NoteRemoteDataSourceImpl implements NoteRemoteDataSource {
  final String baseUrl;

  NoteRemoteDataSourceImpl({required this.baseUrl});

  @override
  Future<List<NoteModel>> fetchNotes() async {
    final response = await http.get(Uri.parse('$baseUrl/notes'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> notesData = responseData['notes'];
      return notesData.map((json) => NoteModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }

  @override
  Future<void> addNote(NoteModel note) async {
    final response = await http.post(
      Uri.parse('$baseUrl/notes'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(note.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add note');
    }
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    final response = await http.put(
      Uri.parse('$baseUrl/notes/${note.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(note.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update note');
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/notes/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete note');
    }
  }
}
