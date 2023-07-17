abstract class SearchState {}

class InitialSearchState extends SearchState {}

class OnSearchState extends SearchState {
  final String search;

  OnSearchState({required this.search});
}
