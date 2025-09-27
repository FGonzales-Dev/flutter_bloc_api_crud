import '../../data/datasources/note_remote_datasource_impl.dart';
import '../../data/repositories/note_repository_impl.dart';
import '../../presentation/bloc/note_bloc.dart';

class ApiUtil {
  static const String baseUrl = 'https://express-crud-two.vercel.app/api/v1';
  
  /// Creates and configures the NoteBloc with all necessary dependencies
  static NoteBloc createNoteBloc() {
    final dataSource = NoteRemoteDataSourceImpl(baseUrl: baseUrl);
    final repository = NoteRepositoryImpl(dataSource);
    return NoteBloc(repository);
  }
  
  /// Creates the data source instance
  static NoteRemoteDataSourceImpl createDataSource() {
    return NoteRemoteDataSourceImpl(baseUrl: baseUrl);
  }
  
  /// Creates the repository instance
  static NoteRepositoryImpl createRepository() {
    return NoteRepositoryImpl(createDataSource());
  }
}
