class DataClass {
  static int availableBalance = 0;
  static String userKey = "";

  // add amount
  static void addRecharge(int amount) {
    availableBalance += amount;
  }

  // withdraw amount
  static void withdraw(int amount) {
    availableBalance -= amount;
  }
}
