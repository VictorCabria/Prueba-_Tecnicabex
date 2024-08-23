import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pruebatecnicabex1/presentation/screens/login_screen.dart';
import 'package:pruebatecnicabex1/presentation/screens/note_screen.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/note/note_bloc.dart';
import '../blocs/note/note_event.dart';
import '../blocs/note/note_state.dart';

class HomeScreen extends StatelessWidget {
  final String token;

  HomeScreen({required this.token});

  @override
  Widget build(BuildContext context) {
    // Disparar el evento LoadNotes para obtener todas las notas cuando se construye el widget
    BlocProvider.of<NoteBloc>(context).add(LoadNotes());

    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        screenSize: screenSize,
      ),
      body: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is NoteLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NoteLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NoteScreen(note: note),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 10.dp, horizontal: 20.dp),
                    padding: EdgeInsets.all(20.dp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.dp),
                      border: Border.all(
                        color: const Color(0xFFDDDDDD),
                        width: 1.dp,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6.dp,
                          offset: Offset(0, 2.dp),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.dp),
                          decoration: BoxDecoration(
                            color: Color(0xFF00A786),
                            borderRadius: BorderRadius.circular(8.dp),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sep, 2023",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.dp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "04",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.dp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Lunes",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.dp,
                                ),
                              ),
                              SizedBox(height: 8.dp),
                              Text(
                                "02:30",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.dp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20.dp),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                note.title,
                                style: TextStyle(
                                  fontSize: 16.dp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF333333),
                                ),
                              ),
                              SizedBox(height: 10.dp),
                              Text(
                                "Descripcion",
                                style: TextStyle(
                                  fontSize: 12.dp,
                                  color: const Color(0xFF777777),
                                ),
                              ),
                              Text(
                                note.description,
                                style: TextStyle(
                                  fontSize: 14.dp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF333333),
                                ),
                              ),
                              SizedBox(height: 15.dp),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<NoteBloc>(context)
                                          .add(DeleteNote(
                                        id: note.id!,
                                      ));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 6.dp,
                                        horizontal: 16.dp,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF00A786),
                                        borderRadius:
                                            BorderRadius.circular(8.dp),
                                      ),
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.dp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      
                      ],
                    ),
                  ),
                  
                );
              },
            );
          } else {
            return Center(child: Text('No Notes'));
          }
        },
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Size screenSize;

  CustomAppBar({Key? key, required this.screenSize})
      : preferredSize = Size.fromHeight(80.dp),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8.dp),
            bottomRight: Radius.circular(8.dp),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.15),
              offset: Offset(0.dp, 1.dp),
              blurRadius: 8.dp,
              spreadRadius: 0.dp,
            ),
          ],
        ),
        child: AppBar(
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          title: Container(
            padding: EdgeInsets.only(top: 25.dp),
            constraints: BoxConstraints(
              maxWidth: 720.dp,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/assets/png/LOGO-01.png',
                  width: 100.69.dp,
                  height: 50.94.dp,
                ),
                Flexible(
                  flex: 1,
                  child: SizedBox(width: 400.dp),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => NoteScreen()),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12.dp,
                      ),
                      Icon(
                        Icons.add,
                        size: 30.dp,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.dp),
               IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    context.read<AuthBloc>().add(SignOut());
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  },
                )

              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leadingWidth: 20.dp + 64.dp,
          elevation: 0,
          toolbarHeight: 60.dp,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.dp),
              bottomRight: Radius.circular(8.dp),
            ),
          ),
          titleSpacing: 20.dp,
        ),
      ),
    );
  }
}
