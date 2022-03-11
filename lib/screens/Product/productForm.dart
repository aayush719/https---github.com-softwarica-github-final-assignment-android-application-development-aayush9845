import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shop_app/http/httpproduct.dart';
import 'package:shop_app/models/item.dart';
import 'package:shop_app/screens/Product/adminList.dart';

import '../home/home_screen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static String routeName = "/productForm";

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formkey = GlobalKey<FormState>();
  String? imageData;
  Uint8List? imageBytes;
  File? _imageF;

  String name = '';
  String quantity = '';
  String description = '';
  String price = '';
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 66, 64, 64),
        title: const Text('New Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  // color: Colors.amberAccent,
                  alignment: Alignment.center,
                  child: const Text(
                    'Add Product',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageF == null
                          ? const AssetImage('assets/images/product_image.jpg')
                              as ImageProvider
                          : FileImage(_imageF!),
                      child: InkWell(
                        onTap: () => _getImage(ImageSource.camera),
                        child: const Icon(
                          Icons.upload,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (value) {
                    name = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name:',
                    hintText: 'Enter the productname',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    description = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Description:',
                    hintText: 'Enter product description',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    price = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Price:',
                    hintText: 'Enter price',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    quantity = newValue!;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Quantity:',
                    hintText: 'Enter Stock Quantity',
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () async {
                    _formkey.currentState!.save();
                    Item item = await Item(
                        name: name,
                        description: description,
                        price: price,
                        quantity: quantity,
                        image: imageData!,
                        id: '');
                    var value = await HttpConnectProduct.addProductPosts(item);
                    if (value == "added") {
                      Navigator.pushNamed(context, ProductList.routeName);
                      MotionToast.success(
                              description: Text('Product added successfully'))
                          .show(context);
                    } else {
                      MotionToast.error(
                              description: Text('Failed to add product'))
                          .show(context);
                    }
                  },
                  child: const Text('Add Product'),
                ),
                const SizedBox(height: 10),
              ],
            )),
      ),
    );
  }

  _getImage(ImageSource imageSource) async {
    var imageFile = (await picker.pickImage(source: imageSource));

    if (imageFile == null) return '';
    // image to Uint8List
    setState(() {
      _imageF = File(imageFile.path);
    });
    print(_imageF);
    imageBytes = _imageF!.readAsBytesSync();
    // from camera image path to base64
    Uint8List bytes = Uint8List.fromList(imageBytes!);
    imageData = 'data:image/jpeg;base64,' + base64.encode(bytes);
    return imageData;
  }
}
