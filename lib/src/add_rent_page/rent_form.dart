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

    return Container(
      constraints: const BoxConstraints(maxWidth: 520),
      child: Column(
        children: [
          //const SizedBox(height: 72.0,),
          //const SizedBox(height: 16.0,),
          const SizedBox(
            height: 8.0,
          ),

          /// Entry's information product
          Form(
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
                      hintText: 'libellé',
                      labelText: 'libellé *',
                    ),
                    onChanged: (str) {},
                    onSaved: (String? value) {},
                    validator: (v) {
                      if (v!.length < 3) return 'Name is required.';
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
          Column(
            children: const [],
          ),
        ],
      ),
    );
  }
}

