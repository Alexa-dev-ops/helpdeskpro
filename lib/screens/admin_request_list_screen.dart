import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ticket.dart';
import '../widgets/ticket_item.dart';

class AdminRequestListScreen extends StatelessWidget {
  const AdminRequestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tickets')
            .where('status', isEqualTo: 'Pending') // Only show pending requests
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading requests'));
          }

          final tickets = snapshot.data!.docs.map((doc) {
            return Ticket.fromFirestore(
                doc); // Use fromFirestore instead of fromDocument
          }).toList();

          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              return TicketItem(ticket: tickets[index]);
            },
          );
        },
      ),
    );
  }
}
