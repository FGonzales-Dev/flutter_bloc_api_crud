import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/note_model.dart';
import 'note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  static const String baseUrl = 'https://express-crud-two.vercel.app/api/v1';

  @override
  Future<List<Note>> fetchNotes() async {
    final response = await http.get(Uri.parse('$baseUrl/notes'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['notes'];
      return data.map((json) => Note.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }

  @override
  Future<void> createNote(Note note) async {
    final response = await http.post(
      Uri.parse('$baseUrl/note/new'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(note.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create note');
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/note/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete note');
    }
  }

  @override
  Future<void> updateNote(String id, Note note) async {
    final response = await http.put(
      Uri.parse('$baseUrl/note/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(note.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update note');
    }
  }
}
