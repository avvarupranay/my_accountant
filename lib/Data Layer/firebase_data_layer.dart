import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:my_accountant/App%20Bloc/app_auth_bloc.dart';
import 'package:my_accountant/Global/app_constants.dart';

class MyAccountantRepository {
  final FirebaseAuth authInstance;
  late FirebaseFunctions _functions;
  late HttpsCallableResult httpsCallableResult;

  MyAccountantRepository() : authInstance = FirebaseAuth.instance;

  /*----------APP-FIREBASE-SETUP----------*/

  set setFunctions(FirebaseFunctions functions){
    _functions = functions;
  }

  void initiateFunctions(){
    _functions = FirebaseFunctions.instance;
  }

  AppAuthState get initialState => authInstance.currentUser!=null ? AppAuthState.authenticated(authInstance.currentUser) : const AppAuthState.unAuthenticated();

  Stream<User?> get user{
    authInstance.authStateChanges().listen((event) {

    });
    return _listenAuthStateChanges().map((firebaseUser){
      return firebaseUser;
    });
  }

  FirebaseFunctions get functions => _functions;


  /*----------FIREBASE-AUTHENTICATION----------*/
  Stream<User?> _listenAuthStateChanges() {
    return authInstance.authStateChanges();
  }
  Future<UserCredential> userLogin(String email , String password){
    return authInstance.signInWithEmailAndPassword(email: email, password: password);
  }
  Future<void> logOut(){
    return authInstance.signOut();
  }
  signUpUser(String email , String password){
    return authInstance.createUserWithEmailAndPassword(email: email, password: password);
  }

  /*----------FIREBASE-CLOUD-FUNCTIONS----------*/
  Future<bool?> checkUserInfoAvailable()async{
    httpsCallableResult = await _functions.httpsCallable(AppConstants.IS_USER_INFO_AVAILABLE).call();
    return httpsCallableResult.data as bool;
  }

  Future<void> addUserInformation(Map<String , dynamic> userInformation) async{
    httpsCallableResult = await _functions.httpsCallable(AppConstants.UPLOAD_USER_INFO).call(userInformation);
  }
}



