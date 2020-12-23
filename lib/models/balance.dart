import 'dart:convert';

class Balance {
  Balance({
    this.balance,
    this.pending,
    this.lastTransaction,
    // this.transactions,
  });

  String balance;
  String pending;
  String lastTransaction;
  // List<dynamic> transactions;

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        balance: json["balance"],
        pending: json["pending"],
        lastTransaction: json["last_transaction"],
        // transactions: List<dynamic>.from(json["transactions"].map((i) => i)),
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "pending": pending,
        "last_transaction": lastTransaction,
        // "transactions": List<dynamic>.from(transactions.map((i) => i)),
      };
}
