import 'dart:convert';
import 'package:api/Model/usermodel1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static Future<AsyncSnapshot<User>> fetchUser() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final user = User.fromJson(data['results'][0]);
      return AsyncSnapshot.withData(ConnectionState.done, user);
    } else {
      return AsyncSnapshot.withError(ConnectionState.done, 'Failed to load user');
    }
  }
}
