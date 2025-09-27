// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/bloc/note_event.dart';
import 'core/api/api_util.dart';
import 'presentation/screens/note_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      home: BlocProvider(
        create: (context) => ApiUtil.createNoteBloc()..add(FetchNotes()),
        child: const NoteListScreen(),
      ),
    );
  }
}

