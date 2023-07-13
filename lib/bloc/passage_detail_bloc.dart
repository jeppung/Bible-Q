import 'package:bible_q/bloc/detail_ui_state.dart';
import 'package:bible_q/bloc/home_ui_state.dart';
import 'package:bible_q/models/passage_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DetailUiEvent {}

class RequestData extends DetailUiEvent {}


class BlocPassageDetail extends Bloc<DetailUiEvent, DetailUiState> {
  BlocPassageDetail(): super(DetailUiState(state: ScreenState.Loading)) {
    on<RequestData>(_getPassageDetail);
  }

  void _getPassageDetail(DetailUiEvent event, Emitter<DetailUiState> emit) async {
    emit(DetailUiState(state: ScreenState.Loading));
    try {
      var data = await Dio().get("https://beeble.vercel.app/api/v1/passage/Kej/1");
      var response = passageDetailFromJson(data.toString());
      
      emit(DetailUiState(state: ScreenState.Success, data: response.data));
    }catch(e) {
      print(e);
      emit(DetailUiState(state: ScreenState.Error));
    }
  }
}