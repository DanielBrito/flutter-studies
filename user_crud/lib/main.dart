import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:user_crud/provider/users.dart';

import 'package:user_crud/routes/app_routes.dart';

import 'package:user_crud/views/user_form.dart';
import 'package:user_crud/views/user_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Users(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          AppRoutes.home: (context) => const UserList(),
          AppRoutes.userForm: (context) => const UserForm()
        },
      ),
    );
  }
}
