part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}


class AppLoaded extends AuthEvent {}

class UserLoggedIn extends AuthEvent {
  final SpotifyUser user;

  const UserLoggedIn({ required this.user});

  @override
  List<Object> get props => [user];
}


class UserRequestLogin extends AuthEvent {}