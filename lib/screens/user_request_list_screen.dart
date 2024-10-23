// screens/user_request_list_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ticket.dart';
import '../widgets/ticket_item.dart';

class UserRequestListScreen extends StatelessWidget {
  const UserRequestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('tickets').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No requests found.'));
          }

          final tickets = snapshot.data!.docs
              .map((doc) => Ticket.fromFirestore(doc))
              .toList();

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
