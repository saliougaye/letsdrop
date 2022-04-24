part of 'drops_bloc.dart';

abstract class DropsEvent extends Equatable {
  const DropsEvent();

  @override
  List<Object> get props => [];
}

class LoadDrops extends DropsEvent {
}

class AddDrop extends DropsEvent {
  final Drop drop;

  const AddDrop({ required this.drop });

  @override
  List<Object> get props => [drop];
}

class DeleteDrop extends DropsEvent {
  final Drop drop;

  const DeleteDrop({ required this.drop });

  @override
  List<Object> get props => [drop];
}
