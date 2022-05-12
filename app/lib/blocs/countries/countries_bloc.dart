import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:letsdrop/models/country.dart';
import 'package:letsdrop/services/api_service.dart';
import 'package:letsdrop/services/spotify_service.dart';

part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  
  final ApiService apiService;
  final SpotifyService spotifyService;
  
  CountriesBloc({ required this.apiService, required this.spotifyService }) : super(CountriesLoading()) {
    on<LoadCountries>(_onLoadCountries);
  }

  FutureOr<void> _onLoadCountries(LoadCountries event, Emitter<CountriesState> emit) async {

    try {

      final userLogged = await spotifyService.isLogged();


      if(!userLogged) {
        throw Exception("User Not Logged");
      }

      final token = await spotifyService.getToken();


      final countries = await apiService.getCountries(token);

      emit(
        CountriesLoaded(countries: countries)
      );

    } catch (e) {

      emit(
        CountriesLoadingFailed()
      );
    }
  }
}
