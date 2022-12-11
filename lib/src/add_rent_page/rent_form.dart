part of rent_page;

class RentForm extends StatelessWidget {

  final void Function(bool)? onValidForm;
  final void Function(RentalProduct)? onComplete;
  final GlobalKey<FormState> validator;
  final List<TextEditingController> controllers;

  final Map<String,TextEditingController> spaceController;
  final Map<String,TextEditingController> vehicleController;

  const RentForm({
    required this.validator,
    required this.controllers,
    required this.spaceController,
    required this.vehicleController,
    this.onValidForm,
    this.onComplete,
    super.key,
  });

  /*List<String> get _immovableTypeList => <String>[
    'Appartement',
    'Bureau',
    'Entrepot',
    'Salle',
  ];

  List<String> get _movableTypeList => <String>[
    'Categories A',
    'Categories B',
    'Categories C',
    'Categories D',
  ];* /

  Map<String, RentalSpaceType> get __immovableTypeList => {
    'Appartement': RentalSpaceType.apartment,
    'Bureau' : RentalSpaceType.bureau,
    'Entrépot' : RentalSpaceType.reception,
    'Salle' : RentalSpaceType.hall,
  };

  Map<String, RentalVehicleType> get __movableTypeList => {
    'Categories A': RentalVehicleType.A,
    'Categories B': RentalVehicleType.B,
    'Categories C': RentalVehicleType.C,
    'Categories D': RentalVehicleType.D,
  };*/

  @override
  Widget build(BuildContext context) {
    RentalSpace space = context.read<RentalControllerBloc>().state.space;
    RentalVehicle vehicle = context.read<RentalControllerBloc>().state.vehicle;


    return Container(
      constraints: const BoxConstraints(maxWidth: 520),
      child: Column(
        children: [
          //const SizedBox(height: 72.0,),
          //const SizedBox(height: 16.0,),
          const SizedBox(
            height: 8.0,
          ),

          BlocBuilder<RentalControllerBloc, RentalControllerState>(
            builder: (context, state) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Spacer(),
                TabBarButton(
                  title: const Text("Immobilier"),
                  isSelected: state.isImmovable,
                  onTap:() => BlocProvider
                        .of<RentalControllerBloc>(context)
                        .addSpaceRentalPassed(context.read<RentalControllerBloc>().state.space),
                ),
                const SizedBox(width: 8.0,),
                TabBarButton(
                  title: const Text("Mobilier"),
                  isSelected: state.isMovable,
                  onTap:() => BlocProvider
                      .of<RentalControllerBloc>(context)
                      .addVehicleRentalPassed(context.read<RentalControllerBloc>().state.vehicle),
                ),
                const SizedBox(width: 8.0,),
            ],),
          ),


          BlocBuilder<RentalControllerBloc, RentalControllerState>(
            builder: (_, state) {
              return Form(
                key: validator,
                child: BooleanBuilder(
                  condition: () => state.isMovable,
                  /// Form : movable => vehicle ###
                  ifTrue: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: Text("Enregistrer un bien mobilier",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          cursorColor: Theme.of(context).primaryColor,
                          controller: vehicleController['mark'],
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            //icon: const Icon(Icons.bookmark_border),
                            hintText: 'Entrez le marque ou modele',
                            labelText: 'Mark *',
                          ),
                          onEditingComplete: (){
                            //print("onEditingComplete: Mark[${controllers[0].text}]");
                          },
                          onChanged: (str) {},
                          onSaved: (String? value) {
                            vehicle = vehicle.copyWith(mark: value);
                          },
                          validator: (v) {
                            if (v!.length < 3) return 'Mark est requis.';
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: vehicleController['description'],
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: 3,
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            //icon: const Icon(Icons.bookmark_border),
                            hintText: 'Décriver votre bien à louer ?',
                            labelText: 'Description *',
                          ),
                          onEditingComplete: (){
                            //print("onEditingComplete: Description[${controllers[1].text}}]");
                          },
                          onSaved: (String? value) {
                            vehicle = vehicle.copyWith(description: value);
                          },
                          validator: (v) {
                            if (v!.isEmpty) return 'Détails est requis.';
                            return null;
                          },
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: vehicleController['price'],
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            //icon: const Icon(Icons.bookmark_border),
                            hintText: 'prix ${_RadioButtonGroup.labels[state.vehicle.pricePer.index]} en dollar américain ?',
                            labelText: 'Prix/${_RadioButtonGroup.labels[state.vehicle.pricePer.index]} (en \$) *',
                          ),
                          onEditingComplete: (){},
                          onSaved: (value) {
                            int v = value!.toInt().abs();
                            if(v == 0) v = 1;
                            vehicle = vehicle.copyWith(price: v);
                          },
                          validator: (v) {
                            if (v!.isEmpty) return 'Prix est requis.';
                            if(v.isNumeric) return 'Prix doit être un nombre.';
                            return null;
                          },
                        ),
                      ),
                      _RadioButtonGroup(
                        onSelected: (PricePer value) {
                          vehicle = vehicle.copyWith(pricePer: value);
                          context.read<RentalControllerBloc>().addVehicleRentalPassed(vehicle);
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: vehicleController['door'],
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            //icon: const Icon(Icons.bookmark_border),
                            hintText: 'Combien des portes ?',
                            labelText: 'Nombre de porte',
                          ),
                          onSaved: (String? value) {
                            int v = value!.toInt().abs();
                            if(v == 0) v = 1;
                            vehicle = vehicle.copyWith(door: v);
                          },
                          validator: (v) {
                            if (v!.isEmpty) return 'Nombre de porte est requis.';
                            //^[0-9]{1,6}$
                            final RegExp nameExp = RegExp(r'(^\d*\.?\d*)');
                            if (!nameExp.hasMatch(v)) {
                              return 'Please enter only number .';
                            }
                            return null;
                          },
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: vehicleController['seat'],
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            //icon: const Icon(Icons.bookmark_border),
                            hintText: 'Combien des sieges ?',
                            labelText: 'Nombre de sieges',
                          ),
                          onSaved: (String? value) {
                            int v = value!.toInt().abs();
                            if(v == 0) v = 1;
                            vehicle = vehicle.copyWith(seat: v);
                          },
                          validator: (v) {
                            // if (v!.isEmpty) return
                            // 'Nombre de siege est requis.';
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: DropdownButtonFormField<RentalVehicleType>(
                          //controller: controllers[5],
                          items: RentalVehicle.vehicleTypeString.map((v, k) {
                            return MapEntry(DropdownMenuItem(
                                value: v,
                                child: Row(
                                  children: <Widget>[
                                    const Icon(Icons.tag, size: 20),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Text("Catégorie $k"),
                                  ],
                                )),0);
                          }).keys.toList(),
                          onChanged: (v){},
                          onSaved: (value) {
                            vehicle = vehicle.copyWith(vehicleType: value);
                            context.read<RentalControllerBloc>().addVehicleRentalPassed(vehicle);
                          },
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            //icon: const Icon(Icons.bookmark_border),
                            hintText: 'Spécifier la catégorie?',
                            labelText: 'Catégorie *',
                          ),
                          validator: (v) {
                            if(v == null) return "Chosir une catégorie";
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  /// Form : immovable => space ################################
                  ifFalse: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: Text("Enregistrer un bien immobilier",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          cursorColor: Theme.of(context).primaryColor,
                          controller: controllers[0],
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            //icon: const Icon(Icons.bookmark_border),
                            hintText: 'Entrez un titre ou indentifiant',
                            labelText: 'Libellé *',
                          ),
                          onChanged: (str) {},
                          onSaved: (String? value) {
                            space = space.copyWith(label: value);
                            //context.read<RentalControllerBloc>().addSpaceRentalPassed(space);
                          },
                          validator: (v) {
                            if(v!.isEmpty) return 'Libellé est requis.';
                            if(v.length < 3)return'Un libellé long est requis.';
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: controllers[1],
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: 3,
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            //icon: const Icon(Icons.bookmark_border),
                            hintText: 'Décriver votre bien à louer ?',
                            labelText: 'Description *',
                          ),
                          onSaved: (String? value) {
                            space = space.copyWith(description: value);
                            //context.read<RentalControllerBloc>().addSpaceRentalPassed(space);
                          },
                          validator: (v) {
                            if (v!.isEmpty) return 'Détails est requis.';
                            return null;
                          },
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: controllers[2],
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                           // icon: const Icon(Icons.bookmark_border),
                            hintText: 'prix ${_RadioButtonGroup.labels[state.space.pricePer.index]} en dollar americain ?',
                            labelText: 'Prix/${_RadioButtonGroup.labels[state.space.pricePer.index]} (en \$) *',
                          ),

                          onEditingComplete: (){},
                          onSaved: (String? value) {
                            int v = value!.toInt().abs();
                            if(v == 0) v = 1;
                            space = space.copyWith(price: v);
                            //context.read<RentalControllerBloc>().addSpaceRentalPassed(space);
                          },
                          validator: (v) {
                            if (v!.isEmpty) return 'Prix est requis.';
                            final RegExp priceExp = RegExp(r'(^\d*\.?\d*)');
                            if (!priceExp.hasMatch(v)) {
                              return 'Please enter only number .';
                            }
                            return null;
                          },
                        ),
                      ),

                      _RadioButtonGroup(
                        onSelected: (PricePer value) {
                          space = space.copyWith(pricePer: value);
                          context.read<RentalControllerBloc>().addSpaceRentalPassed(space);
                        },
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 8.0
                        ),
                        child: TextFormField(
                          controller: controllers[3],
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            //icon: const Icon(Icons.bookmark_border),
                            hintText: 'Combien des pièces ?',
                            labelText: 'Nombre des pièces',
                          ),
                          onSaved: (String? value) {
                            int v = value!.toInt().abs();
                            if(v == 0) v = 1;
                            space = space.copyWith(room: v);
                          },
                          validator: (v) {
                            if (v!.isEmpty) return 'Nombre de pièce est requis.';
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: DropdownButtonFormField<RentalSpaceType>(
                          //controller: controllers[5],
                          items: RentalSpace.spaceTypeString.map((v, k) {
                            return MapEntry(DropdownMenuItem(
                                value: v,
                                child: Row(
                                  children: <Widget>[
                                    const Icon(Icons.tag, size: 20),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(k),
                                  ],
                                )),0);
                          }).keys.toList(),
                          onChanged: (newValue) {},
                          onSaved: (RentalSpaceType? value) {
                            space = space.copyWith(spaceType: value);
                            context.read<RentalControllerBloc>().addSpaceRentalPassed(space);
                          },

                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            //icon: const Icon(Icons.bookmark_border),
                            hintText: 'Spécifier la catégorie?',
                            labelText: 'Catégorie *',
                          ),

                          validator: (v) {
                            if(v == null) return "Chosir une catégorie";
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),

          /// Entry's information product

          Column(
            children: const [],
          ),
        ],
      ),
    );
  }
}

class TabBarButton extends StatelessWidget {
  const TabBarButton({
    required this.title,
    required this.onTap,
    required this.isSelected,
    Key? key,
  }) :  super(key: key);

  final Function() onTap;
  final bool isSelected;
  final Text title;

  @override
  Widget build(BuildContext context) {
    String txt = title.data!;
    TextStyle? style = title.style;
    Color color =  Theme.of(context).primaryColorLight;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: !isSelected ? null : color.withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: color)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white30,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: style ?? const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    //letterSpacing: 0.27,
                    //color: isSelected ? null : color,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




class _RadioButtonGroup extends StatefulWidget {
  final Function(PricePer value) onSelected;
  const _RadioButtonGroup({required this.onSelected,});

  static const List<String> labels = ['par heure', 'par jour', 'par mois'];

  @override
  State<_RadioButtonGroup> createState() => _RadioButtonGroupState();
}

class _RadioButtonGroupState extends State<_RadioButtonGroup> {
  PricePer? _character = PricePer.day;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 42.0),
      child: Wrap(
        children: <Widget>[
          //const SizedBox(width: 42.0,),
          _RadioItem(
            title: Text(_RadioButtonGroup.labels[0]),
            leading: Radio<PricePer>(
              value: PricePer.hour,
              groupValue: _character,
              onChanged: (PricePer? value) {
                setState(() {_character = value;});
                widget.onSelected(value ??  PricePer.day);
              },
            ),
          ),
          _RadioItem(
            title: Text(_RadioButtonGroup.labels[1]),
            leading: Radio<PricePer>(
              value: PricePer.day,
              groupValue: _character,
              onChanged: (PricePer? value) {
                setState(() {_character = value;});
                widget.onSelected(value ??  PricePer.day);
              },
            ),
          ),

          _RadioItem(
            title: Text(_RadioButtonGroup.labels[2]),
            leading: Radio<PricePer>(
              value: PricePer.month,
              groupValue: _character,
              onChanged: (PricePer? value) {
                setState(() {_character = value;});
                widget.onSelected(value ??  PricePer.day);
              },
            ),
          ),
        ],
      ),
    );
  }
}


class _RadioItem extends StatelessWidget {
  final Widget leading;
  final Widget title;
  const _RadioItem({required this.leading, required this.title, Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        children: [
          leading,
          title,
        ],
      ),
    );
  }
}



