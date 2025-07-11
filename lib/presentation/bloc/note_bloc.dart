import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository _noteRepository;

  NoteBloc(this._noteRepository) : super(NoteLoading()) {
    on<FetchNotes>((event, emit) async {
      try {
        emit(NoteLoading());
        final notes = await _noteRepository.getNotes();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<CreateNote>((event, emit) async {
      try {
        await _noteRepository.addNote(event.note);
        add(FetchNotes());
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<DeleteNote>((event, emit) async {
      try {
        await _noteRepository.deleteNote(event.id);
        add(FetchNotes());
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<UpdateNote>((event, emit) async {
      try {
        await _noteRepository.updateNote(event.note);
        add(FetchNotes());
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });
  }
}
