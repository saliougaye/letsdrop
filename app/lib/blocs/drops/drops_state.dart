part of 'drops_bloc.dart';

abstract class DropsState extends Equatable {
  const DropsState();
  
  @override
  List<Object> get props => [];
}

class DropsLoading extends DropsState {}

class DropsLoaded extends DropsState {
  final List<Drop> drops;

  const DropsLoaded({ required this.drops });

  @override
  List<Object> get props => [drops];
}

class DropsLoadingFailed extends DropsState {}

class DropsCreationFailed extends DropsState {}


class DeleteDropState extends DropsState {
  final bool succeded;
  final List<Drop> drops;

  const DeleteDropState({ required this.succeded, required this.drops });

  @override
  List<Object> get props => [drops];
}

