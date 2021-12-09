import 'package:flutter/material.dart';

import 'routes/app_routes.dart';

import 'views/auth/login.dart';
import 'views/auth/sign_up.dart';

import 'views/operations/balance.dart';
import 'views/operations/transaction.dart';
import 'views/operations/edit_account.dart';
import 'views/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fake Bank',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.newAccount: (context) => const SignUpPage(),
        AppRoutes.mainMenu: (context) => const MainMenuPage(),
        AppRoutes.balance: (context) => const BalancePage(),
        AppRoutes.transaction: (context) => const TransactionPage(),
        AppRoutes.editAccount: (context) => const EditAccountPage(),
      },
    );
  }
}
