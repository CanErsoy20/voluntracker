part of 'help_center_cubit.dart';

abstract class HelpCenterState {}

class HelpCenterInitial extends HelpCenterState {}

class HelpCenterLoading extends HelpCenterState {}

class HelpCenterDisplay extends HelpCenterState {}

class HelpCenterError extends HelpCenterState {
  final String title;
  final String description;

  HelpCenterError(this.title, this.description);
}

class HelpCenterSuccess extends HelpCenterState {
  final String title;
  final String description;

  HelpCenterSuccess(this.title, this.description);
}

class HelpCenterEditing extends HelpCenterState {}

class HelpCenterSearching extends HelpCenterState {}

class HelpCenterNotFound extends HelpCenterState {}
