import 'package:bible_q/presentation/home/bloc/home_bloc.dart';
import 'package:bible_q/presentation/home/bloc/home_event.dart';
import 'package:bible_q/presentation/home/bloc/home_state.dart';
import 'package:bible_q/presentation/detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of(context)..add(HomeInitialEvent());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bible-Q"),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: _homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          switch(state.runtimeType) {
            case HomeNavigateToDetailActionState: {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(abbr: (state as HomeNavigateToDetailActionState).abbr)));
            }
          }
        },
        builder: (context, state) {
          switch(state.runtimeType) {
            case HomeLoadingState: {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            case HomeErrorState: {
              return const Center(
                child: Text("An Error Occured!"),
              );
            }
            case HomeSuccessState: {
              final listPassage = (state as HomeSuccessState).data.data;
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
                itemCount: listPassage.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      showDialog(context: context, builder: (context) => AlertDialog(
                        title: Text("Select pasal and ayat"),
                        content: Row(
                          children: [
                            DropdownButton(
                              items: List.generate(listPassage[index].chapter, (index) => DropdownMenuItem(child: Text(index.toString()), value: index,)), 
                              onChanged: (value) => print(value), 
                            
                              hint: Text("Chapter"),
                            ),
                          ],
                        ),
                
                      ));
                    },
                    title: Text(listPassage[index].name),
                    
                  );
                },
              );
            }
            default: {
                return const SizedBox();
            }
          }
        },
      )
    );
  }
}