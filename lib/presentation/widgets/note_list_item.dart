import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/note.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import 'note_dialog.dart';

class NoteListItem extends StatelessWidget {
  final Note note;

  const NoteListItem({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(note.title),
      subtitle: Text(note.content),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showNoteDialog(context, note: note, isUpdate: true),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => BlocProvider.of<NoteBloc>(context)
                .add(DeleteNote(note.id)),
          ),
        ],
      ),
    );
  }

  void _showNoteDialog(BuildContext context, {Note? note, required bool isUpdate}) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: BlocProvider.of<NoteBloc>(context),
        child: NoteDialog(
          note: note,
          isUpdate: isUpdate,
        ),
      ),
    );
  }
}
