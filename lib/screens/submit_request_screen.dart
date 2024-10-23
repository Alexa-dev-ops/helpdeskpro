// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SubmitRequestScreen extends StatefulWidget {
  const SubmitRequestScreen({super.key});

  @override
  State<SubmitRequestScreen> createState() => _SubmitRequestScreenState();
}

class _SubmitRequestScreenState extends State<SubmitRequestScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedRequestType;
  String? _imageUrl; // For storing the uploaded image URL
  // ignore: unused_field
  File? _image; // To store the image file

  final List<String> requestTypes = [
    'Technical Issue',
    'Access Request',
    'Other'
  ];

  Future<void> _submitRequest() async {
    if (_selectedRequestType == null || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    // Create a new ticket in Firestore
    await FirebaseFirestore.instance.collection('tickets').add({
      'userId': 'user_id_placeholder', // Replace with actual user ID
      'department': 'department_placeholder', // Replace with actual department
      'requestType': _selectedRequestType,
      'description': _descriptionController.text,
      'imageUrl': _imageUrl, // Optional
      'status': 'Pending',
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Request submitted successfully!')),
    );

    // Optionally, clear fields or navigate back
    Navigator.pop(context);
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      setState(() {
        _image = File(selectedImage.path);
        // Here you would typically upload the image to your server and get the URL
        _imageUrl = 'url_placeholder'; // Replace with the uploaded image URL
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              hint: const Text('Select Request Type'),
              value: _selectedRequestType,
              items: requestTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRequestType = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Upload Image (optional)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitRequest,
              child: const Text('Submit Request'),
            ),
          ],
        ),
      ),
    );
  }
}
