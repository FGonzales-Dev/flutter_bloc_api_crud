// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_api/bloc/note_event.dart';
import 'package:flutter_bloc_api/bloc/note_state.dart';
import 'package:flutter_bloc_api/models/note_model.dart';
import 'bloc/note_bloc.dart';
import 'repositories/note_repository_impl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      home: BlocProvider(
        create: (context) => NoteBloc(NoteRepositoryImpl())..add(FetchNotes()),
        child: NoteListScreen(),
      ),
    );
  }
}

class NoteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showNoteDialog(context, isUpdate: false),
          ),
        ],
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NoteLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showNoteDialog(context,
                            note: note, isUpdate: true),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => BlocProvider.of<NoteBloc>(context)
                            .add(DeleteNote(note.id)),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is NoteError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _showNoteDialog(BuildContext context,
      {Note? note, required bool isUpdate}) {
    final titleController = TextEditingController(text: note?.title ?? '');
    final descriptionController =
        TextEditingController(text: note?.description ?? '');

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(isUpdate ? 'Update Note' : 'Create Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Access BlocProvider with correct type and context
                final noteBloc = BlocProvider.of<NoteBloc>(context);
                final newNote = Note(
                  id: isUpdate ? note!.id : '',
                  title: titleController.text,
                  description: descriptionController.text,
                );
                if (isUpdate) {
                  noteBloc.add(UpdateNote(newNote.id, newNote));
                } else {
                  noteBloc.add(CreateNote(newNote));
                }
                Navigator.pop(dialogContext);
              },
              child: Text(isUpdate ? 'Update' : 'Create'),
            ),
          ],
        );
      },
    );
  }
}
