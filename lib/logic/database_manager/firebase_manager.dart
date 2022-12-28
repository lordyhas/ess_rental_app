import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploress_location/logic/controller/authentication_bloc/auth_repository/setup.dart';
import 'package:exploress_location/logic/model/data_model.dart';
import 'package:flutter/foundation.dart';

class FirebaseManager {
  final User user;

  FirebaseManager._({this.user = User.empty});

  FirebaseManager.user(User user) : this._(user: user);

  FirebaseManager.none() : this._();

  DocumentReference<Map<String, dynamic>> access =
      FirebaseFirestore.instance.collection('exploress_test').doc('config_data');

  CollectionReference<Map<String, dynamic>> colG =
      FirebaseFirestore.instance.collection('exploress_test');
  DocumentReference<Map<String, dynamic>> get docG => colG.doc('general_data');

  CollectionReference<Map<String, dynamic>> get collectProduct =>
      docG.collection('Product');

  CollectionReference<Map<String, dynamic>> get collectUser =>
      docG.collection('USERS');

  CollectionReference<Map<String, dynamic>> get collectReserve =>
      docG.collection('RESERVATIONS');

  CollectionReference<Map<String, dynamic>> get users => collectUser;


  Map<String, dynamic> getDataFirestore({
    required String generalDoc,
    required String collection,
    required String doc,
  }) {
    Map<String, dynamic> map = {};
    colG.doc()
        .collection(collection)
        .doc(doc)
        .get()
        .then((value) {
      if (value.exists) map = value.data()!;
    });
    return map;
  }

  Future<void> addUserInCloud({required User user}) async {
    return users.doc(user.id).get().then((DocumentSnapshot documentSnapshot) {
      if (!documentSnapshot.exists) {
        return users
            .doc(user.id)
            .set(user.copyWith(isDataCloud: true).toMap())
            .then((value) => debugPrint("Write Report => User Added : $user ### ###"))
            .catchError((error) => debugPrint("Failed to add user in cloud: $error"));
      }
    });
  }

  Future<User> getUserInCloud() async {
    var doc = (await users.doc(user.id).get());
    if(!doc.exists) return User.empty;
    Map<String, dynamic> data = doc.data()!;
    return User.fromMap(data);
  }


  /// Update data with map by {key : value}
  Future<void> updateUserInformation(
      {
        required String key,
        required String value}) async {
    return users.doc(user.id).update({key: value});
  }

  /// Update the all user information that has changed
  Future<void> updateUser({required User user}) async {
    return users.doc(user.id).update(user.toMap());
  }

  /// Update image user that used as profile image
  Future<void> updateImageProfile(Uint8List path) async {
    return users.doc(user.id).update(user.copyWith(photoCloud: Blob(path)).toMap());
  }

  Future<void> updateLastConnectionTime({required bool show}) async {
    if(show) {
      return users.doc(user.id).update(
          user.copyWith(lastConnection: DateTime.now()).toMap());
    }
    return;
  }


  Future<void> addRentalSpace({required RentalSpace productData}) {
    return collectProduct
        .add(productData.toMap())
        .then((value) => debugPrint("Product Added : $productData"))
        .catchError((error) => debugPrint("Failed to add data: $error"));
  }

  Future<void> setRentalSpace({required RentalSpace productData}) {
    return collectProduct
        .doc(productData.id)
        .set(productData.toMap())
        .then((value) => debugPrint("Product Added : $productData"))
        .catchError((error) => debugPrint("Failed to add data: $error"));
  }


  Future<List<RentalSpace>> getAllRentalSpace() async {
    var productQuery = await collectProduct.get();
    List<RentalSpace> list = productQuery.docs
        .map((e) => RentalSpace.fromMap(e.data()))
        .toList();
    return list;
  }

  Future<List<RentalSpace>> getRentalSpaceListFromUser({
    required User user
  }) async {
    var productQuery = await collectProduct
        .where('owner', isEqualTo: user.id)
        .get();
    List<RentalSpace> list =
    productQuery.docs.map((e) => RentalSpace.fromMap(e.data())).toList();

    return list;
  }


  Future<void> addRentalVehicle({required RentalVehicle productData}) {
    return collectProduct
        .add(productData.toMap())
        .then((value) => debugPrint("Product Added : $productData"))
        .catchError((error) => debugPrint("Failed to add data: $error"));
  }

  Future<void> setRentalVehicle({required RentalVehicle productData}) {
    return collectProduct
        .doc(productData.id)
        .set(productData.toMap())
        .then((value) => debugPrint("Product Added : $productData"))
        .catchError((error) => debugPrint("Failed to add data: $error"));
  }


  Future<List<RentalVehicle>> getAllRentalVehicle() async {
    var productQuery = await collectProduct.get();
    List<RentalVehicle> list = productQuery.docs
        .map((e) => RentalVehicle.fromMap(e.data()))
        .toList();
    return list;
  }

  Future<List<RentalVehicle>> getRentalVehicleListFromUser({
    required User user
  }) async {
    var productQuery = await collectProduct
        .where('owner', isEqualTo: user.id)
        .get();
    List<RentalVehicle> list =
    productQuery.docs.map((e) => RentalVehicle.fromMap(e.data())).toList();

    return list;
  }

  /// Call as stream of a [StreamBuilder] Widget
  Stream get collectionStream => colG.snapshots();


}
