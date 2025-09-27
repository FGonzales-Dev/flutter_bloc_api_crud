import '../../data/datasources/note_remote_datasource_impl.dart';
import '../../data/repositories/note_repository_impl.dart';
import '../../presentation/bloc/note_bloc.dart';

class ApiUtil {
  static const String baseUrl = 'https://express-crud-two.vercel.app/api/v1';
  
  static NoteBloc createNoteBloc() {
    final dataSource = NoteRemoteDataSourceImpl(baseUrl: baseUrl);
    final repository = NoteRepositoryImpl(dataSource);
    return NoteBloc(repository);
  }
  
  static NoteRemoteDataSourceImpl createDataSource() {
    return NoteRemoteDataSourceImpl(baseUrl: baseUrl);
  }
  
  static NoteRepositoryImpl createRepository() {
    return NoteRepositoryImpl(createDataSource());
  }
}
