import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class HttpConnectUser {
  String baseurl = 'https://bishwahardware.herokuapp.com/api/users';
  static String token = '';
  static String userId = '';

  //sending data to the server--- creating user
  Future<bool> registerPost(User user) async {
    Map<String, dynamic> userMap = {
      "firstName": user.firstName,
      "lastName": user.lastName,
      "email": user.email,
      "password": user.password,
      "address": user.address,
      "phoneNumber": user.phoneNumber
    };

    final response = await post(Uri.parse(baseurl), body: userMap);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //sending data to the server- login as user
  Future loginPosts(String? email, String? password) async {
    Map<String, dynamic> loginStudent = {'email': email, 'password': password};

    try {
      final response = await post(
          Uri.parse(
            "https://bishwahardware.herokuapp.com/api/auth",
          ),
          body: loginStudent);

      //json serializing inline
      final jsonData = jsonDecode(response.body) as Map;

      token = jsonData['token'];

      if (token != '') {
        return jsonData;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
