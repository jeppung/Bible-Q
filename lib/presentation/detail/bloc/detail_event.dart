abstract class DetailEvent {}

class DetailInitialEvent extends DetailEvent {
  final String abbr;

  DetailInitialEvent({required this.abbr});
}