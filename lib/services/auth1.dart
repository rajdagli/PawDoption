import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_proj/models/user.dart';
import 'package:cloud_proj/services/database.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FBuser
  MyUser? _userFormFirebaseUser(User? user){
    return user != null? MyUser(uid: user.uid):null;
  }

  // auth change user stream
  Stream<MyUser?> get user{
    return _auth.authStateChanges()
        .map(_userFormFirebaseUser);
        //.map((User? user)=>_userFormFirebaseUser(user));
  }

  //sign in anon
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFormFirebaseUser(user);
    } catch (e){
      print(e.toString());
      return null;
    }
  }
  // sign in email and pass
  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      return _userFormFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // register in email and pass
  Future registerWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user=result.user;

      //Create a new doc for each user
      await DatabaseService(uid: user!.uid).updateUserData('New Pet Name', 0,'Mumbai','New Pet Desc');
      return _userFormFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}