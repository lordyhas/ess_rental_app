import 'package:exploress_location/logic/controller/authentication_bloc/auth_repository/setup.dart';

class FirebaseManager{
  final User user;
  const FirebaseManager._({this.user = User.empty});
  const FirebaseManager.user(User user) : this._(user:user);
  const FirebaseManager.none() : this._();




}