abstract class SearchEvent {}

class InitialSearchEvent extends SearchEvent {
  final String search;

  InitialSearchEvent({required this.search});
}
