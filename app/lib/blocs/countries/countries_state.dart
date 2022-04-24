part of 'countries_bloc.dart';

abstract class CountriesState extends Equatable {
  const CountriesState();
  
  @override
  List<Object> get props => [];
}

class CountriesLoading extends CountriesState {}

class CountriesLoadingFailed extends CountriesState {}

class CountriesLoaded extends CountriesState {

  final List<Country> countries;

  const CountriesLoaded({ required this.countries });
}
