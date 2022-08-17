part of 'calculator_bloc.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

class ValueInserted extends CalculatorEvent {
  const ValueInserted(
    this.value,
  );
  final String value;

  @override
  List<Object> get props => [value];
}

class OperatorInserted extends CalculatorEvent {
  const OperatorInserted({
    required this.value,
    this.isSpecialValue = false,
  });

  final String value;
  final bool isSpecialValue;

  @override
  List<Object> get props => [value];
}

class ValueRemoved extends CalculatorEvent {}

class TextIndexChanged extends CalculatorEvent {
  const TextIndexChanged(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}

class AllCleared extends CalculatorEvent {}
