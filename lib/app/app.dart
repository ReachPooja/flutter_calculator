import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calculator/home/bloc/calculator_bloc.dart';
import 'package:flutter_calculator/home/views/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculatorBloc(),
      child: const MaterialApp(
        home: HomeView(),
      ),
    );
  }
}
