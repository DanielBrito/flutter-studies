import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:user_crud/components/user_tile.dart';
import 'package:user_crud/provider/users.dart';
import 'package:user_crud/routes/app_routes.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("User List"),
          actions: [
            IconButton(
                onPressed: () =>
                    {Navigator.of(context).pushNamed(AppRoutes.userForm)},
                icon: const Icon(Icons.add))
          ],
        ),
        body: ListView.builder(
          itemCount: users.count,
          itemBuilder: (context, index) => UserTile(user: users.byIndex(index)),
        ));
  }
}
