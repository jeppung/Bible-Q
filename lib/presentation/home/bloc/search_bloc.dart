import 'package:bible_q/presentation/home/bloc/home_event.dart';
import 'package:bible_q/presentation/home/bloc/home_state.dart';
import 'package:bible_q/presentation/home/bloc/search_event.dart';
import 'package:bible_q/presentation/home/bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitialSearchState()) {
    on<InitialSearchEvent>((event, emit) => null);
  }

  void _initialSearchEvent(
      InitialSearchEvent event, Emitter<SearchState> emit) {
    emit(OnSearchState(search: event.search));
  }
}
