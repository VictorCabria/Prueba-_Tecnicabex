import 'package:equatable/equatable.dart';

import '../../../data/models/note_model.dart';


abstract class NoteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final NoteModel note;

  AddNote({required this.note});

  @override
  List<Object?> get props => [note];
}

class UpdateNote extends NoteEvent {
  final NoteModel note;

  UpdateNote({required this.note});

  @override
  List<Object?> get props => [note];
}

class DeleteNote extends NoteEvent {
  final int id;

  DeleteNote({required this.id});

  @override
  List<Object?> get props => [id];
}
