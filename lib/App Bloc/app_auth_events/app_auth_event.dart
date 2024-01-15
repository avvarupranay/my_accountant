part of '../app_auth_bloc.dart';

@immutable
abstract class AppAuthEvent {

}
class UserAuthenticationChange extends AppAuthEvent{
  final User? user;
  UserAuthenticationChange(this.user);
}