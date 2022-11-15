import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

enum NavigationScreenState{home, explorer,setting,help}



class NavigationControllerCubit extends Cubit<NavigationScreenState> {
  NavigationControllerCubit() : super(NavigationScreenState.home);

  void changeScreen(NavigationScreenState state) => emit(state);
}
/*
class BottomNavigationControllerCubit extends Cubit<NavigationScreenState> {
  BottomNavigationControllerCubit() : super(NavigationScreenState.home);

  void changeScreen(NavigationScreenState state) => emit(state);
}

*/