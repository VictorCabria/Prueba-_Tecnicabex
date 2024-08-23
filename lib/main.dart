import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'domain/repositories/note_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/note/note_bloc.dart';
import 'presentation/screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
            home: LoginScreen(),
          ),
        );
      },
    );
  }
}
