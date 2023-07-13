

import 'package:bible_q/bloc/home_ui_state.dart';
import 'package:bible_q/bloc/passage_bloc.dart';
import 'package:bible_q/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BlocPassage _blocPassage;

  @override
  void initState() {
    super.initState();
    _blocPassage = BlocProvider.of(context);
    _blocPassage.add(RequestData());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bible-Q"),
      ),
      body: StreamBuilder(
        stream: _blocPassage.stream,
        builder: (context, snapshot) {
          switch(snapshot.data?.state) {
            case ScreenState.Loading : {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            case ScreenState.Error : {
              return const Center(
                child: Text("Error"),
              );
            }
            case ScreenState.Success : {
              var listPassage = snapshot.data!.data;
              return ListView.separated(
                separatorBuilder: (context, index) {
                    if(index == 38){
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text("Perjanjian Baru", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                itemCount: listPassage!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(),));
                    },
                    title: Text(listPassage[index].name),
                    
                  );
                },
              );
            }
            default: {
              return const Text("Default");
            }
          }
        },
      ),
    );
  }
}