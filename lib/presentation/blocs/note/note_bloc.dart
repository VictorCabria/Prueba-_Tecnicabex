import 'package:bloc/bloc.dart';
import 'package:pruebatecnicabex1/presentation/blocs/note/note_event.dart';
import 'package:pruebatecnicabex1/presentation/blocs/note/note_state.dart';
import '../../../domain/repositories/note_repository.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository noteRepository;

  NoteBloc({required this.noteRepository}) : super(NoteInitial()) {
    on<LoadNotes>((event, emit) async {
      emit(NoteLoading());
      try {
        final notes = await noteRepository.getAllNotes();
        emit(NoteLoaded(notes: notes));
      } catch (e) {
        emit(NoteError(message: e.toString()));
      }
    });

    on<AddNote>((event, emit) async {
      try {
        await noteRepository.createNote(event.note);
        add(LoadNotes());
      } catch (e) {
        emit(NoteError(message: e.toString()));
      }
    });

    on<UpdateNote>((event, emit) async {
      try {
        await noteRepository.updateNote(event.note);
        add(LoadNotes());
      } catch (e) {
        emit(NoteError(message: e.toString()));
      }
    });

    on<DeleteNote>((event, emit) async {
      try {
        await noteRepository.deleteNote(event.id);
        add(LoadNotes());
      } catch (e) {
        emit(NoteError(message: e.toString()));
      }
    });
  }
}
