// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

final class HomeState {
  HomeState({
    this.allMarks = const {},
    required this.selectedDate,
    required this.selectedValue,
  });

  final Map<DateTime, List<bool>> allMarks;
  final DateTime selectedDate;
  final List<bool> selectedValue;

  HomeState copyWith({
    Map<DateTime, List<bool>>? allMarks,
    DateTime? selectedDate,
    List<bool>? selectedValue,
  }) {
    return HomeState(
      allMarks: allMarks ?? this.allMarks,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedValue: selectedValue ?? this.selectedValue,
    );
  }
}
