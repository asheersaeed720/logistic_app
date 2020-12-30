class Balance {
  Balance({
    this.balance,
    this.pending,
    this.cancelled,
    this.lastTransaction,
    this.transactions,
  });

  String balance;
  String pending;
  String cancelled;
  var lastTransaction;
  List<Transaction> transactions;

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        balance: json["balance"],
        pending: json["pending"],
        // lastTransaction: DateTime.parse(json["last_transaction"]),
        cancelled: json["cancelled"],
        lastTransaction: json["last_transaction"],
        transactions: List<Transaction>.from(
            json["transactions"].map((i) => Transaction.fromJson(i))),
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "pending": pending,
        "cancelled": cancelled,
        "last_transaction": lastTransaction.toIso8601String(),
        "transactions": List<dynamic>.from(transactions.map((i) => i.toJson())),
      };
}

class Transaction {
  Transaction({
    this.id,
    this.orderid,
    this.userid,
    this.datetime,
    this.amount,
    this.type,
  });

  String id;
  String orderid;
  String userid;
  DateTime datetime;
  String amount;
  String type;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        orderid: json["orderid"],
        userid: json["userid"],
        datetime: DateTime.parse(json["datetime"]),
        amount: json["amount"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderid": orderid,
        "userid": userid,
        "datetime": datetime.toIso8601String(),
        "amount": amount,
        "type": type,
      };
}
