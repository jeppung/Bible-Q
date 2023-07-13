

import 'package:bible_q/bloc/passage_bloc.dart';
import 'package:bible_q/bloc/passage_detail_bloc.dart';
import 'package:bible_q/screens/home_screen.dart';
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
      BlocProvider(create: (context) => BlocPassage()),
      BlocProvider(create: (context) => BlocPassageDetail())
    ], 
    child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}