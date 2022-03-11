import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/response/getproduct_resp.dart';
import '../models/item.dart';
import 'httpuser.dart';

class HttpConnectProduct {
  static final baseurl = 'https://bishwahardware.herokuapp.com/api/products';

  static Future<List<Item>> getProducts() async {
    final response = await http.get(Uri.parse(baseurl));
    if (response.statusCode == 200) {
      var a = ResponseGetItem.fromJson(jsonDecode(response.body));

      return a.data;
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<Item> getProduct(String id) async {
    final p = await getProducts();
    return p.singleWhere((element) => element.id == id);
  }

  static Future<String> addProductPosts(Item item) async {
    dynamic token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    Map<String, dynamic> productMap = {
      'name': item.name,
      'description': item.description,
      'quantity': item.quantity,
      'price': item.price,
      'image': item.image
    };

    final response =
        await http.post(Uri.parse(baseurl), body: productMap, headers: {
      'x-auth-token': token,
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return "added";
    } else {
      throw Exception('failed');
    }
  }

  static Future<String> updateProductPosts(Item item) async {
    dynamic token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    Map<String, dynamic> productMap = {
      'name': item.name,
      'description': item.description,
      'quantity': item.quantity,
      'price': item.price,
      'image': item.image
    };
    print(productMap);

    final response = await http.put(Uri.parse(baseurl + "/" + item.id),
        body: productMap, headers: {'x-auth-token': token});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return "updated";
    } else {
      throw Exception('failed');
    }
  }

  static Future<String> deleteProduct(String id) async {
    dynamic token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    print(token);

    final response = await http.delete(Uri.parse(baseurl + "/" + id),
        headers: {'x-auth-token': token});

    if (response.statusCode == 200) {
      final a = "deleted";
      return a;
    } else {
      throw Exception('Failed to delete order');
    }
  }
}
