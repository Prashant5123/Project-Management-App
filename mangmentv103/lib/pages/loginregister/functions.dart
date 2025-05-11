import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //sign in
  signInWithEmailPassword(String email, password) async {
    try {
      //sign user in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User signed in: ${userCredential.user!.uid}");

      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign up
  signUpWithEmailPassword(
    String emailAddress,
    String password,
    String name,
    int jobno,
    String empid,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );

      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'name': name,
        'empId': empid,
        'email': emailAddress,
        'createdAt': Timestamp.now(),
      });
      print("User registerd successful !");
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        print("The account already exists for that email");
      } else if (e.code == 'weak-password') {
        print("The account already exists for the email");
      }

      throw Exception(e.code);
    }
  }

  //sign out
  signOut() async {
    return await _auth.signOut();
  }
}
