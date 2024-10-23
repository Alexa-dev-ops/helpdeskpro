import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ticket.dart';

class RequestDetailScreen extends StatelessWidget {
  final Ticket ticket;

  const RequestDetailScreen({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Request Type: ${ticket.requestType}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Description: ${ticket.description}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Department: ${ticket.department}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${ticket.status}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Created At: ${ticket.createdAt.toDate().toLocal()}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Update the ticket status to 'Approved' (or any other logic)
                await FirebaseFirestore.instance
                    .collection('tickets')
                    .doc(ticket.id)
                    .update({
                  'status': 'Approved'
                }); // Change this based on your logic
                // Show a confirmation message
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request approved!')),
                );
                // Optionally, navigate back or refresh the ticket details
              },
              child: const Text('Approve Request'),
            ),
          ],
        ),
      ),
    );
  }
}
