// models/ticket.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket {
  final String id;
  final String userId;
  final String department;
  final String requestType;
  final String description;
  final String? imageUrl; // Nullable if no image is uploaded
  final String status; // e.g., 'Pending', 'Approved', 'Rejected'
  final Timestamp createdAt;

  Ticket({
    required this.id,
    required this.userId,
    required this.department,
    required this.requestType,
    required this.description,
    this.imageUrl,
    required this.status,
    required this.createdAt,
  });

  // Factory method to create a Ticket instance from a Firestore document
  factory Ticket.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Ticket(
      id: doc.id,
      userId: data['userId'] ?? '',
      department: data['department'] ?? '',
      requestType: data['requestType'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'], // Nullable, so can be null
      status: data['status'] ?? 'Pending', // Default to 'Pending'
      createdAt: data['createdAt'] as Timestamp,
    );
  }
}
