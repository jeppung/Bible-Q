import 'package:bible_q/models/passsage.dart';

enum ScreenState {Loading, Success, Error}


class HomeUiState {
  ScreenState state;
  List<Passage>? data;

  HomeUiState({required this.state, this.data});
}