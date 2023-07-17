import 'package:bible_q/models/passsage.dart';
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
  String search = "";

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
          switch (state.runtimeType) {
            case HomeNavigateToDetailActionState:
              {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      abbr: (state as HomeNavigateToDetailActionState).abbr,
                      chapter: (state).chapter,
                    ),
                  ),
                );
              }
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            case HomeErrorState:
              {
                return const Center(
                  child: Text("An Error Occured!"),
                );
              }
            case HomeSuccessState:
              {
                final listPassage = (state as HomeSuccessState).data.data;
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: "Search Passage...",
                        ),
                        onChanged: (value) {
                          setState(() {
                            search = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: PassageList(
                        listPassage: listPassage,
                        homeBloc: _homeBloc,
                        runtimeType: runtimeType,
                        search: search,
                      ),
                    ),
                  ],
                );
              }
            default:
              {
                print("default");
                return const SizedBox();
              }
          }
        },
      ),
    );
  }
}

class PassageList extends StatelessWidget {
  const PassageList(
      {super.key,
      required this.listPassage,
      required HomeBloc homeBloc,
      required this.runtimeType,
      required this.search})
      : _homeBloc = homeBloc;

  final List<Passage> listPassage;
  final HomeBloc _homeBloc;
  final Type runtimeType;
  final String? search;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) {
        if (index == 38) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  "Perjanjian Baru",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
      itemCount: listPassage
          .where((element) =>
              element.name.toLowerCase().contains(search?.toLowerCase() ?? ""))
          .length,
      itemBuilder: (context, index) {
        return PassageItem(
          passage: listPassage
              .where((element) => element.name
                  .toLowerCase()
                  .contains(search?.toLowerCase() ?? ""))
              .toList()[index],
          homeBloc: _homeBloc,
          runtimeType: runtimeType,
        );
      },
    );
  }
}

class PassageItem extends StatelessWidget {
  const PassageItem({
    super.key,
    required this.passage,
    required HomeBloc homeBloc,
    required this.runtimeType,
  }) : _homeBloc = homeBloc;

  final Passage passage;
  final HomeBloc _homeBloc;
  final Type runtimeType;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(passage.name),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return StreamBuilder(
              stream: _homeBloc.stream,
              initialData: null,
              builder: (context, snapshot) {
                return AlertDialog(
                  title: Text("Select chapter"),
                  content: DropdownButton(
                    items: List.generate(
                      passage.chapter,
                      (index) => DropdownMenuItem(
                        value: index + 1,
                        child: Text((index + 1).toString()),
                      ),
                    ),
                    hint: const Text("Chapter"),
                    value: snapshot.data.runtimeType != HomeSelectChapterState
                        ? null
                        : (snapshot.data as HomeSelectChapterState).chapter,
                    onChanged: (value) {
                      _homeBloc.add(
                        HomeChapterSelectEvent(chapter: value),
                      );
                    },
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _homeBloc.add(
                          HomePassageItemClickEvent(
                              abbr: passage.abbr,
                              chapter: snapshot.data == null
                                  ? 1
                                  : (snapshot.data as HomeSelectChapterState)
                                      .chapter),
                        );
                      },
                      child: const Text("OK"),
                    )
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
