// lib/bloc/note_event.dart
import 'package:equatable/equatable.dart';
import '../models/note_model.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class FetchNotes extends NoteEvent {}

class CreateNote extends NoteEvent {
  final Note note;

  const CreateNote(this.note);

  @override
  List<Object> get props => [note];
}

class DeleteNote extends NoteEvent {
  final String id;

  const DeleteNote(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateNote extends NoteEvent {
  final String id;
  final Note note;

  const UpdateNote(this.id, this.note);

  @override
  List<Object> get props => [id, note];
}
