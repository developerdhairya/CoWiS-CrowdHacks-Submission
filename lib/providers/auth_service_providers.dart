import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
}

class AuthServiceProvider extends ChangeNotifier {
  late FirebaseAuth _auth;
  late GoogleSignIn _googleSignIn;

  static AuthServiceProvider instance = AuthServiceProvider();

  AuthStatus _authStatus = AuthStatus.NotAuthenticated;
  String ? _profileImage="";
  String ? _userName="";
  String ? _userID="";
  String  _userEmailID="";
  bool _newUser=false;

  AuthServiceProvider() {
    _auth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn();
    _auth.authStateChanges().listen((event) {
      if (event==null) {
        _authStatus = AuthStatus.NotAuthenticated;
        notifyListeners();
      } else{
        _authStatus=AuthStatus.Authenticated;
        _userID=event.uid;
        _userName=event.displayName;
        _profileImage=event.photoURL;
        _userEmailID=event.email!;
        notifyListeners();
      }
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      _authStatus = AuthStatus.Authenticating;
      notifyListeners();
      UserCredential userCredential=await _auth.signInWithCredential(credential);
      if(userCredential.additionalUserInfo!.isNewUser){
        _newUser=true;
      }
      else{
        _newUser=false;
      }
      _authStatus = AuthStatus.Authenticated;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _authStatus=AuthStatus.NotAuthenticated;
    }
  }

  void signOut() {
    _auth.signOut();
    _authStatus = AuthStatus.NotAuthenticated;
    notifyListeners();
  }

  //getters

  get authStatus {
    return _authStatus;
  }

  get profileImage{
    return _profileImage;
  }

  get userName{
    return _userName;
  }

  get userId{
    return _userID;
  }

  get isNewUser{
    return _newUser;
  }

  get userEmailID{
    return _userEmailID;
  }


}

//            _authServiceProvider=Provider.of<AuthServiceProvider>(_context);