import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import manquant
import 'package:sup4_dev_fluttertrello/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Instance Firestore

  // Connexion avec gestion d'erreur détaillée
  Future<UserModel?> signIn(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return await _userFromFirebaseUser(result.user!);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e.code);
    } catch (e) {
      throw "Une erreur inattendue s'est produite";
    }
  }

  // Inscription avec création du document user dans Firestore
  Future<UserModel?> signUp(String email, String password) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      
      // Crée automatiquement le document user dans Firestore
      final user = await _userFromFirebaseUser(result.user!);
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(user.toFirestore());
          
      return user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e.code);
    } catch (e) {
      throw "Échec de la création du compte";
    }
  }

  // Conversion User Firebase → UserModel
  Future<UserModel> _userFromFirebaseUser(User user) async {
    final doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      return UserModel.fromFirestore(doc);
    } else {
      // Nouvel utilisateur
      return UserModel(
        uid: user.uid,
        email: user.email!,
        role: 'user', // Par défaut
        projects: [],
      );
    }
  }

  // Gestion des erreurs Firebase Auth
  String _handleAuthError(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Email invalide';
      case 'user-disabled':
        return 'Compte désactivé';
      case 'user-not-found':
        return 'Utilisateur non trouvé';
      case 'wrong-password':
        return 'Mot de passe incorrect';
      case 'email-already-in-use':
        return 'Email déjà utilisé';
      case 'operation-not-allowed':
        return 'Opération non autorisée';
      case 'weak-password':
        return 'Mot de passe trop faible';
      default:
        return 'Erreur d\'authentification';
    }
  }

  // Déconnexion
  Future<void> signOut() async {
    await _auth.signOut();
  }
}