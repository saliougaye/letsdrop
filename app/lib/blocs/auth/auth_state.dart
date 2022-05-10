part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailed extends AuthState {
  final String message;

  const AuthFailed({ required this.message});

  @override
  List<Object> get props => [message];
}

class AuthNotAuthenticated extends AuthState {}

class AuthAuthenticated extends AuthState {
  final SpotifyUser user;

  const AuthAuthenticated({ required this.user});

  @override
  List<Object> get props => [user];
}


