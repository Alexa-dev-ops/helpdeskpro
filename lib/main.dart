import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart'; // For image picking
import 'dart:io'; // For file operations

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TESCOM Helpdesk',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  // For animation
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final _picker = ImagePicker(); // Image picker instance
  File? _selectedImage; // For storing the picked image
  final TextEditingController _requestController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Function to submit request
  Future<void> _submitRequest() async {
    if (_requestController.text.isNotEmpty && _selectedImage != null) {
      // TODO: Upload the request and image to Firebase
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request submitted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and upload an image.')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _requestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TESCOM Helpdesk'),
        backgroundColor: Colors.blue,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Submit a Request',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _requestController,
                decoration: const InputDecoration(
                  labelText: 'Describe your issue or request',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: const Text('Upload Image'),
                  ),
                  const SizedBox(width: 16),
                  _selectedImage != null
                      ? Image.file(
                          _selectedImage!,
                          height: 100,
                          width: 100,
                        )
                      : const Text('No image selected'),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitRequest,
                child: const Text('Submit Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
