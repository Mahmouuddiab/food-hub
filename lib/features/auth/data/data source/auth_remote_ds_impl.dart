import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_hub/core/helper/cache_helper.dart';
import 'package:food_hub/features/auth/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'auth_remote_ds.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDsImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDsImpl(this._firebaseAuth,);

  ///  Login
  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = credential.user;
      CacheHelper.saveUserId(user?.uid?? "");
      print("user id = ${user?.uid}");
      if (user == null) throw Exception("User not found");

      return UserModel.fromFirebase(user);
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    }
  }

  ///  Register
  @override
  Future<UserModel> register(
      String name,
      String email,
      String password,
      ) async {
    try {
      final credential =
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = credential.user;
      if (user == null) throw Exception("User not created");

      // Save name
      await user.updateDisplayName(name.trim());

      // Refresh user
      await user.reload();
      final updatedUser = _firebaseAuth.currentUser;

      if (updatedUser == null) throw Exception("User reload failed");

      return UserModel.fromFirebase(updatedUser);
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    }
  }

  ///  Logout
  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  ///  Get Current User
  @override
  UserModel? getCurrentUser() {
    final user = _firebaseAuth.currentUser;
    return user != null ? UserModel.fromFirebase(user) : null;
  }


  ///  Error Mapper (Clean & Scalable)
  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return "No user found for this email";
      case 'wrong-password':
        return "Incorrect password";
      case 'email-already-in-use':
        return "Email is already registered";
      case 'invalid-email':
        return "Invalid email format";
      case 'weak-password':
        return "Password must be at least 6 characters";
      case 'user-disabled':
        return "This account has been disabled";
      case 'too-many-requests':
        return "Too many attempts. Try again later";
      case 'network-request-failed':
        return "Check your internet connection";
      default:
        return e.message ?? "Authentication failed";
    }
  }
}
