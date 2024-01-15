part of '../app_auth_bloc.dart';

@immutable
class AppAuthState {
  final User? user;
  const AppAuthState.authenticated(this.user);
  const AppAuthState.unAuthenticated() : user = null;
  bool get isAuthenticated => user!=null? true : false;
}
