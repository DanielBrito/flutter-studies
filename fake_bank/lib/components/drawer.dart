import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: ClipOval(
              child: Image.asset("assets/user.png"),
            ),
            accountName: const Text("Daniel"),
            accountEmail: const Text("daniel@email.com"),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            subtitle: const Text("Back to the homepage"),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.mainMenu),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            subtitle: const Text("Finish session"),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.login),
          ),
        ],
      ),
    );
  }
}
