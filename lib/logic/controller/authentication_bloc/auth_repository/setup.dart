import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:async';



import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;

//import 'package:firebase_auth/firebase_auth.dart' as firebase_fb_auth;
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuthException;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';



part 'user.dart';
part 'repository.dart';


/*
class _AuthenticationBlocOld
    extends Bloc<AuthenticationEvent, AuthenticationState> {

  _AuthenticationBlocOld({
    required AuthenticationRepository authenticationRepository,
  })  :_authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    /*_userSubscription = _authenticationRepository.userAuth.listen(
          (user) => add(AuthenticationUserChanged(user)),
    );*/
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<User>? _userSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {


    if (event is AuthenticationUserChanged) {
      yield _mapAuthenticationUserChangedToState(event);
    }
    else if (event is AuthenticationUserUpdated) {
      yield _mapAuthenticationUserUpdateToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      unawaited(_authenticationRepository.logOut());
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  updateUser(User user){
    this.add(AuthenticationUserChanged(user));
  }

  AuthenticationState _mapAuthenticationUserChangedToState(
      AuthenticationUserChanged event,
      ) {
    return event.user != User.empty
        ? AuthenticationState.authenticated(event.user)
        : const AuthenticationState.unauthenticated();
  }

  AuthenticationState _mapAuthenticationUserUpdateToState(
      AuthenticationUserUpdated event,
      ) {
    return AuthenticationState.updated(event.user);
  }
}

*/
