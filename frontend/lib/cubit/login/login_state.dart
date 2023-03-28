part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final String title;
  final String description;

  LoginError(this.title, this.description);
}

class LoginSuccess extends LoginState {
  final String title;
  final String description;

  LoginSuccess(this.title, this.description);
}
