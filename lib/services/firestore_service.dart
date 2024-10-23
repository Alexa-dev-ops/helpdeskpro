import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ticket.dart'; // Updated import statement

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection reference for tickets
  CollectionReference get tickets => _db.collection('tickets');

  // Add a new ticket
  Future<void> addTicket(Ticket ticket) {
    return tickets.doc(ticket.id).set({
      'userId': ticket.userId,
      'department': ticket.department,
      'requestType': ticket.requestType,
      'description': ticket.description,
      'imageUrl': ticket.imageUrl,
      'status': ticket.status,
      'createdAt': ticket.createdAt,
    });
  }

  // Update an existing ticket
  Future<void> updateTicket(Ticket ticket) {
    return tickets.doc(ticket.id).update({
      'status': ticket.status,
      // Add more fields to update as necessary
    });
  }

  // Get a ticket by ID
  Future<Ticket?> getTicketById(String id) async {
    DocumentSnapshot doc = await tickets.doc(id).get();
    if (doc.exists) {
      return Ticket.fromFirestore(doc);
    }
    return null;
  }

  // Get all tickets
  Stream<List<Ticket>> getAllTickets() {
    return tickets.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Ticket.fromFirestore(doc)).toList();
    });
  }

  // Delete a ticket
  Future<void> deleteTicket(String id) {
    return tickets.doc(id).delete();
  }
}
