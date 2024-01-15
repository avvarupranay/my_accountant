import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(Complete()) {
    on<FireLoading>((event, emit) {
      emit(InProgress());
    });
    on<CompleteLoading>((event, emit){
      emit(Complete());
    });
  }
}
