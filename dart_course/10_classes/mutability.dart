class BankAccount {
  BankAccount({double this.balance = 0, required this.holder});

  double balance;
  final String holder;

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
}
