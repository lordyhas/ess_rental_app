import 'package:equatable/equatable.dart';
import 'package:exploress_location/logic/model/data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'rental_controller_event.dart';

part 'rental_controller_state.dart';

class RentalControllerBloc
    extends Bloc<RentalControllerEvent, RentalControllerState> {
  RentalControllerBloc() : super(const RentalControllerState.initial()) {
    on<SpaceRentalPassed>(_onSpaceRentalPassed);
    on<SpaceRentalImaged>(_onSpaceRentalImaged);
    on<SpaceRentalCompleted>(_onSpaceRentalCompleted);
    on<VehicleRentalPassed>(_onVehicleRentalPassed);
    on<VehicleRentalImaged>(_onVehicleRentalImaged);
    on<VehicleRentalCompleted>(_onVehicleRentalCompleted);
  }

  RentalType get rentalType => state.rentalType;
  
  void _onSpaceRentalPassed(SpaceRentalPassed event, 
      Emitter<RentalControllerState> emit){
    emit(RentalControllerState.space(event.rental));
    
  }

  void _onSpaceRentalImaged(SpaceRentalImaged event,
      Emitter<RentalControllerState> emit){
    emit(RentalControllerState.space(
        event.rental,
        status: RentalControllerStatus.addingImages
    ));
  }

  void _onSpaceRentalCompleted(SpaceRentalCompleted event,
      Emitter<RentalControllerState> emit){
    emit(RentalControllerState.complete(event.rental));
  }




  void _onVehicleRentalPassed(VehicleRentalPassed event,
      Emitter<RentalControllerState> emit){
    emit(RentalControllerState.vehicle(event.rental));
  }
  void _onVehicleRentalImaged(VehicleRentalImaged event,
      Emitter<RentalControllerState> emit){
    emit(RentalControllerState.vehicle(
        event.rental,
        status: RentalControllerStatus.addingImages
    ));
  }

  void _onVehicleRentalCompleted(VehicleRentalCompleted event,
      Emitter<RentalControllerState> emit){
    emit(RentalControllerState.complete(event.rental));

  }


}
