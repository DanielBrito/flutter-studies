import 'dart:math';

import 'package:flutter/material.dart';

import 'package:user_crud/data/dummy_users.dart';
import 'package:user_crud/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = {...dummyUsers};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int index) {
    return _items.values.elementAt(index);
  }

  void put(User user) {
    if (_items.containsKey(user.id)) {
      print("EXIST");

      _items.update(
          user.id,
          (_) => User(
              id: user.id,
              name: user.name,
              email: user.email,
              avatarUrl: user.avatarUrl));
    } else {
      print("NOT EXIST");

      final id = Random().nextDouble().toString();

      _items.putIfAbsent(
          id,
          () => User(
              id: id,
              name: user.name,
              email: user.email,
              avatarUrl: user.avatarUrl));
    }

    notifyListeners();
  }

  void remove(User user) {
    _items.remove(user.id);

    notifyListeners();
  }
}
