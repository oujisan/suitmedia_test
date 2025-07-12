import 'package:flutter/material.dart';
import 'package:suitmedia_test/models/user.dart';
import 'package:suitmedia_test/services/user_service.dart';

class ThirdViewModel extends ChangeNotifier {
  final UserService _userService = UserService();

  List<User> _users = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchInitialUsers() async {
    _page = 1;
    _users = [];
    _hasMore = true;
    await _fetchUsers();
  }

  Future<void> refreshUsers() async {
    _page = 1;
    _users = [];
    _hasMore = true;
    await _fetchUsers();
  }

  Future<void> loadMoreUsers() async {
    if (_isLoading || !_hasMore) return;
    _page++;
    await _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetched = await _userService.fetchUsers(page: _page);
      if (fetched.isEmpty) {
        _hasMore = false;
      } else {
        _users.addAll(fetched);
      }
    } catch (e) {
      debugPrint("Error fetching users: $e");
      _hasMore = false;
    }

    _isLoading = false;
    notifyListeners();
  }
}
