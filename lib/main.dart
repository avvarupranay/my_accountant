import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_accountant/Data%20Layer/firebase_data_layer.dart';
import 'package:my_accountant/Global/global_routes/App%20Routes/app_routes.dart';
import 'package:my_accountant/Loading%20Bloc/loading_bloc.dart';

import 'App Bloc/app_auth_bloc.dart';
import 'Authenticated Routes/user_info_update_screen.dart';
import 'Data Layer/app_shared_pref.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(RootAppInjector(
    child: const MyApp(),
  ));
}

// ignore: must_be_immutable
class RootAppInjector extends InheritedWidget {
  late AppAuthState initialAuthenticationState;
  late MyAccountantRepository myAccountantAuth;
  late bool? userInfoAvailable;
  String initialScreen = "";
  @override
  final Widget child;

  RootAppInjector(
      {super.key, required this.child})
      : super(child: child) {
    myAccountantAuth = MyAccountantRepository();
    if (myAccountantAuth.authInstance.currentUser != null) {
      myAccountantAuth.setFunctions = FirebaseFunctions.instance;
      initialAuthenticationState =
          AppAuthState.authenticated(myAccountantAuth.authInstance.currentUser);
    } else {
      initialAuthenticationState = const AppAuthState.unAuthenticated();
    }
    fetchUserInfo();
    initialScreen = MyAccountantRouter.initialRoute(
        initialAuthenticationState.user, userInfoAvailable);
  }

  void fetchUserInfo()async{
    userInfoAvailable = await AppSharedPreferences.getUserInfoAvailableFlag();
    print("userInfoAvailable : ${userInfoAvailable}");
  }

  static RootAppInjector of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RootAppInjector>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

RouteObserver routeObserver = RouteObserver();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (blocContext) => AppBloc(
              initialAuthenticationState:
                  RootAppInjector.of(context).initialAuthenticationState,
              firebaseRepository: RootAppInjector.of(context).myAccountantAuth),
        ),
        BlocProvider(
          create: (blocContext) => LoadingBloc(),
        ),
      ],
      child: BlocListener<AppBloc, AppAuthState>(
        listener: (context, state) {
          print("My-Accountant : ${state.user}");
        },
        child: MaterialApp(
          title: 'My Accountant',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: MyAccountantRouter.routes,
          initialRoute: RootAppInjector.of(context).initialScreen,
          navigatorObservers: [routeObserver],
        ),
      ),
    );
  }
}