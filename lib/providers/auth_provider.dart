import 'package:flutter/material.dart';
import 'package:sup4_dev_fluttertrello/services/auth_service.dart';
import 'package:sup4_dev_fluttertrello/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    try {
      _currentUser = await _authService.signIn(email, password);
      notifyListeners();
      return true; // Retourne true si la connexion réussit
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      _currentUser = await _authService.signUp(email, password);
      notifyListeners();
      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _currentUser = null;
    notifyListeners();
  }
}