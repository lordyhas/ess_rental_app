part of rent_page;

class RentForm extends StatelessWidget {

  final void Function(bool)? onValidForm;
  final void Function(RentalProduct)? onComplete;
  final GlobalKey<FormState> validator;
  final List<TextEditingController> controllers;

  const RentForm({
    required this.validator,
    required this.controllers,
    this.onValidForm,
    this.onComplete,
    super.key,
  });

  List<String> get _immovableTypeList => <String>[
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
  ];

  @override
  Widget build(BuildContext context) {
    //BlocProvider.of<RentalControllerBloc>(context).state;

    //BlocProvider.of<RentalControllerBloc>(context).addSpaceRentalPassed(SpaceRental.empty,);
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
                        .addSpaceRentalPassed(RentalSpace.empty),
                ),
                const SizedBox(width: 8.0,),
                TabBarButton(
                  title: const Text("Mobilier"),
                  isSelected: state.isMovable,
                  onTap:() => BlocProvider
                      .of<RentalControllerBloc>(context)
                      .addVehicleRentalPassed(RentalVehicle.empty),
                ),
                const SizedBox(width: 8.0,),
            ],),
          ),


          BlocBuilder<RentalControllerBloc, RentalControllerState>(
            builder: (_, state) {
              /*switch(state.isMovable){
                case true:
                  break;
                case false:
                  break;
              }*/

              return Form(
                key: validator,
                child: BooleanBuilder(
                  condition: state.isMovable,
                  /// Form : movable ###
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
                          controller: controllers[0],
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            icon: const Icon(Icons.bookmark_border),
                            hintText: 'Entrez le marque ou modele',
                            labelText: 'Mark *',
                          ),
                          onEditingComplete: (){
                            //print("onEditingComplete: Mark[${controllers[0].text}]");
                          },
                          onChanged: (str) {},
                          onSaved: (String? value) {
                            //print("onSaved: Mark[${controllers[0].text}}]");
                          },
                          validator: (v) {
                            if (v!.length < 3) return 'Mark est requis.';
                            //final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
                            /*if (!nameExp.hasMatch(v)) {
                                  return 'Please enter only alphabetical characters.';
                                }*/
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
                            icon: const Icon(Icons.bookmark_border),
                            hintText: 'Décriver votre bien à louer ?',
                            labelText: 'Description *',
                          ),
                          onEditingComplete: (){
                            //print("onEditingComplete: Description[${controllers[1].text}}]");
                          },
                          onSaved: (String? value) {
                            //print("onSaved: Description[${controllers[1].text}}]");
                          },
                          validator: (v) {
                            if (v!.isEmpty) return 'Détails est requis.';
                            return null;
                          },
                        ),
                      ),
                      _RadioButtonGroup(
                        onSelected: (Per value) {
                          //print(value);
                        },
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
                            icon: const Icon(Icons.bookmark_border),
                            hintText: 'prix par jour en dollar americain ?',
                            labelText: 'Prix/jour (en \$) *',
                          ),

                          onEditingComplete: (){
                            //print("onEditingComplete: Prix[${controllers[2].text}}]");
                          },
                          onSaved: (value) {
                            //print("onSaved: Prix[${controllers[2].text}}]");
                          },
                          validator: (v) {
                            if (v!.isEmpty) return 'Prix est requis.';
                            if(v.isNumeric) return 'Prix doit être un nombre.';
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: controllers[3],
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            icon: const Icon(Icons.bookmark_border),
                            hintText: 'Combien des portes ?',
                            labelText: 'Nombre de porte',
                          ),
                          onSaved: (String? value) {},
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
                          controller: controllers[4],
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            icon: const Icon(Icons.bookmark_border),
                            hintText: 'Combien des sieges ?',
                            labelText: 'Nombre de sieges',
                          ),
                          onSaved: (String? value) {},
                          validator: (v) {
                            //if (v!.isEmpty) return 'Nombre de siege est requis.';
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: DropdownButtonFormField<String>(
                          //controller: controllers[5],
                          items: _movableTypeList.map((String category) {
                            return DropdownMenuItem(
                                value: category,
                                child: Row(
                                  children: <Widget>[
                                    const Icon(Icons.tag, size: 20),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(category),
                                  ],
                                ));
                          }).toList(),
                          onChanged: (newValue) {
                            ///todo: do other stuff with _category doesn't work
                            //setState(() => _subcategory = newValue!);
                          },

                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            icon: const Icon(Icons.bookmark_border),
                            hintText: 'Specify your product?',
                            labelText: 'Category *',
                          ),
                          onSaved: (String? value) {
                            //setState(() => _subcategory = value!);
                          },
                          //validator: (v) {},
                        ),
                      ),
                    ],
                  ),

                  /// Form : immovable ###
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
                            icon: const Icon(Icons.bookmark_border),
                            hintText: 'Entrez un titre ou indentifiant',
                            labelText: 'Libellé *',
                          ),
                          onChanged: (str) {},
                          onSaved: (String? value) {},
                          validator: (v) {
                            if (v!.length < 3) return 'Libellé est requis.';
                            //final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
                            /*if (!nameExp.hasMatch(v)) {
                                  return 'Please enter only alphabetical characters.';
                                }*/
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
                            icon: const Icon(Icons.bookmark_border),
                            hintText: 'Décriver votre bien à louer ?',
                            labelText: 'Description *',
                          ),
                          onSaved: (String? value) {},
                          validator: (v) {
                            if (v!.isEmpty) return 'Détails est requis.';
                            return null;
                          },
                        ),
                      ),
                      _RadioButtonGroup(
                        onSelected: (Per value) {
                          //print(value);
                        },
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
                            icon: const Icon(Icons.bookmark_border),
                            hintText: 'prix par jour en dollar americain ?',
                            labelText: 'Prix/jour (en \$) *',
                          ),

                          onEditingComplete: (){},
                          onSaved: (String? value) {},
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: controllers[3],
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            icon: const Icon(Icons.bookmark_border),
                            hintText: 'Combien des chambres ?',
                            labelText: 'Nombre de chambre',
                          ),
                          onSaved: (String? value) {},
                          validator: (v) {
                            if (v!.isEmpty) return 'Nombre de chambre est requis.';
                            //^[0-9]{1,6}$
                            /*final RegExp nameExp = RegExp(r'(@"^\d$")');
                                if (!nameExp.hasMatch(v)) {
                                  return 'Please enter only number .';
                                }*/
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: DropdownButtonFormField<String>(
                          //controller: controllers[5],
                          items: _immovableTypeList.map((String category) {
                            return DropdownMenuItem(
                                value: category,
                                child: Row(
                                  children: <Widget>[
                                    const Icon(Icons.tag, size: 20),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(category),
                                  ],
                                ));
                          }).toList(),
                          onChanged: (newValue) {
                            /// todo: do other stuff with _category doesn't work
                            //setState(() => _subcategory = newValue!);
                          },


                          decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const UnderlineInputBorder(),
                            filled: true,
                            icon: const Icon(Icons.bookmark_border),
                            hintText: 'Specify your product?',
                            labelText: 'Category *',
                          ),
                          onSaved: (String? value) {
                            //setState(() => _subcategory = value!);
                          },
                          //validator: (v) {},
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


enum Per {hour, day, month}

class _RadioButtonGroup extends StatefulWidget {
  final Function(Per value) onSelected;
  const _RadioButtonGroup({required this.onSelected,});

  @override
  State<_RadioButtonGroup> createState() => _RadioButtonGroupState();
}

class _RadioButtonGroupState extends State<_RadioButtonGroup> {
  Per? _character = Per.day;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 42.0,),
        _RadioItem(
          title: const Text('par heure'),
          leading: Radio<Per>(
            value: Per.hour,
            groupValue: _character,
            onChanged: (Per? value) {
              setState(() {_character = value;});
              widget.onSelected(value ??  Per.day);
            },
          ),
        ),
        _RadioItem(
          title: const Text('par jour'),
          leading: Radio<Per>(
            value: Per.day,
            groupValue: _character,
            onChanged: (Per? value) {
              setState(() {_character = value;});
              widget.onSelected(value ??  Per.day);
            },
          ),
        ),

        _RadioItem(
          title: const Text('par mois'),
          leading: Radio<Per>(
            value: Per.month,
            groupValue: _character,
            onChanged: (Per? value) {
              setState(() {_character = value;});
              widget.onSelected(value ??  Per.day);
            },
          ),
        ),
      ],
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



