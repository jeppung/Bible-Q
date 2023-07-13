

import 'package:bible_q/bloc/home_ui_state.dart';
import 'package:bible_q/models/passage_detail.dart';

class DetailUiState {
  ScreenState state;
  PassageDetail? data;

  DetailUiState({required this.state, this.data});
}