import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calculator/home/bloc/calculator_bloc.dart';
import 'package:flutter_calculator/home/views/widgets/primary_button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  static const Color primaryColor = Colors.purple;
  bool isLongPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    print(_controller.selection.baseOffset);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(_controller.selection.baseOffset.toString(), name: 'off');
    return BlocListener<CalculatorBloc, CalculatorState>(
      listener: (context, state) {
        _controller
          ..text = state.value
          ..selection = TextSelection.fromPosition(
            TextPosition(
              offset: state.index,
            ),
          );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calculate'),
          backgroundColor: primaryColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
            Row(
              children: [
                GestureDetector(
                  onTap: () {
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
                  child: const Icon(
                    PhosphorIcons.arrowLeftBold,
                  ),
                ),
              ],
            ),
            const Divider(
              height: 20,
            ),
            Table(
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      child: IconButton(
                        onPressed: () {
                          context.read<CalculatorBloc>().add(
                                AllCleared(),
                              );
                        },
                        highlightColor: primaryColor.withOpacity(0.2),
                        splashColor: primaryColor.withOpacity(0.2),
                        icon: const Text(
                          'AC',
                          style: TextStyle(
                            fontSize: 26,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                    PrimaryButton(
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          context.read<CalculatorBloc>().add(
                                ValueRemoved(),
                              );
                        }
                      },
                      icon: PhosphorIcons.arrowLeftBold,
                      color: primaryColor,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const OperatorInserted(
                                value: '(',
                                isSpecialValue: true,
                              ),
                            );
                      },
                      icon: PhosphorIcons.plusMinusBold,
                      color: primaryColor,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const OperatorInserted(value: '÷'),
                            );
                      },
                      icon: PhosphorIcons.divideBold,
                      color: primaryColor,
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
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const OperatorInserted(value: '×'),
                            );
                      },
                      icon: PhosphorIcons.xBold,
                      color: primaryColor,
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
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const OperatorInserted(value: '-'),
                            );
                      },
                      icon: PhosphorIcons.minusBold,
                      color: primaryColor,
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
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                              const OperatorInserted(value: '+'),
                            );
                      },
                      icon: PhosphorIcons.plusBold,
                      color: primaryColor,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    PrimaryButton(
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
                    Container(
                      height: 70,
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple,
                      ),
                      child: const Icon(
                        PhosphorIcons.equalsBold,
                        color: Colors.white,
                        size: 26,
                      ),
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
