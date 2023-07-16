
import 'package:bible_q/models/passage_detail.dart';

abstract class DetailState {}

abstract class DetailActionState extends DetailState {}

class DetailInitialState extends DetailState {}

class DetailLoadingState extends DetailState {}

class DetailSuccessState extends DetailState {
  final PassageDetailResponse data;

  DetailSuccessState({required this.data});
}

class DetailErrorState extends DetailState {}