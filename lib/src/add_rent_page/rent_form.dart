part of rent_page;

class RentForm extends StatelessWidget {

  final void Function(bool)? onValidForm;
  final void Function(StuffRental)? onComplete;
  final GlobalKey<FormState> validator;
  final List<TextEditingController> controllers;

  const RentForm({
    required this.validator,
    required this.controllers,
    this.onValidForm,
    this.onComplete,
    super.key,
  });

  List<String> get subcategories => <String>[
    'Vehicule',
    'Appartement',
    'Bureau',
    'Entrepot',
    'Salle',
  ];



  @override
  Widget build(BuildContext context) {
    //BlocProvider.of<RentalControllerBloc>(context).state;

    BlocProvider.of<RentalControllerBloc>(context).addSpaceRentalPassed(SpaceRental.empty);
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
            builder: (context, state) => ButtonBar(
              children: [
                TabBarButton(
                  title: const Text("Immobilier"),
                  isSelected: state.isImmovable,
                  onTap:(){},
                ),

                TabBarButton(
                  title: const Text("Mobilier"),
                  isSelected: state.isMovable,
                  onTap:(){},
                ),
            ],),
          ),


          BlocBuilder<RentalControllerBloc, RentalControllerState>(
            builder: (_, state) => Form(
              key: validator,
              child: Column(
                children: [
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
                        if (v!.length < 3) return 'Libellé is required.';
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
                        hintText: 'Decriver votre bien à louer ?',
                        labelText: 'Description *',
                      ),
                      onSaved: (String? value) {},
                      validator: (v) {
                        if (v!.isEmpty) return 'Details is required.';
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
                        icon: const Icon(Icons.bookmark_border),
                        hintText: 'prix ?',
                        labelText: 'Prix en \$',
                      ),

                      onEditingComplete: (){},
                      onSaved: (String? value) {},
                      validator: (v) {
                        if (v!.isEmpty) return 'Price is required.';
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
                        hintText: 'How many ?',
                        labelText: 'Nombre de chambre',
                      ),
                      onSaved: (String? value) {},
                      validator: (v) {
                        if (v!.isEmpty) return 'Price is required.';
                        //^[0-9]{1,6}$
                        /*final RegExp nameExp = RegExp(r'(@"^\d$")');
                              if (!nameExp.hasMatch(v)) {
                                return 'Please enter only number .';
                              }*/
                        return null;
                      },
                    ),
                  ),
                  /*Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                          child: TextFormField(
                            controller: controllers[4],
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                              icon: Icon(Icons.bookmark_border),
                              hintText: 'What do people call you?',
                              labelText: 'Name *',
                            ),
                            onSaved: (String? value) {},
                            validator: (v) {
                              if (v!.isEmpty) return 'Name is required.';
                              final RegExp nameExp = RegExp(r'(^\d*\.?\d*)');
                              if (!nameExp.hasMatch(v)) {
                                return 'Please enter only alphabetical characters.';
                              }
                              return null;
                            },
                          ),
                        ),*/
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: DropdownButtonFormField<String>(
                      //controller: controllers[5],
                      items: subcategories.map((String category) {
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

  final Function onTap;
  final bool isSelected;
  final Text title;

  @override
  Widget build(BuildContext context) {
    String txt = title.data!;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected
                ? null
                :  Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: Theme.of(context).primaryColor)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () => onTap,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? null
                        : Theme.of(context).primaryColor,
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

