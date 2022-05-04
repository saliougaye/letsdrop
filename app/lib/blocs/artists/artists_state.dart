part of 'artists_bloc.dart';

abstract class ArtistsState extends Equatable {
  const ArtistsState();
  
  @override
  List<Object> get props => [];
}

class ArtistsLoading extends ArtistsState {}

class ArtistsLoadingFailed extends ArtistsState {}

class ArtistsLoaded extends ArtistsState {

  final List<Artist> artists;

  const ArtistsLoaded({ required this.artists });
}