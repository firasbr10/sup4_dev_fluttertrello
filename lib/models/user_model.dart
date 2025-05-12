import 'package:cloud_firestore/cloud_firestore.dart'; 

class UserModel {
  final String uid;
  final String email;
  final String role; // 'user' ou 'admin'
  final List<String> projects; // IDs des projets associés

  UserModel({
    required this.uid,
    required this.email,
    this.role = 'user',
    this.projects = const [],
  });

  // Conversion Firestore
  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!; // Notez le '!' pour forcer le non-null
    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      role: data['role'] ?? 'user',
      projects: List<String>.from(data['projects'] ?? []),
    );
  }

  // Optionnel : Convertir en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'role': role,
      'projects': projects,
    };
  }
}