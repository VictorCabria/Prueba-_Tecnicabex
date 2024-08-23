import 'package:equatable/equatable.dart';
import '../../../data/models/note_model.dart';

abstract class NoteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final List<NoteModel> notes;

  NoteLoaded({required this.notes});

  @override
  List<Object?> get props => [notes];
}

class NoteError extends NoteState {
  final String message;

  NoteError({required this.message});

  @override
  List<Object?> get props => [message];
}
