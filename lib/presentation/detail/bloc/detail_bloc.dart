

import 'package:bible_q/models/passage_detail.dart';
import 'package:bible_q/presentation/detail/bloc/detail_event.dart';
import 'package:bible_q/presentation/detail/bloc/detail_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc(): super(DetailInitialState()) {
    on<DetailInitialEvent>(_getPassageDetail);
  }

  void _getPassageDetail(DetailInitialEvent event, Emitter<DetailState> emit) async {
    emit(DetailLoadingState());
    try{
      var data = await Dio().get("https://beeble.vercel.app/api/v1/passage/${event.abbr}/1");
      var response = passageDetailFromJson(data.toString());
      emit(DetailSuccessState(data: response));
    }catch(e) {
      print(e);
      emit(DetailErrorState());
    }
  }
}