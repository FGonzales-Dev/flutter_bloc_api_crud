import '../models/note_model.dart';

abstract class NoteRepository {
  Future<List<Note>> fetchNotes();
  Future<void> createNote(Note note);
  Future<void> deleteNote(String id);
  Future<void> updateNote(String id, Note note);
}
