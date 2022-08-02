import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calculator/home/views/widgets/primary_button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const Color primaryColor = Colors.purple;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculate'),
        backgroundColor: HomeView.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextField(
            onTap: () {
              log(
                _controller.selection.baseOffset.toString(),
                name: 'controller',
              );
            },
            cursorColor: HomeView.primaryColor,
            textAlign: TextAlign.end,
            controller: _controller,
            maxLength: 3,
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
                      onPressed: () {},
                      highlightColor: HomeView.primaryColor.withOpacity(0.2),
                      splashColor: HomeView.primaryColor.withOpacity(0.2),
                      icon: const Text(
                        'AC',
                        style: TextStyle(
                          fontSize: 26,
                          color: HomeView.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  PrimaryButton(
                    onPressed: () {},
                    icon: PhosphorIcons.arrowLeftBold,
                    color: HomeView.primaryColor,
                  ),
                  PrimaryButton(
                    onPressed: () {},
                    icon: PhosphorIcons.plusMinusBold,
                    color: HomeView.primaryColor,
                  ),
                  PrimaryButton(
                    onPressed: () {},
                    icon: PhosphorIcons.divideBold,
                    color: HomeView.primaryColor,
                  ),
                ],
              ),
              TableRow(
                children: [
                  PrimaryButton(
                    onPressed: () {},
                    icon: PhosphorIcons.numberSevenBold,
                  ),
                  PrimaryButton(
                    onPressed: () {},
                    icon: PhosphorIcons.numberEightBold,
                  ),
                  PrimaryButton(
                    onPressed: () {},
                    icon: PhosphorIcons.numberNineBold,
                  ),
                  PrimaryButton(
                    onPressed: () {},
                    icon: PhosphorIcons.xBold,
                    color: HomeView.primaryColor,
                  ),
                ],
              ),
              TableRow(
                children: [
                  PrimaryButton(
                    onPressed: () {},
                    icon: PhosphorIcons.numberFourBold,
                  ),
                  PrimaryButton(
                    onPressed: () {},
                    icon: PhosphorIcons.numberFiveBold,
                  ),
                  PrimaryButton(
                    onPressed: () {},
                    icon: PhosphorIcons.numberSixBold,
                  ),
                  PrimaryButton(
                    onPressed: () {},
                    icon: PhosphorIcons.minusBold,
                    color: HomeView.primaryColor,
                  ),
                ],
              ),
              TableRow(
                children: [
                  PrimaryButton(
                    onPressed: () {},
                    icon: PhosphorIcons.numberOneBold,
                  ),
                  PrimaryButton(
                    onPressed: () {},
                    icon: PhosphorIcons.numberTwoBold,
                  ),
                  PrimaryButton(
                    onPressed: () {},
                    icon: PhosphorIcons.numberThreeBold,
                  ),
                  PrimaryButton(
                    onPressed: () {},
                    icon: PhosphorIcons.plusBold,
                    color: HomeView.primaryColor,
                  ),
                ],
              ),
              TableRow(
                children: [
                  PrimaryButton(
                    onPressed: () {},
                    icon: PhosphorIcons.percentBold,
                  ),
                  PrimaryButton(
                    onPressed: () {},
                    icon: PhosphorIcons.numberZeroBold,
                  ),
                  PrimaryButton(
                    onPressed: () {},
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
    );
  }
}
