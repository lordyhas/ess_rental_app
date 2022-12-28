import 'dart:typed_data';

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

  CollectionReference<Map<String, dynamic>> get collectionProduct =>
      docG.collection('Product');

  CollectionReference<Map<String, dynamic>> get collectionOfUser =>
      docG.collection('USERS');

  CollectionReference<Map<String, dynamic>> get collectionOfReservation =>
      docG.collection('RESERVATIONS');

  CollectionReference<Map<String, dynamic>> get users => collectionOfUser;




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

  Map<String, dynamic> getData({
    required String witchDatabase,
    required String table,
    required String what,
  }) {
    Map<String, dynamic> map = {};
    colG.doc(witchDatabase)
        .collection(table)
        .doc(what)
        .get()
        .then((value) {
      if (value.exists) map = value.data()!;
    });
    return map;
  }

  List<Map<String, dynamic>?> getDataList(
      {required String witchDatabase,
        required String table,
        required int limit}) {
    List<Map<String, dynamic>?> map = [];
    colG.doc(witchDatabase)
        .collection(table)
        .limit(limit)
        .get()
        .then((value) => map = value.docs.map((e) => e.data()).toList());

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
    return users.doc(user.id).update({'photo_profile': Blob(path)});
  }

  Future<void> updateLastConnectionTime(
      {required String docId, required bool show}) async {
    if(show) {
      return users.doc(docId).update({'last_connection': DateTime.now()});
    }
    return;
  }


  Future<void> addRentalSpace({required RentalSpace productData}) {
    return collectionProduct
        .add(productData.toMap())
        .then((value) => debugPrint("Product Added : $productData"))
        .catchError((error) => debugPrint("Failed to add data: $error"));
  }

  Future<void> setRentalSpace({required RentalSpace productData}) {
    return collectionProduct
        .doc(productData.id)
        .set(productData.toMap())
        .then((value) => debugPrint("Product Added : $productData"))
        .catchError((error) => debugPrint("Failed to add data: $error"));
  }

  Future<User> getUserInCloud() async {
    var doc = (await users.doc(user.id).get());
    if(!doc.exists) return User.empty;
    Map<String, dynamic> data = doc.data()!;
    return User.fromMap(data);
  }

  Future<List<RentalSpace>> getAllRentalSpace() async {
    var productQuery = await collectionProduct.get();
    List<RentalSpace> list = productQuery.docs.map(
            (e) => RentalSpace.fromMap(e.data())).toList();

    return list;
  }


}
