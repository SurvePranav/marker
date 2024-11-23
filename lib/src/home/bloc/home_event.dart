part of 'home_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

final class GetAllMarks extends HomeEvent {
  const GetAllMarks();
}

final class ToggleMarker extends HomeEvent {
  const ToggleMarker({
    required this.date,
  });
  final DateTime date;
}

final class SelectionChanged extends HomeEvent {
  const SelectionChanged({
    required this.date,
  });
  final DateTime date;
}
