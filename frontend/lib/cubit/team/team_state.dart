part of 'team_cubit.dart';

abstract class TeamState {}

class TeamInitial extends TeamState {}

class TeamLoading extends TeamState {}

class TeamDisplay extends TeamState {}

class TeamSuccess extends TeamState {
  final String title;
  final String description;

  TeamSuccess(this.title, this.description);
}

class TeamError extends TeamState {
  final String title;
  final String description;

  TeamError(this.title, this.description);
}
