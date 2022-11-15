part of rent_page;

enum StepperStep{zero,one,two}

class RentScreen extends StatefulWidget {
  const RentScreen({Key? key}) : super(key: key);

  @override
  State<RentScreen> createState() => _RentScreenState();
}

class _RentScreenState extends State<RentScreen> {
  late StepperStep _index;
  @override
  void initState() {
    _index = StepperStep.zero;
    super.initState();
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
      onStepContinue: () {},
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
          title: const Text("Téléversé l'image"),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const UploadImage(),
          ),
        ),
        Step(
          title: const Text('Info à propos'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const SizedBox(
                height: 400,
                child: Placeholder(),
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
