import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/note.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';

class NoteDialog extends StatefulWidget {
  final Note? note;
  final bool isUpdate;

  const NoteDialog({
    Key? key,
    this.note,
    required this.isUpdate,
  }) : super(key: key);

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?.title ?? '');
    contentController = TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isUpdate ? 'Update Note' : 'Create Note'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: contentController,
            decoration: const InputDecoration(labelText: 'Content'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => _handleSave(context),
          child: Text(widget.isUpdate ? 'Update' : 'Create'),
        ),
      ],
    );
  }

  void _handleSave(BuildContext context) {
    // Get the BlocProvider from the parent context (the screen context)
    final noteBloc = BlocProvider.of<NoteBloc>(context, listen: false);
    final newNote = Note(
      id: widget.isUpdate ? widget.note!.id : '',
      title: titleController.text,
      content: contentController.text,
    );
    
    if (widget.isUpdate) {
      noteBloc.add(UpdateNote(newNote.id, newNote));
    } else {
      noteBloc.add(CreateNote(newNote));
    }
    
    Navigator.pop(context);
  }
}
