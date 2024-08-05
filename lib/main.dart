import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PalmReadingPage(),
    );
  }
}

class PalmReadingPage extends StatefulWidget {
  @override
  _PalmReadingPageState createState() => _PalmReadingPageState();
}

class _PalmReadingPageState extends State<PalmReadingPage> {
  File? _image;
  final picker = ImagePicker();
  String _message = 'No Palm is detected in the uploaded image, please try again.';

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image captured.');
      }
    });
  }

  void scanImage() {
    // Here you would implement the logic to scan the image and detect the palm
    // For demonstration, we just print a message
    if (_image != null) {
      print('Scanning image...');
      // Simulate scanning delay
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _message = 'No Palm is detected in the uploaded image, please try again.';
        });
      });
    } else {
      print('No image to scan.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Palm Reading'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _message,
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            _image == null
                ? Container(height: 150, width: 150, color: Colors.grey[300], child: Icon(Icons.image, size: 100, color: Colors.grey[600]))
                : Image.file(_image!, height: 150, width: 150, fit: BoxFit.cover),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getImageFromGallery,
              child: Text('Choose file'),
            ),
            Text('OR'),
            ElevatedButton(
              onPressed: getImageFromCamera,
              child: Text('Capture'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: scanImage,
              child: Text('Scan'),
            ),
          ],
        ),
      ),
    );
  }
}
