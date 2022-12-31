import 'package:equatable/equatable.dart';
import 'package:exploress_rental/logic/model/data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'rental_controller_event.dart';

part 'rental_controller_state.dart';


/// goal to save the state [AddRentPage] form while editing till end send it to
/// a database
///
/// [RentalControllerBloc] is a form state saver
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
  bool get isMovable => state.isMovable;
  bool get isImmovable => !state.isMovable;

  RentalVehicle get vehicle =>  state._vehicle;
  RentalSpace get space =>  state._space;

  void _onSpaceRentalPassed(SpaceRentalPassed event, 
      Emitter<RentalControllerState> emit){
    emit(RentalControllerState.space(event.rental));
  }
  void addSpaceRentalPassed(RentalSpace rent) => add(SpaceRentalPassed(rent));

  void _onSpaceRentalImaged(SpaceRentalImaged event,
      Emitter<RentalControllerState> emit){
    emit(RentalControllerState.space(
        event.rental,
        status: RentalControllerStatus.addingImages
    ));
  }
  void addSpaceRentalImaged(RentalSpace rent) => add(SpaceRentalImaged(rent));

  void _onSpaceRentalCompleted(SpaceRentalCompleted event,
      Emitter<RentalControllerState> emit){
    emit(RentalControllerState.complete(event.rental));

  }
  void addSpaceRentalCompleted(RentalSpace r) => add(SpaceRentalCompleted(r));


  // --- --- ---


  void _onVehicleRentalPassed(VehicleRentalPassed event,
      Emitter<RentalControllerState> emit){
    emit(RentalControllerState.vehicle(event.rental));
  }
  void addVehicleRentalPassed(RentalVehicle r) => add(VehicleRentalPassed(r));

  void _onVehicleRentalImaged(VehicleRentalImaged event,
      Emitter<RentalControllerState> emit){
    emit(RentalControllerState.vehicle(
        event.rental,
        status: RentalControllerStatus.addingImages
    ));
  }
  void addVehicleRentalImaged(RentalVehicle r) => add(VehicleRentalImaged(r));

  void _onVehicleRentalCompleted(VehicleRentalCompleted event,
      Emitter<RentalControllerState> emit){
    emit(RentalControllerState.complete(event.rental));
  }

  void addVehicleRentalCompleted(RentalVehicle r) =>
      add(VehicleRentalCompleted(r));
  




}
