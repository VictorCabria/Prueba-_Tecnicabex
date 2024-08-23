
import '../../data/models/note_model.dart';
import '../../data/provides/database_helper.dart';

class NoteRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<List<NoteModel>> getAllNotes() async {
    return await _databaseHelper.getAll();
  }

  Future<NoteModel> getNoteById(int id) async {
    return await _databaseHelper.read(id);
  }

  Future<void> createNote(NoteModel note) async {
    await _databaseHelper.insert(note);
  }

  Future<void> updateNote(NoteModel note) async {
    await _databaseHelper.update(note);
  }

  Future<void> deleteNote(int id) async {
    await _databaseHelper.delete(id);
  }
}
