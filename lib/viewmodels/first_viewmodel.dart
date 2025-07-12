import 'package:flutter/material.dart';

class FirstViewModel extends ChangeNotifier {
  String _name = '';
  String _palindrome = '';

  String get name => _name;
  String get palindrome => _palindrome;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setPalindrome(String palindrome) {
    _palindrome = palindrome;
    notifyListeners();
  }

  bool isPalindrome() {
    if (_palindrome.trim().isEmpty) return false;

    final cleaned = _palindrome.replaceAll(' ', '').toLowerCase();
    final reversed = cleaned.split('').reversed.join('');
    return cleaned == reversed;
  }

  bool get hasValidPalindromeInput => _palindrome.trim().isNotEmpty;
}
