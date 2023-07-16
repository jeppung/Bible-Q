import 'package:bible_q/presentation/detail/bloc/detail_bloc.dart';
import 'package:bible_q/presentation/detail/bloc/detail_event.dart';
import 'package:bible_q/presentation/detail/bloc/detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatefulWidget {
  final String abbr;

  const DetailScreen({super.key, required this.abbr});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late DetailBloc _detailBloc;

  @override
  void initState() {
    super.initState();
    _detailBloc = BlocProvider.of<DetailBloc>(context)..add(DetailInitialEvent(abbr: widget.abbr));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer(
        bloc: _detailBloc,
        listener: (context, state) => state,
        buildWhen: (previous, current) => current is DetailState,
        builder: (context, state) {
          switch(state.runtimeType) {
            case DetailLoadingState: {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            case DetailErrorState: {
              return const Center(
                child: Text("An Error Occured"),
              );
            }
            case DetailSuccessState: {
              final data = (state as DetailSuccessState).data.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: data.verses.length,
                  itemBuilder: (context, index) {
                    if(data.verses[index].verse == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Column(
                          children: [
                            const SizedBox(height: 15),
                            Text(data.verses[index].content, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                            const SizedBox(height: 15),
                          ],
                        ),
                      );
                    }else{
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Text(data.verses[index].verse.toString(), style: TextStyle(fontWeight: FontWeight.bold),), flex: 1),
                              Expanded(child: Text(data.verses[index].content), flex: 10)
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              );
            }
            default: {
              return const SizedBox();
            }
          }
        },
      ),
    );
  }
}