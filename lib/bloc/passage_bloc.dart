import 'package:bible_q/bloc/home_ui_state.dart';
import 'package:bible_q/models/passsage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

abstract class HomeUiEvent {}

class RequestData extends HomeUiEvent {}

class BlocPassage extends Bloc<HomeUiEvent, HomeUiState> {
  BlocPassage(): super(HomeUiState(state: ScreenState.Loading)){
    on<RequestData>(_getPassages);
  }

  void _getPassages(HomeUiEvent event, Emitter<HomeUiState> emit) async {
    emit(HomeUiState(state: ScreenState.Loading));

    try{
      var data = await Dio().get("https://beeble.vercel.app/api/v1/passage/list");
      var response = passageResponseFromJson(data.toString());

      emit(HomeUiState(state: ScreenState.Success, data: response.data));
    }catch(e){
      print(e);
      emit(HomeUiState(state: ScreenState.Error));
    }
  }
}