

import 'package:bible_q/models/passsage.dart';
import 'package:bible_q/presentation/home/bloc/home_event.dart';
import 'package:bible_q/presentation/home/bloc/home_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(): super(HomeInitialState()) {
    on<HomeInitialEvent>(_getBiblePassages);
    on<HomePassageItemClickEvent>(_homePassageItemClickEvent);

  }

  void _getBiblePassages(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try{
      var data = await Dio().get("https://beeble.vercel.app/api/v1/passage/list");
      var response = passageResponseFromJson(data.toString());
      emit(HomeSuccessState(data: response));
    }catch(e) {
      print(e);
      emit(HomeErrorState());
    }
  }

  void _homePassageItemClickEvent(HomePassageItemClickEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToDetailActionState(abbr: event.abbr));
  }

  void _homeChapterSelectEvent(HomeChapterSelectEvent event, Emitter<HomeState> emit) {
    emit(HomeSelectChapterState());
  }
}