import 'package:equatable/equatable.dart';
import 'package:exploress_location/logic/model/data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'rental_controller_event.dart';
part 'rental_controller_state.dart';

class RentalControllerBloc extends Bloc<RentalControllerEvent, RentalControllerState> {
  RentalControllerBloc() : super(RentalControllerInitial()) {
    on<RentalControllerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
