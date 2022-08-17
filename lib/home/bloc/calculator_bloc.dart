import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(const CalculatorState()) {
    on<ValueInserted>(_onValueInserted);
    on<OperatorInserted>(_onOperatorInserted);
    on<ValueRemoved>(_onValueRemoved);
    on<TextIndexChanged>(_onTextIndexChanged);
    on<AllCleared>(_onAllCleared);
  }

  void _onValueInserted(
    ValueInserted event,
    Emitter<CalculatorState> emit,
  ) {
    final previousValue = state.value;
    final isOperatorContains = previousValue.contains(RegExp('[+÷×%-]'));

    var value = '';

    if (!isOperatorContains && state.value.length < 15) {
      if (state.index == -1) {
        value = state.value + event.value;
      } else {
        final lettersList = state.value.split('');

        final updatedList = List.of(lettersList)
          ..insert(state.index, event.value);

        value = updatedList.join();
        emit(
          state.copyWith(
            index: state.index + 1,
          ),
        );
      }
    } else {
      final splitListOperator = state.value.split(RegExp('[+÷×%-]'));

      if (state.index == -1) {
        if (splitListOperator.last.length < 15) {
          value = state.value + event.value;
        } else {
          value = state.value;
        }
      } else {
        final cursorIndex = state.index;

        var focusIndex = 0;
        var isLoopBreak = false;
        log(focusIndex.toString(), name: 'fIndex');

        for (var j = 0; j < splitListOperator.length; j++) {
          log(j.toString(), name: 'j');
          if (splitListOperator[j].length < 15) {
            var v = splitListOperator[0];
            var i = 0;

            while (i < splitListOperator.length - 1) {
              log(i.toString(), name: 'i');
              if (v.length + 1 < cursorIndex) {
                log(v, name: 'v');
                v = v + splitListOperator[i + 1];
                i++;
                isLoopBreak = false;
                continue;
              } else {
                focusIndex = i;
                isLoopBreak = true;
                break;
              }
            }
            log(focusIndex.toString(), name: 'Focus Index');
            if (splitListOperator[j] == splitListOperator[focusIndex]) {
              log('true');
              final lettersList = state.value.split('');

              final updatedList = List.of(lettersList)
                ..insert(state.index, event.value);

              value = updatedList.join();
              emit(
                state.copyWith(
                  index: state.index + 1,
                ),
              );
            } else {
              log('false');
            }
          } else {
            value = state.value;
          }
          if (isLoopBreak) break;

          log(value, name: 'value');
        }
      }
    }

    emit(
      state.copyWith(
        value: value,
        isLastOperator: false,
      ),
    );
  }

  void _onOperatorInserted(
    OperatorInserted event,
    Emitter<CalculatorState> emit,
  ) {
    final _regExp = RegExp(r'^[0-9()]+$');
    final list = state.value.split('');
    var index = state.index;

    final selectedValue = state.index == -1 ? list.last : list[state.index - 1];
    var value = state.value;

    if (!_regExp.hasMatch(selectedValue)) {
      var ul = <String>[];
      if (state.index == -1) {
        ul = (list..last = event.value);
      } else {
        ul = (list..[state.index - 1] = event.value);
      }
      value = ul.join();
    } else {
      if (state.index == -1) {
        value = state.value + event.value;
      } else {
        final updatedList = List.of(list)..insert(state.index, event.value);

        value = updatedList.join();
        index = state.index + 1;
      }
    }

    emit(
      state.copyWith(
        value: value,
        index: index,
        isLastOperator: true,
      ),
    );
  }

  void _onValueRemoved(
    ValueRemoved event,
    Emitter<CalculatorState> emit,
  ) {
    final lettersList = state.value.split('');

    var updatedList = <String>[];
    var index = state.index;

    if (state.index == -1) {
      updatedList = List.of(lettersList)..removeLast();
    } else {
      if (state.index == 0) {
        updatedList = lettersList;
        index = 0;
      } else {
        updatedList = List.of(lettersList)..removeAt(state.index - 1);
        index = state.index - 1;
      }
    }
    final value = updatedList.join();
    if (value.isEmpty) index = -1;

    emit(
      state.copyWith(
        value: value,
        index: index,
        isLastOperator: false,
      ),
    );
  }

  void _onTextIndexChanged(
    TextIndexChanged event,
    Emitter<CalculatorState> emit,
  ) {
    emit(
      state.copyWith(
        index: event.index,
      ),
    );
  }

  void _onAllCleared(
    AllCleared event,
    Emitter<CalculatorState> emit,
  ) {
    emit(
      state.copyWith(
        value: '',
        index: -1,
      ),
    );
  }
}
