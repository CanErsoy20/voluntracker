part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpError extends SignUpState {
  final String title;
  final String description;

  SignUpError(this.title, this.description);
}

class SignUpSuccess extends SignUpState {
  final String title;
  final String description;

  SignUpSuccess(this.title, this.description);
}
