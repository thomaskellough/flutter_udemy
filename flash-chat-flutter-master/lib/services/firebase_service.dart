import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseService {
  final FirebaseFirestore _firesStoreInstance = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String fireStoreMessagesCollectionPath = 'FCMessages';

  Future<UserCredential> createUserWithEmailAndPassword(
      {@required email, @required password}) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return newUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserCredential> signInWithEmailAndPassword({@required email, @required password}) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return user;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  void signOut() {
    _auth.signOut();
  }

  User getUser()  {
    try {
      return _auth.currentUser;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  FirebaseFirestore getFireStoreInstance() {
    return _firesStoreInstance;
  }
}
