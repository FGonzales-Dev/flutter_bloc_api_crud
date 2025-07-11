import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_remote_datasource.dart';
import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteRemoteDataSource remoteDataSource;

  NoteRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Note>> getNotes() async {
    return await remoteDataSource.fetchNotes();
  }

  @override
  Future<void> addNote(Note note) async {
    await remoteDataSource.addNote(NoteModel(
      id: note.id,
      title: note.title,
      description: note.content,
    ));
  }

  @override
  Future<void> updateNote(Note note) async {
    await remoteDataSource.updateNote(NoteModel(
      id: note.id,
      title: note.title,
      description: note.content,
    ));
  }

  @override
  Future<void> deleteNote(String id) async {
    await remoteDataSource.deleteNote(id);
  }
}
