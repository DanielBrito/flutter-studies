import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:user_crud/models/user.dart';
import 'package:user_crud/provider/users.dart';
import 'package:user_crud/routes/app_routes.dart';

class UserTile extends StatelessWidget {
  const UserTile({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl.isEmpty
        ? const CircleAvatar(
            child: Icon(Icons.person),
          )
        : CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl),
          );

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () => {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.userForm, arguments: user)
                    },
                icon: const Icon(Icons.edit),
                color: Colors.orange),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Remove user"),
                            content: const Text("Are you sure?"),
                            actions: [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text("No")),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text("Yes"))
                            ],
                          )).then((confirmed) {
                    if (confirmed) {
                      Provider.of<Users>(context, listen: false).remove(user);
                    }
                  });
                },
                icon: const Icon(Icons.delete),
                color: Colors.red)
          ],
        ),
      ),
    );
  }
}
