import 'dart:io';
import 'package:flutter/material.dart';
import 'package:glucoma_detection/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String _uploadStatus = '';

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      setState(() {
        _uploadStatus = 'No image selected.';
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    String uploadUrl = 'http://13.53.57.205:8000/predict/';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
      request.files.add(await http.MultipartFile.fromPath('file', _image!.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        setState(() {
          _uploadStatus = 'Success: $respStr';
        });
      } else {
        setState(() {
          _uploadStatus = 'Failed to upload image. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _uploadStatus = 'Failed to upload image: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!,),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload Image'),
            ),
            SizedBox(height: 20),
            Text(_uploadStatus),
          ],
        ),
      ),
    );
  }
}
