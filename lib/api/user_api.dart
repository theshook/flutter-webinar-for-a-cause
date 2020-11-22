import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webinar_for_a_cause/api/api.dart';
import 'package:webinar_for_a_cause/models/user.dart';

class UserApi {
  Future<List<User>> getUsersData() async {
    var response = await http.get('${ApiDart.url}/users');

    if (response.statusCode != 200) throw "Can't get user data";

    List<User> user = (jsonDecode(response.body) as List)
        .map((e) => User.fromJson(e))
        .toList();
    return user;
  }

  Future<User> addUserData(User user) async {
    var response = await http.post(
      '${ApiDart.url}/users',
      body: user.toJson(),
    );

    if (response.statusCode != 201) throw "Can't create user data";

    User newUser = User.fromJson(jsonDecode(response.body));

    return newUser;
  }

  Future<void> deleteUserData(int id) async {
    var response = await http.delete(
      '${ApiDart.url}/users/$id',
    );

    if (response.statusCode != 200) throw "Can't delete user data";
  }
}
