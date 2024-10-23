import 'package:flutter/material.dart';
import '../models/ticket.dart';

class TicketItem extends StatelessWidget {
  final Ticket ticket;

  const TicketItem({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ticket.requestType.isNotEmpty ? ticket.requestType : 'N/A',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              ticket.description.isNotEmpty
                  ? ticket.description
                  : 'No description provided.',
            ),
            const SizedBox(height: 8.0),
            if (ticket.imageUrl != null &&
                ticket.imageUrl!.isNotEmpty) // Check for imageUrl
              Image.network(ticket.imageUrl!),
            const SizedBox(height: 8.0),
            Text(
              'Status: ${ticket.status}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Created at: ${ticket.createdAt.toDate().toLocal().toString().split(' ')[0]}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
