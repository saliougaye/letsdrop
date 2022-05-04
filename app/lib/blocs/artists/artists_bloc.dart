import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:letsdrop/models/artist.dart';
import 'package:letsdrop/services/api_service.dart';

part 'artists_event.dart';
part 'artists_state.dart';

class ArtistsBloc extends Bloc<ArtistsEvent, ArtistsState> {
  
  final ApiService apiService;
  
  ArtistsBloc({ required this.apiService }) : super(ArtistsLoading()) {
    on<LoadArtists>(_onLoadArtists);
  }

  FutureOr<void> _onLoadArtists(LoadArtists event, Emitter<ArtistsState> emit) async {

    try {

      final artists = await apiService.getArtists(event.name, event.token);

      emit(
        ArtistsLoaded(artists: artists)
      );

    } catch (e) {
      emit(
        ArtistsLoadingFailed()
      );
    }
  }
}
