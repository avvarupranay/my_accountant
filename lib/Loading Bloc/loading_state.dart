part of 'loading_bloc.dart';

@immutable
abstract class LoadingState {}

class InProgress extends LoadingState {
  InProgress(){
    // print("LoadingBloc -> LoadingSate : -> InProgress");
  }
}
class Complete extends LoadingState {
  Complete(){
    // print("LoadingBloc -> LoadingSate : -> Complete");
  }
}


