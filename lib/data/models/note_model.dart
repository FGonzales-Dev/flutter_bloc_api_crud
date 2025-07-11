import '../../domain/entities/note.dart';

class NoteModel extends Note {
  NoteModel({required String id, required String title, required String description})
      : super(id: id, title: title, content: description);

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': content,
    };
  }
}
