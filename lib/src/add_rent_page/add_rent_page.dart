library rent_page;

import 'dart:async';
import 'dart:io';


import 'package:exploress_location/logic/model/data_model.dart';
import 'package:exploress_location/logic/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_cropper/image_cropper.dart';
//import 'package:utils_component/utils_component.dart' hide Go;

part 'rent_verification.dart';
part 'rent_upload_image.dart';
part 'rent_form.dart';


enum StepperStep{zero,one,two}

class AddRentPage extends StatelessWidget {
  static const routeName = "/home/user/form?id=sfr";
  const AddRentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Faire louer"),),
      body: const RentScreen(),
    );
  }
}


class RentScreen extends StatefulWidget {
  const RentScreen({Key? key}) : super(key: key);

  @override
  State<RentScreen> createState() => _RentScreenState();
}

class _RentScreenState extends State<RentScreen> {
  late StepperStep _index;
  final GlobalKey<FormState> validator = GlobalKey<FormState>();
  late final List<TextEditingController> controllers;
  late final Map<String,TextEditingController> spaceCtrl;
  late final Map<String,TextEditingController> vehicleCtrl;

  @override
  void initState() {
    RentalSpace space = RentalSpace.empty;
    RentalVehicle vehicle = RentalVehicle.empty ;
    super.initState();
    _index = StepperStep.zero;
    controllers = List<TextEditingController>
        .generate(10, (index) => TextEditingController());
        //.filled(10, TextEditingController());
    /*ctrl = {
      'id': TextEditingController(),
      'label': TextEditingController(),
      'room': TextEditingController(),
      'price': TextEditingController(),
      'address': TextEditingController(),
      'coordinates': TextEditingController(),
      'spaceType': TextEditingController(),
      'description': TextEditingController(),
      'owner': TextEditingController(),
      'imageUrl': TextEditingController(),
      'images': TextEditingController(),
      'isTaken': TextEditingController(),
    };*/
    spaceCtrl = space.toMap().map((key, value) => MapEntry(key, TextEditingController()));
    vehicleCtrl = vehicle.toMap().map((key, value) => MapEntry(key, TextEditingController()));


  }


  @override
  Widget build(BuildContext context) {

    //BlocProvider.of<RentalControllerBloc>(context).state;

    return SizedBox(
      width: 720,
      child: Stepper(
        currentStep: _index.index,
        onStepCancel: () {
          switch(_index){
            case StepperStep.zero:
              break;
            case StepperStep.one:
              setState((){_index = StepperStep.zero;});
              break;
            case StepperStep.two:
              setState((){_index = StepperStep.one;});
              break;
          }
        },
        onStepContinue: () {
          switch(_index){
            case StepperStep.zero:
              if (validator.currentState!.validate()){
                validator.currentState!.save();
                //context.watch<RentalControllerBloc>();

                setState((){_index = StepperStep.one;});
              }
              break;
            case StepperStep.one:

              if(context.read<RentalControllerBloc>().isImmovable){
                RentalSpace space = context.read<RentalControllerBloc>().state.space;
              }else{
                RentalVehicle vehicle = context.read<RentalControllerBloc>().state.vehicle;
                //RentalVehicle vehicle = RentalVehicle.fromMap(map);
              }

              setState((){_index = StepperStep.two;});
              break;
            case StepperStep.two:
            //setState((){_index = StepperStep.one;});
              break;
          }
        },
        onStepTapped: null,
        /*(int index) {
        setState(() {
          _index = index;
        });
      },*/
        controlsBuilder: (BuildContext context, ControlsDetails controls) {
          return Container(
            constraints: const BoxConstraints(
              maxWidth: 520.0,
            ),
            child: ButtonBar(
              children: [

                ElevatedButton(
                    onPressed: controls.onStepContinue,
                    child: const Text('Suivant')),
                TextButton(
                  onPressed: controls.onStepCancel,
                  child: Text(controls.currentStep == 0 ? 'Annulé' : 'Précédant'),
                ),

              ],
            ),
          );
        },
        steps: <Step>[
          Step(
            title: const Text("Info à propos "),
            content: Container(
              alignment: Alignment.centerLeft,
              child:  SizedBox(
                  child: RentForm(
                    controllers: controllers,
                    spaceController: spaceCtrl,
                    vehicleController: vehicleCtrl,
                    validator: validator,
                    onComplete: (_){},
                    onValidForm: (_){},
                  )
              ),
            ),
          ),
          Step(
            title: const Text('Téléversé l\'image'),
            content: Container(
                alignment: Alignment.centerLeft,
                child: const SizedBox(
                  child: UploadImage(),
                )
            ),
          ),
          Step(
            title: const Text('Vérfication'),
            content: Container(
                alignment: Alignment.centerLeft,
                child: const SizedBox(
                  height: 400,
                  child: Placeholder(),
                )
            ),
          ),
        ],
      ),
    );
  }
}