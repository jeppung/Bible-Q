import 'package:bible_q/presentation/detail/bloc/detail_bloc.dart';
import 'package:bible_q/presentation/home/bloc/home_bloc.dart';
import 'package:bible_q/presentation/home/bloc/search_bloc.dart';
import 'package:bible_q/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => DetailBloc()),
        BlocProvider(create: (context) => SearchBloc())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
