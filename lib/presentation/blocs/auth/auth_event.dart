import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignIn extends AuthEvent {
  final String email;
  final String password;

  SignIn({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class CreateUser extends AuthEvent {
  final String email;
  final String password;

  CreateUser({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignOut extends AuthEvent {}
