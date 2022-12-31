

part of 'setup.dart';


/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {}

class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}


/// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the login process if a failure occurs.
class LogInAnonymouslyFailure implements Exception {}

class LogInWithFacebookFailure implements Exception {}

/// Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {
  /// {@macro log_in_with_google_failure}
  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}




/// {@template cache_client}
/// An in-memory cache client.
/// {@endtemplate}
class CacheClient {
  /// {@macro cache_client}
  CacheClient() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  /// Writes the provide [key], [value] pair to the in-memory cache.
  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

  /// Looks up the value for the provided [key].
  /// Defaults to `null` if no value exists for the provided key.
  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}

/// {@template authentication_repository}
/// Repository which manages user authentication_bloc.
/// {@endtemplate}
///
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  /// Whether or not the current environment is web
  /// Should only be overriden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;
      if (isWeb) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        //_firebaseAuth.signInWithProvider(provider)
        final userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      print("xxx xxx _firebaseAuth.signInWithCredential(credential) : Error($e) ");
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      print("xxx xxx _firebaseAuth.signInWithCredential(credential) : LogInWithGoogleFailure($_) ");
      throw const LogInWithGoogleFailure();

    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      print("xxx xxx _firebaseAuth.signInWithEmailAndPassword(...) : Error($e) ");
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      print("xxx xxx _firebaseAuth.signInWithEmailAndPassword(...) : LogInWithGoogleFailure($_) ");
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}
/*
class _AuthenticationRepository {
  /// {@macro authentication_repository}
  _AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  //FirebaseManager firebaseManager_ = new FirebaseManager();
  //User _user =   firebase_auth.FirebaseAuth.instance.currentUser;

  /*if(!_user.emailVerified){
        var actionCodeSettings = ActionCodeSettings(
            url: 'https://www.example.com/?email=${_user.email}',
            dynamicLinkDomain: "example.page.link",
            /*android: {
              "packageName": "com.example.android",
              "installApp": true,
              "minimumVersion": "12"
            },*/
            androidPackageName: "com.lordyhas.exploress",
            androidMinimumVersion: "16",
            androidInstallApp: true,
            //iOS: {"bundleId": "com.example.ios"},
            handleCodeInApp: true);

        await _user.sendEmailVerification(actionCodeSettings);
      }   */


  /// Stream of [User] which will emit the current user when
  /// the authentication_bloc state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get userAuth {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if(firebaseUser != null){



        /*if(!firebaseUser.emailVerified){
          var actionCodeSettings = firebase_auth.ActionCodeSettings(
              url: 'https://exploress-aa508.firebaseapp.com/?email=${firebaseUser.email}',
              dynamicLinkDomain: "exploress-aa508.firebaseapp.page.link",
              androidPackageName: "com.lordyhas.exploress",
              androidMinimumVersion: "16",
              androidInstallApp: true,
              //iOS: {"bundleId": "com.example.ios"},
              handleCodeInApp: true);

          firebaseUser.sendEmailVerification();

        }*/


        return firebaseUser.toUser;
      }


      return User.empty;
    });
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    //assert(email != null && password != null);

    try {

      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );


    } on Exception {
      print("Exception : Sign Up With Mail failed => $Exception ");
      throw SignUpFailure();
    }
    /*on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }*/
  }

  /// Starts the Sign In Anonymously .
  ///
  /// Throws a [LogInAnonymouslyFailure] if an exception occurs.
  Future<void> logInAnonymously() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } on Exception {
      print("Exception : Login Anonymously failed => $Exception [repository.dart:L142~~]");
      throw LogInAnonymouslyFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {

    try {
      //print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 1');
      final googleUser = await _googleSignIn.signIn();

      //print('xxx signIn : GoogleSignIn(${googleUser.toString()});');
      //print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 2');
      final googleAuth = await googleUser?.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      //print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 3');

      //print('xxx credential : OAuthCredential(${credential.asMap()});');

      await _firebaseAuth.signInWithCredential(credential);
    }
    catch (error) {
      print(error);
      print("Exception : Login With Google failed => "
          "$error [repository.dart:L167~~]");
    }

    /*on firebase_auth.FirebaseAuthException {
      print("FirebaseAuthException : Login With Google failed => ${
          firebase_auth.FirebaseAuthException
      } [repository.dart:L162~~]");
      throw LogInWithGoogleFailure();
    } on Exception {
      print("Exception : Login With Google failed => "
          "$Exception [repository.dart:L167~~]");
    }*/
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    //assert(email != null && password != null);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      print("Exception : Login Email and Password failed => $Exception [repository.dart:L181~~]");
      //print();
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  /// Starts the Sign In with Facebook .
  ///
  /// Throws a [LogInWithFacebookFailure] if an exception occurs.
  Future<void> logInWithFacebook() async {
    try {
      //await _firebaseAuth.signInAnonymously();
      /*final result = await FacebookAuth.instance.login() ;

      // Create a credential from the access token
      final firebase_auth.OAuthCredential facebookAuthCredential =
      firebase_auth.FacebookAuthProvider.credential(result!.token!);
      await _firebaseAuth.signInWithCredential(facebookAuthCredential);*/

    } on Exception {
      throw LogInWithFacebookFailure();
    }
  }

  /*Future<void> __signInWithFacebook() async {
    // Trigger the sign-in flow
    /*final LoginResult result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(result.accessToken.token);*/

    // Once signed in, return the UserCredential
    //return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }*/

  /// Signs out the current user which will emit
  /// [User.empty] from the [userAuth] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}
*/
extension on firebase_auth.User {
  //bool get emailNotVerified => !emailVerified;

  User get toUser {

    return User(
        id: uid, email: email,
        name: displayName, photoMail: photoURL,
        phoneNumber: phoneNumber,
        lastDate: metadata.lastSignInTime,
        creationDate: metadata.creationTime,
        isAnonymous: isAnonymous,
        isCheckMail: emailVerified,

    );
  }
}
