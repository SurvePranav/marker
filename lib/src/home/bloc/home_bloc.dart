import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Box<String> _hiveBox;
  HomeBloc(this._hiveBox)
      : super(
          HomeState(
            selectedDate: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ),
            selectedValue: _hiveBox.containsKey(
              DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
              ).toString(),
            )
                ? [true]
                : [],
          ),
        ) {
    on<GetAllMarks>((event, emit) {
      try {
        emit(state.copyWith(
          allMarks: {
            for (var value in _hiveBox.values) DateTime.parse(value): [true]
          },
        ));
      } catch (e) {
        log(e.toString());
      }
    });

    on<ToggleMarker>(_onToggleMarker);

    on<SelectionChanged>((event, emit) {
      emit(
        state.copyWith(
          selectedDate: event.date,
          selectedValue:
              _hiveBox.containsKey(event.date.toString()) ? [true] : [],
        ),
      );
    });
  }

  // bool isMarked(DateTime key) {
  //   return _hiveBox.containsKey(key.toString());
  // }

  List<bool> isPresent(DateTime day) {
    return _hiveBox.containsKey(day.toString()) ? [true] : [];
  }

  Future<void> _onToggleMarker(
    ToggleMarker event,
    Emitter<HomeState> emit,
  ) async {
    log('event handled: ${event.date}');
    if (_hiveBox.containsKey(event.date.toString())) {
      _hiveBox.delete(event.date.toString());
    } else {
      _hiveBox.put(
        event.date.toString(),
        event.date.toString(),
      );
    }

    emit(state.copyWith(
      selectedDate: event.date,
      selectedValue: _hiveBox.containsKey(event.date.toString()) ? [true] : [],
      allMarks: {
        for (var value in _hiveBox.values) DateTime.parse(value): [true]
      },
    ));
  }
}
