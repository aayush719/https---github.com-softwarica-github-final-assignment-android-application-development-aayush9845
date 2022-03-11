import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order.dart';
import '../models/responseorder.dart';
import '../response/getorder_resp.dart';

class HttpConnectOrder {
  static final baseurl = 'https://bishwahardware.herokuapp.com/api/orders';

  //sending data to the server--- creating user
  Future<bool> placeOrder(Order order) async {
    dynamic token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    Map<String, dynamic> orderMap = {
      "user": order.user,
      "product": order.product,
      "quantity": order.quantity,
      "totalPrice": order.totalPrice,
    };

    final response = await post(Uri.parse(baseurl),
        body: orderMap, headers: {'x-auth-token': token});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<ResponseOrder>> getOrders() async {
    final response = await http.get(Uri.parse(baseurl));
    if (response.statusCode == 200) {
      var a = ResponseGetOrder.fromJson(jsonDecode(response.body));

      return a.data;
    } else {
      throw Exception('Failed to load orders');
    }
  }

  static Future<String> getPrice() async {
    final orders = await getOrders();

    var p = 0;
    for (var i = 0; i < orders.length; i++) {
      p = p + int.parse(orders[i].totalPrice);
    }
    return p.toString();
  }

  static Future<String> deleteOrder(String id) async {
    dynamic token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    final response = await http.delete(Uri.parse(baseurl + "/" + id),
        headers: {"x-auth-token": token});

    if (response.statusCode == 200) {
      final a = "deleted";
      return a;
    } else {
      throw Exception('Failed to delete order');
    }
  }
}
