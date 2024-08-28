// lib/bloc/note_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/note_model.dart';
import '../repositories/note_repository.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository _noteRepository;

  NoteBloc(this._noteRepository) : super(NoteLoading()) {
    on<FetchNotes>((event, emit) async {
      try {
        emit(NoteLoading());
        final notes = await _noteRepository.fetchNotes();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<CreateNote>((event, emit) async {
      try {
        await _noteRepository.createNote(event.note);
        add(FetchNotes()); // Refresh the list after creating a note
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<DeleteNote>((event, emit) async {
      try {
        await _noteRepository.deleteNote(event.id);
        add(FetchNotes()); // Refresh the list after deleting a note
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<UpdateNote>((event, emit) async {
      try {
        await _noteRepository.updateNote(event.id, event.note);
        add(FetchNotes()); // Refresh the list after updating a note
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });
  }
}
