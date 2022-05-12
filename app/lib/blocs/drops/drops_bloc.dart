import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:letsdrop/dto/drop_input.dart';
import 'package:letsdrop/models/drop.dart';
import 'package:letsdrop/services/api_service.dart';
import 'package:letsdrop/services/spotify_service.dart';

part 'drops_event.dart';
part 'drops_state.dart';

class DropsBloc extends Bloc<DropsEvent, DropsState> {
  final ApiService apiService;
  final SpotifyService spotifyService;

  DropsBloc({required this.apiService, required this.spotifyService})
      : super(DropsLoading()) {
    on<LoadDrops>(_onLoadDrops);
    on<AddDrop>(_onAddDrops);
    on<DeleteDrop>(_onDeleteDrops);
  }

  FutureOr<void> _onLoadDrops(LoadDrops event, Emitter<DropsState> emit) async {
    try {

      final isLogged = await spotifyService.isLogged();

      if (!isLogged) throw Exception('Not Authorized');

      final user = await spotifyService.getLoggedUser();
      final token = await spotifyService.getToken();


      final drops = await apiService.getDrops(token, user.id);

      emit(DropsLoaded(drops: drops));
    } catch (e) {
      emit(DropsLoadingFailed());
    }
  }

  FutureOr<void> _onAddDrops(AddDrop event, Emitter<DropsState> emit) async {
    final state = this.state;

    if (state is DropsLoaded) {
      try {
         final isLogged = await spotifyService.isLogged();

          if (!isLogged) throw Exception('Not Authorized');

          final user = await spotifyService.getLoggedUser();
          final token = await spotifyService.getToken();

        final dropToInsert = Drop(
            id: "id",
            album: event.drop.album,
            dropDate: event.drop.dropDate,
            country: event.drop.country,
            artists: event.drop.artists,
            user: user.id);

        final dropCreated = await apiService.createDrop(token, dropToInsert);

        emit(DropsLoaded(drops: List.from(state.drops)..add(dropCreated)));
      } catch (e) {
        emit(DropsCreationFailed());
      }
    }
  }

  FutureOr<void> _onDeleteDrops(
      DeleteDrop event, Emitter<DropsState> emit) async {
    final state = this.state;

    if (state is DropsLoaded) {
      try {

         final isLogged = await spotifyService.isLogged();

        if (!isLogged) throw Exception('Not Authorized');

        
        final token = await spotifyService.getToken();
        
        final dropDeleted = await apiService.deleteDrop(token, event.drop.id);

        emit(DeleteDropState(
            succeded: true,
            drops: state.drops
                .where((element) => element.id != dropDeleted.id)
                .toList()));
      } catch (e) {
        emit(DeleteDropState(succeded: false, drops: state.drops));
      }
    }
  }
}
