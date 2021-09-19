import 'package:barber_application/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum Status{
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Register
}

//note:
//FirebaseUser => User
//AuthResult => UserCredential
//GoogleAuthProvider.getCredential() => GoogleAuthProvider.credential()

class AuthService extends ChangeNotifier{
  //Firebase Auth object
  late FirebaseAuth _auth;

  String? userIdToken;
  //Default status
  Status _status = Status.Uninitialized;

  Status get status => _status;

  Stream<UserModel> get user => _auth.authStateChanges().map(_userFromFirebase);

  AuthService(){
    //initialise object
    _auth = FirebaseAuth.instance;

    //Listener for authentication changes such as sign in and sign out
    _auth.authStateChanges().listen(onAuthStateChanged);
  }
  //Create user object based on the given User
  UserModel _userFromFirebase(User? user){
    if (user == null){
      return UserModel(displayName: 'null', uid: 'null');
    }
    return UserModel(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoURL
    );
  }
  //method to detect live auth changes such as user sign in and sign out
  Future<void> onAuthStateChanged(User? firebaseUser)async{
    if(firebaseUser == null){
      _status = Status.Unauthenticated;
    } else{
      _userFromFirebase(firebaseUser);
      _status = Status.Authenticated;
      userIdToken = firebaseUser.uid;
    }
    notifyListeners();
  }

  //method for new registration using email and password
  Future<UserModel> registerWithEmailAndPassword(String email, String password) async{
    try{
      _status = Status.Register;
      notifyListeners();
      final UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(result.user);

    } catch(e){
      print("Error on the new user registration :"+ e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return UserModel(displayName: 'null', uid: 'null');
    }
  }

  Future<void> loginToDatabase (String email, String password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );


    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        print('No user found for that email.');
      }else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  //Method to handle user sing in using email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      final UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch(e){
      print("Error on the sign in :"+ e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  //Method to handle password reset email
  Future<void> sendPasswordResetEmail(String email)async{
    await _auth.sendPasswordResetEmail(email: email);
  }

  //Method handler user signing out
  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}