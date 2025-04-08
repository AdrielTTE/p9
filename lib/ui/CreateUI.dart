import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:p9/models/Product.dart';
import 'package:p9/services/DatabaseService.dart';


class CreateUi extends StatefulWidget {
  final String title;

  const CreateUi(this.title);

  @override
  _ProductInputPageState createState() => _ProductInputPageState();
}


class _ProductInputPageState extends State<CreateUi> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  //TODO - Save the profile image into the app folder
  Future<void> _savePicture(String fName) async {
    if (_image != null) {
      try {
         // Save the image to a specific location
        final appDocDir = await getApplicationDocumentsDirectory();
        final newImagePath = '${appDocDir.path}/${fName}';

        await _image!.copy(newImagePath);

        print('File image copied successfully to $newImagePath');
      } catch (e) {
        print('File error copying image: $e');
      }
    } else {

      AlertDialog(
        title: const Text('Profile Image'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Profile Image'),
              Text('Profile Image file is missing.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }

  void _submitProduct() {
    String description = _descriptionController.text;
    String price = _priceController.text;

    if (description.isEmpty || price.isEmpty || _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields and upload an image')),
      );
      return;
    }else{
      DatabaseService dbService = DatabaseService();
      //final dbService.initDatabase();

      var product = ProductModel(
          id: 0,
          description: description,
          price: double.parse(price),
          img: '${description}.png');
      dbService.insertProduct(product);
  _savePicture(product.img);
      setState(() {

      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),

            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 20),

            _image != null ? Image.file(_image!, height: 150) : Text("No image selected"),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Upload Image"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: _submitProduct,
              child: Text("Submit"),
            ),

          ],
        ),
      ),
    );
  }
}
