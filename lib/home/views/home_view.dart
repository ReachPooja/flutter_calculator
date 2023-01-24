import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calculator/home/bloc/calculator_bloc.dart';
import 'package:flutter_calculator/home/views/widgets/primary_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  static const Color primaryColor = Color(0xff9163cb);
  bool isLongPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CalculatorBloc, CalculatorState>(
          listener: (context, state) {
            _controller.text = state.value;
            if (state.index > 0 && state.index < _controller.text.length) {
              _controller.selection = TextSelection.fromPosition(
                TextPosition(
                  offset: state.index,
                ),
              );
            } else {
              final newIndex = state.value.length;
              _controller.selection = TextSelection.fromPosition(
                TextPosition(
                  offset: newIndex,
                ),
              );
            }
          },
        ),
        BlocListener<CalculatorBloc, CalculatorState>(
          listenWhen: (previous, current) =>
              previous.isLimitExceed != current.isLimitExceed,
          listener: (context, state) {
            if (state.isLimitExceed) {
              Fluttertoast.showToast(msg: "Can't enter more than 15 digits");
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calculate'),
          backgroundColor: primaryColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (!context.watch<CalculatorBloc>().state.isFinalResult)
              Expanded(
                child: Center(
                  child: TextField(
                    focusNode: _focusNode,
                    onTap: () {
                      if (_controller.text.isNotEmpty) {
                        context.read<CalculatorBloc>().add(
                              TextIndexChanged(
                                _controller.selection.baseOffset,
                              ),
                            );
                      }
                    },
                    cursorColor: primaryColor,
                    textAlign: TextAlign.end,
                    controller: _controller,
                    maxLines: 4,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                    keyboardType: TextInputType.none,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      counterText: '',
                      hintText: '0',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
                if (state.result.isEmpty) {
                  return const SizedBox.shrink();
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          PhosphorIcons.equalsBold,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          state.result,
                          style: TextStyle(
                            color: state.isFinalResult
                                ? Colors.black
                                : Colors.grey,
                            fontSize: 30,
                            fontWeight:
                                state.isFinalResult ? FontWeight.w500 : null,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            const Divider(
              height: 20,
            ),
            Table(
              children: [
                TableRow(
                  children: [
                    PrimaryButton(
                      text: 'AC',
                      iconColor: Colors.red,
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              AllCleared(),
                            );
                      },
                    ),
                    PrimaryButton(
                      iconColor: primaryColor,
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          context.read<CalculatorBloc>().add(
                                ValueRemoved(),
                              );
                        }
                      },
                      onLongPressEnd: (_) {
                        setState(() {
                          isLongPressed = false;
                        });
                      },
                      onLongPressStart: (_) async {
                        setState(() {
                          isLongPressed = true;
                        });
                        final value = _controller.text.length;
                        if (_controller.text.isNotEmpty) {
                          for (var i = 0; i < value; i++) {
                            if (isLongPressed) {
                              context.read<CalculatorBloc>().add(
                                    ValueRemoved(),
                                  );
                              await Future<void>.delayed(
                                const Duration(
                                  milliseconds: 50,
                                ),
                              );
                            }
                          }
                        }
                      },
                      icon: PhosphorIcons.arrowLeftBold,
                    ),
                    PrimaryButton(
                      iconColor: primaryColor,
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              PlusMinusInserted(),
                            );
                      },
                      icon: PhosphorIcons.plusMinusBold,
                    ),
                    PrimaryButton(
                      iconColor: primaryColor,
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const OperatorInserted(value: '÷'),
                            );
                      },
                      icon: PhosphorIcons.divideBold,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    PrimaryButton(
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const ValueInserted('7'),
                            );
                      },
                      icon: PhosphorIcons.numberSevenBold,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const ValueInserted('8'),
                            );
                      },
                      icon: PhosphorIcons.numberEightBold,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const ValueInserted('9'),
                            );
                      },
                      icon: PhosphorIcons.numberNineBold,
                    ),
                    PrimaryButton(
                      iconColor: primaryColor,
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const OperatorInserted(value: '×'),
                            );
                      },
                      icon: PhosphorIcons.xBold,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    PrimaryButton(
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const ValueInserted('4'),
                            );
                      },
                      icon: PhosphorIcons.numberFourBold,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const ValueInserted('5'),
                            );
                      },
                      icon: PhosphorIcons.numberFiveBold,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const ValueInserted('6'),
                            );
                      },
                      icon: PhosphorIcons.numberSixBold,
                    ),
                    PrimaryButton(
                      iconColor: primaryColor,
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const OperatorInserted(value: '-'),
                            );
                      },
                      icon: PhosphorIcons.minusBold,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    PrimaryButton(
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const ValueInserted('1'),
                            );
                      },
                      icon: PhosphorIcons.numberOneBold,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const ValueInserted('2'),
                            );
                      },
                      icon: PhosphorIcons.numberTwoBold,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const ValueInserted('3'),
                            );
                      },
                      icon: PhosphorIcons.numberThreeBold,
                    ),
                    PrimaryButton(
                      iconColor: primaryColor,
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const OperatorInserted(value: '+'),
                            );
                      },
                      icon: PhosphorIcons.plusBold,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    PrimaryButton(
                      iconColor: primaryColor,
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const OperatorInserted(value: '%'),
                            );
                      },
                      icon: PhosphorIcons.percentBold,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const ValueInserted('0'),
                            );
                      },
                      icon: PhosphorIcons.numberZeroBold,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const OperatorInserted(value: '.'),
                            );
                      },
                      icon: PhosphorIcons.wifiNoneBold,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              ExpressionCalculated(),
                            );
                      },
                      icon: PhosphorIcons.equalsBold,
                      color: primaryColor,
                      iconColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            )
          ],
        ),
      ),
    );
  }
}
