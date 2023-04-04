part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileDisplay extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileError extends ProfileState {
  final String title;
  final String description;

  ProfileError(this.title, this.description);
}

class ProfileSuccess extends ProfileState {
  final String title;
  final String description;

  ProfileSuccess(this.title, this.description);
}
