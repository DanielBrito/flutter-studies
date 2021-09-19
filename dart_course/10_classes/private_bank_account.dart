import 'bank_account.dart';

main() {
  final account = BankAccount(100);

  /// account._balance = 1000; // Error - Private attribute

  account.deposit(100);

  print(account.balance);
}
