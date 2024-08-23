import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/repositories/note_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/note/note_bloc.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtener el token almacenado en SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('authToken');

  runApp(MyApp(
      initialRoute: token == null ? LoginScreen() : HomeScreen(token: token)));
}

class MyApp extends StatelessWidget {
  final Widget initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(userRepository: UserRepository()),
            ),
            BlocProvider<NoteBloc>(
              create: (context) => NoteBloc(noteRepository: NoteRepository()),
            ),
          ],
          child: MaterialApp(
            title: 'User Notes App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: initialRoute,
          ),
        );
      },
    );
  }
}
