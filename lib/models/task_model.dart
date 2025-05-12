import 'package:cloud_firestore/cloud_firestore.dart';

enum TaskStatus { todo, inProgress, done }

class TaskModel {
  final String id;
  final String title;
  final String? description;
  final TaskStatus status;
  final String assigneeId;
  final String projectId;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    this.status = TaskStatus.todo,
    this.assigneeId = '',
    required this.projectId,
  });

  factory TaskModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return TaskModel(
      id: doc.id,
      title: data['title'] ?? 'Nouvelle Tâche',
      description: data['description'],
      status: _parseStatus(data['status']),
      assigneeId: data['assigneeId'] ?? '',
      projectId: data['projectId'] ?? '',
    );
  }

  static TaskStatus _parseStatus(String status) {
    switch (status) {
      case 'inProgress': return TaskStatus.inProgress;
      case 'done': return TaskStatus.done;
      default: return TaskStatus.todo;
    }
  }

  Map<String, dynamic> toFirestore() => {
        'title': title,
        'description': description,
        'status': status.toString().split('.').last,
        'assigneeId': assigneeId,
        'projectId': projectId,
      };
}