import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<User?> get onAuthStateChanges => _firebaseAuth.idTokenChanges();

  Future<Object> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Logged In";
    } catch (e) {
      return e;
    }
  }

  Future<Object> signUp(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed Up";
    } catch (e) {
      return e;
    }
  }
}
