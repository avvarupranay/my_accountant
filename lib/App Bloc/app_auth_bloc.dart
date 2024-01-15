import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_accountant/Data%20Layer/firebase_data_layer.dart';

import '../Data Layer/app_shared_pref.dart';

part 'app_auth_events/app_auth_event.dart';
part 'app_auth_states/app_auth_state.dart';

class AppBloc extends Bloc<AppAuthEvent, AppAuthState> {
  final AppAuthState initialAuthenticationState;
  final MyAccountantRepository firebaseRepository;
  late final StreamSubscription<User?> _userSubscription;
  bool? userInfoAvailableFlag;
  late User appUser;
  AppBloc({required this.initialAuthenticationState , required this.firebaseRepository}) : super(initialAuthenticationState) {
    //EVENT-1
    on<UserAuthenticationChange>(_onUserChanged);
    _userSubscription = firebaseRepository.user.listen((user) {
      add(UserAuthenticationChange(user));
    });
  }
  // @override
  // void on<E extends AppAuthEvent>(EventHandler<E, AppAuthState> handler, {EventTransformer<E>? transformer}) {
  //   // TODO: implement on
  //   super.on(handler, transformer);
  // }

  @override
  void onChange(Change<AppAuthState> change) {
    super.onChange(change);
  }


  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(error, stackTrace);
  }

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }


  @override
  void onEvent(AppAuthEvent event) {
    // TODO: implement onEvent
    super.onEvent(event);
  }


  @override
  void onTransition(Transition<AppAuthEvent, AppAuthState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
  }

  void _onUserChanged(UserAuthenticationChange event, Emitter<AppAuthState> emit) {
    emit(getAuthenticatedState(event.user));
  }

  AppAuthState getAuthenticatedState(User? user){
    if(user!=null){
      firebaseRepository.initiateFunctions();
      appUser = user;
      return AppAuthState.authenticated(user);
    }
    else{
      return const AppAuthState.unAuthenticated();
    }
  }


  registerUser(String email , String password) async{
    await firebaseRepository.signUpUser(email, password);
    userInfoAvailableFlag = await getUserInfoFlag();
    print("Registration Successfull");
  }

  userLogin(String email , String password)async{
    await firebaseRepository.userLogin(email, password);
    print("Login Successfull");
  }

  Future<bool?> getUserInfoFlag() async{
     return AppSharedPreferences.getUserInfoAvailableFlag();
  }



  @override
  Future<void> close() {
    //closing the authentication subscription.
    _userSubscription.cancel();
    return super.close();
  }
}
