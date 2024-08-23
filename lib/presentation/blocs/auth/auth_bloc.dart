import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/user_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({required this.userRepository}) : super(AuthInitial()) {
    on<SignIn>(_onSignIn);
    on<CreateUser>(_onCreateUser);
    on<SignOut>(_onSignOut);
  }

  Future<void> _onSignIn(SignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await userRepository.signIn(event.email, event.password);
      emit(AuthSuccess(token: token));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onCreateUser(CreateUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await userRepository.createUser(event.email, event.password);
      emit(UserCreated());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  void _onSignOut(SignOut event, Emitter<AuthState> emit) {
    // Implementación de SignOut
  }
}
