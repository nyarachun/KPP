import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  static final AuthRepository instance = AuthRepository();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Stream<User?> userChanges() => _auth.userChanges();

  Future<void> signUp({required String name, required String email, required String password}) async {
    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await credential.user!.updateDisplayName(name);
    await _analytics.logSignUp(signUpMethod: 'email');
  }

  Future<void> signIn({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    await _analytics.logLogin(loginMethod: 'email');
  }

  Future<void> resetPassword({required String email}) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() => _auth.signOut();

  Future<void> updateProfile({required String name, String? photoUrl}) async {
    await currentUser!.updateDisplayName(name);
    await currentUser!.updatePhotoURL(photoUrl);
    await currentUser!.reload();
  }

  Future<void> changePassword({required String currentPassword, required String newPassword}) async {
    final user = currentUser!;
    final credential = EmailAuthProvider.credential(email: user.email!, password: currentPassword);
    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);
  }

  static String errorMessage(Object error) {
    if (error is! FirebaseAuthException) return 'Something went wrong. Please try again.';
    switch (error.code) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
        return 'Wrong email or password.';
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'invalid-email':
        return 'This email address is invalid.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'requires-recent-login':
        return 'Please sign out and sign in again, then retry.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      case 'network-request-failed':
        return 'No internet connection.';
      default:
        return 'Error: ${error.message}';
    }
  }
}
