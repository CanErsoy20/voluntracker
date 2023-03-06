part of 'map_cubit.dart';

abstract class MapState {}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapDisplay extends MapState {}

class MapNoService extends MapState {}
