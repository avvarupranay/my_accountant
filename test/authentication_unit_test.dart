import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_accountant/App%20Bloc/app_auth_bloc.dart';
import 'package:my_accountant/Data%20Layer/firebase_data_layer.dart';
import 'package:my_accountant/Global/common_utils.dart';
import 'package:my_accountant/Loading%20Bloc/loading_bloc.dart';

// class Mockdatabase extends Mock with Database{}

void main(){
  late MyAccountantRepository appRepository;
  late AppAuthState initialState;
  late LoadingBloc loadingBloc;
  setUpAll(()async{
    loadingBloc = LoadingBloc();
    // WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();
    // appRepository = MyAccountantRepository();
    // initialState = appRepository.initialState;
  });

  group("Common Utils Test", () {


    test("Indian Phone number test", (){
      String phoneNumber = "7995146783";
      expect(formatPhoneNumber(phoneNumber), "+91 7995-146783");
      phoneNumber = "7842725539";
      expect(formatPhoneNumber(phoneNumber),"+91 7842-725539");
    });


    test("LoadingBloc Test",(){

    });
  });

}