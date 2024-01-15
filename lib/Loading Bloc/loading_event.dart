part of 'loading_bloc.dart';

@immutable
abstract class LoadingEvent {}


class FireLoading extends LoadingEvent{
  FireLoading(){
    // print("LoadingBloc -> LoadingEvent : -> FireLoading");
  }
}
class CompleteLoading extends LoadingEvent{
  CompleteLoading(){
    // print("LoadingBloc -> LoadingEvent : -> CompleteLoading");
  }
}
