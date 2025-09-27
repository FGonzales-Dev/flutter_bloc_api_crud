import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_state.dart';
import '../widgets/note_list_item.dart';
import '../widgets/note_dialog.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showNoteDialog(context, isUpdate: false),
          ),
        ],
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NoteLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return NoteListItem(note: note);
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

  void _showNoteDialog(BuildContext context, {required bool isUpdate}) {
    showDialog(
      context: context,
      builder: (dialogContext) => NoteDialog(
        isUpdate: isUpdate,
      ),
    );
  }
}
