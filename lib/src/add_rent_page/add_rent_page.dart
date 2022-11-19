library rent_page;

import 'dart:async';
import 'dart:io';


import 'package:exploress_location/logic/model/data_model.dart';
import 'package:exploress_location/logic/values.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:utils_component/utils_component.dart' hide Go;

part 'rent_verification.dart';
part 'rent_upload_image.dart';
part 'rent_form.dart';


enum StepperStep{zero,one,two}

class RentPage extends StatelessWidget {
  static const routeName = "/home/rent?id=sfr";
  const RentPage({Key? key}) : super(key: key);

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
  late final Map<String,TextEditingController> ctrl;

  @override
  void initState() {
    super.initState();
    _index = StepperStep.zero;
    controllers = List<TextEditingController>.generate(10,
            (index) => TextEditingController());
    ctrl = {
      'id': TextEditingController(),
      'label': TextEditingController(),
      'room': TextEditingController(),
      'address': TextEditingController(),
      'coordinates': TextEditingController(),
      'spaceType': TextEditingController(),
      'description': TextEditingController(),
      'owner': TextEditingController(),
      'imageUrl': TextEditingController(),
    };


  }


  @override
  Widget build(BuildContext context) {
    return Stepper(
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
              setState((){_index = StepperStep.one;});
            }
            break;
          case StepperStep.one:
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
                  child: const Text('Next')),
              TextButton(
                onPressed: controls.onStepCancel,
                child: Text(controls.currentStep==0?'Cancel':'Previous'),
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
    );
  }


}