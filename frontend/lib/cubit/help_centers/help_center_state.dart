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