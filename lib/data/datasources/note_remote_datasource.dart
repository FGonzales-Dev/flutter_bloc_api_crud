import '../models/note_model.dart';

abstract class NoteRemoteDataSource {
  Future<List<NoteModel>> fetchNotes();
  Future<void> addNote(NoteModel note);
  Future<void> updateNote(NoteModel note);
  Future<void> deleteNote(String id);
}
