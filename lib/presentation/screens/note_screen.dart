import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import '../../data/models/note_model.dart';
import '../blocs/note/note_bloc.dart';
import '../blocs/note/note_event.dart';

class NoteScreen extends StatelessWidget {
  final NoteModel? note;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  NoteScreen({this.note}) {
    if (note != null) {
      _titleController.text = note!.title;
      _descriptionController.text = note!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'New Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  errorMaxLines: 3,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0.dp),
                    borderSide: BorderSide(
                      color: const Color(0xFF303133).withOpacity(0.13),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0.dp),
                    borderSide: BorderSide(
                      color: const Color(0xFF303133).withOpacity(0.13),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0.dp),
                    borderSide: BorderSide(
                      color: const Color(0xFF303133).withOpacity(0.13),
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF8F8F8),
                  labelText: "Title",
                  hintStyle: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18.dp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF303133).withOpacity(0.6),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 19.dp, vertical: 15.dp),
                ),
              ),
            ),
            SizedBox(height: 26.dp),
            Container(
              child: TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  errorMaxLines: 3,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0.dp),
                    borderSide: BorderSide(
                      color: const Color(0xFF303133).withOpacity(0.13),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0.dp),
                    borderSide: BorderSide(
                      color: const Color(0xFF303133).withOpacity(0.13),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0.dp),
                    borderSide: BorderSide(
                      color: const Color(0xFF303133).withOpacity(0.13),
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF8F8F8),
                  labelText: "Description",
                  hintStyle: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18.dp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF303133).withOpacity(0.6),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 19.dp, vertical: 15.dp),
                ),
              ),
            ),
            SizedBox(height: 50.dp),
            SizedBox(
              width: double.infinity,
              height: 51.dp,
              child: ElevatedButton(
                onPressed: () {
                  final newNote = NoteModel(
                    id: note?.id,
                    title: _titleController.text,
                    description: _descriptionController.text,
                  );
                  if (note == null) {
                    BlocProvider.of<NoteBloc>(context)
                        .add(AddNote(note: newNote));
                  } else {
                    BlocProvider.of<NoteBloc>(context)
                        .add(UpdateNote(note: newNote));
                  }
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.dp),
                    ),
                    backgroundColor: const Color(0xFF00A786)),
                child: Text(note == null ? 'Add Note' : 'Update Note',
                style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
