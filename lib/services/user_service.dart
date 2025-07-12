import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  static const _baseUrl = 'https://reqres.in/api/users';

  Future<List<User>> fetchUsers({int page = 1, int perPage = 10}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?page=$page&per_page=$perPage'),
      headers: {
        'x-api-key': 'reqres-free-v1',
      },
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body)['data'];
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
