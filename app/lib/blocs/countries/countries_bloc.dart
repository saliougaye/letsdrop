import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:letsdrop/models/country.dart';
import 'package:letsdrop/services/api_service.dart';

part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  
  final ApiService apiService;
  
  CountriesBloc({ required this.apiService }) : super(CountriesLoading()) {
    on<LoadCountries>(_onLoadCountries);
  }

  FutureOr<void> _onLoadCountries(LoadCountries event, Emitter<CountriesState> emit) async {

    try {

      final countries = await apiService.getCountries();

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
