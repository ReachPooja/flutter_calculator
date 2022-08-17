part of 'calculator_bloc.dart';

class CalculatorState extends Equatable {
  const CalculatorState({
    this.value = '',
    this.calculatedValue = '',
    this.index = -1,
    this.isLastOperator = false,
  });

  final String value;
  final String calculatedValue;
  final int index;
  final bool isLastOperator;

  CalculatorState copyWith({
    String? value,
    String? calculatedValue,
    int? index,
    bool? isLastOperator,
  }) {
    return CalculatorState(
      value: value ?? this.value,
      calculatedValue: calculatedValue ?? this.calculatedValue,
      index: index ?? this.index,
      isLastOperator: isLastOperator ?? this.isLastOperator,
    );
  }

  @override
  List<Object> get props => [
        value,
        calculatedValue,
        index,
        isLastOperator,
      ];
}
