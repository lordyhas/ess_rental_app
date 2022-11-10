import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'filter_bloc/filter_cubit.dart';
export 'authentication_bloc/authentication_bloc.dart';
export 'authentication_bloc/auth_repository/setup.dart';
export 'navigation_controller_cubit.dart';
export 'login_bloc/login_cubit.dart';




class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    if (kDebugMode) {
      print("$bloc => onEvent() : $event");
    }
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    if (kDebugMode) {
      print("$bloc => onChange() : $change");
    }
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (kDebugMode) {
      print("$bloc => onTransition()  : $transition");
    }
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print("onError()  : $error");
    }
    //print(error);
    super.onError(bloc, error, stackTrace);
  }

}