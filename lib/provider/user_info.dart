import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'dart:convert';

import '../provider/user_details.dart';
import 'package:http/http.dart' as http;

class UserInfo with ChangeNotifier {
  List users = [];

  Future<void> fetchUsers() async {
    final url = Uri.parse('https://reqres.in/api/users?page=2');
    final response = await http.get(url);
    final extractedData = json.decode(response.body)['data'];
    users = extractedData;
    notifyListeners();
  }

  Future<void> postUser(String fullName, String jobName) async {
    final url = Uri.parse('https://reqres.in/api/users/');

    final response = await http.post(url,
        body: json.encode({
          "name": fullName,
          "job": jobName,
          "id": Random().nextInt(1000) + 6.toInt(),
          "createdAt": DateTime.now().toString(),
        }));
    print(response.statusCode);
    print(response.body);
  }
}
