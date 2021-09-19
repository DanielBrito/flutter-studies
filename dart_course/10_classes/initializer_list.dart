class BankAccount {
  BankAccount({double this.balance = 0, required this.holder});

  double balance;
  String holder;

  void deposit(double amount) {
    balance += amount;
  }

  bool withdraw(double amount) {
    if (balance >= amount) {
      balance -= amount;
      return true;
    }

    return false;
  }
}

main() {
  final account = BankAccount(holder: "Daniel", balance: 100);

  account.deposit(100);
  account.deposit(50);

  var result1 = account.withdraw(100);
  print("Success $result1, balance: ${account.balance}");

  var result2 = account.withdraw(150);
  print("Success $result2, balance: ${account.balance}");
}
