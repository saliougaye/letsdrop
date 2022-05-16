import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:letsdrop/models/user.dart';
import 'package:letsdrop/services/spotify_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  
  final SpotifyService spotifyService;
  
  AuthBloc({ required this.spotifyService }) : super(AuthInitial()) {
    on<AppLoaded>(_onAppLoaded);
    on<UserLoggedIn>(_onUserLoggedIn);
    on<UserRequestLogin>(_onUserRequestLogin);
  }

  FutureOr<void> _onAppLoaded(AppLoaded event, Emitter<AuthState> emit) async{

    emit(AuthLoading());

    try {
      
    final userLogged = await spotifyService.isLogged();


    if(userLogged != null) {
      emit(
        AuthAuthenticated(user: userLogged)
      ); 
    } else {
      emit(
        AuthNotAuthenticated()
      );
    }
    } catch (e) {
      emit(
        const AuthFailed(message: "An unknown error occured") // TODO fix
      );
    }
    


  }

  FutureOr<void> _onUserLoggedIn(UserLoggedIn event, Emitter<AuthState> emit) {
    emit(
      AuthAuthenticated(user: event.user)
    );
  }

  

  FutureOr<void> _onUserRequestLogin(UserRequestLogin event, Emitter<AuthState> emit) async {
    try {
      final user = await spotifyService.login();

      emit(
        AuthAuthenticated(user: user)
      );
    } catch (e) {
      emit(
        const AuthFailed(message: "An unknown error occured") // TODO fix
      );
    }
  }
}
