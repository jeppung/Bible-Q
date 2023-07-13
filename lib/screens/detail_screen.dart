
import 'package:bible_q/bloc/detail_ui_state.dart';
import 'package:bible_q/bloc/home_ui_state.dart';
import 'package:bible_q/bloc/passage_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late BlocPassageDetail _blocPassageDetail;

  @override
  void initState() {
    super.initState();
    _blocPassageDetail = BlocProvider.of(context);
    _blocPassageDetail.add(RequestData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<BlocPassageDetail, DetailUiState>(builder: (_, state) {
          if(state.state == ScreenState.Success) {
            return Text(state.data!.book.name);
          }else{
            return SizedBox(); 
          }
        },),
      ),
      body: StreamBuilder(
        stream: _blocPassageDetail.stream,
        builder: (context, snapshot) {
          switch(snapshot.data?.state){
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
              final passageDetail = snapshot.data!.data;
              return Center(
                child: Expanded(
                      child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      itemCount: passageDetail!.verses.length,
                      itemBuilder: (context, index) {
                        return index != 0 ? Card(
                              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(child: Text("${index}", style: TextStyle(fontWeight: FontWeight.bold),), flex: 1,),
                                    Expanded(child: Text(passageDetail.verses[index+0].content), flex: 10,)
                                  ],
                                ),
                              ),
                            ): Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                passageDetail.verses[0].content, 
                                textAlign: TextAlign.center, 
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                                
                              ),
                            );
                      },
                                      ),
                    ),
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