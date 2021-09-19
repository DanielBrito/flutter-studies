class BankAccount {
  BankAccount(double this._balance);

  // The underscore defines a private attribute:
  double _balance;

  double get balance => _balance;

  void deposit(double amount) {
    _balance += amount;
  }

  void withdraw(double amount) {
    if (_balance >= amount) {
      _balance -= amount;
    }
  }
}
