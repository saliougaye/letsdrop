part of 'artists_bloc.dart';

abstract class ArtistsEvent extends Equatable {
  const ArtistsEvent();

  @override
  List<Object> get props => [];
}


class LoadArtists extends ArtistsEvent {
  final String name;
  final String token;

  const LoadArtists({
    required this.name,
    required this.token
  });
}