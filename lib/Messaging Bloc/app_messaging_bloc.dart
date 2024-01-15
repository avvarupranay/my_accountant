import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_accountant/Data%20Layer/firebase_messaging_layer.dart';

part 'app_messaging_event.dart';
part 'app_messaging_state.dart';

class AppMessagingBloc extends Bloc<AppMessagingEvent, AppMessagingState> {
  late StreamSubscription<RemoteMessage> foregroundMessageStream;
  AppMessagingBloc() : super(AppMessagingInitial()) {
    foregroundMessageStream = AppMessaging.foregroundMessageStream.listen((message) {
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
      }
      if (kDebugMode) {
        print('Message data: ${message.data}');
      }
      if (message.notification != null) {
        if (kDebugMode) {
          print('Message also contained a notification: ${message.notification}');
        }
      }
    });
    on<AppMessagingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
  @override
  Future<void> close() {
    foregroundMessageStream.cancel();
    return super.close();
  }
}
