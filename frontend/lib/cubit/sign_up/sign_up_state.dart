part of 'sign_up_cubit.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpChecking extends SignUpState {}

class SignUpDisplay extends SignUpState {}

class SignUpError extends SignUpState {
  final String title;
  final String description;

  SignUpError(this.title, this.description);
}

class SignUpConfirm extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String title;
  final String description;

  SignUpSuccess(this.title, this.description);
}
