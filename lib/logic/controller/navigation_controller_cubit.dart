import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

enum NavigationScreenState{home, explorer,setting}

class NavigationControllerCubit extends Cubit<NavigationScreenState> {
  NavigationControllerCubit() : super(NavigationScreenState.explorer);

  void changeScreen(NavigationScreenState state) => emit(state);

}
