import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  final String id;
  final String name;
  final String ownerId;
  final List<String> members;
  final DateTime createdAt;

  ProjectModel({
    required this.id,
    required this.name,
    required this.ownerId,
    this.members = const [],
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ProjectModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ProjectModel(
      id: doc.id,
      name: data['name'] ?? 'Nouveau Projet',
      ownerId: data['ownerId'] ?? '',
      members: List<String>.from(data['members'] ?? []),
      createdAt: data['createdAt']?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'ownerId': ownerId,
        'members': members,
        'createdAt': createdAt,
      };
}