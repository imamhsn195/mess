class Expense{
  final DateTime date;
  final int createdBy;
  final String description;
  final double amount;
  Expense(
      this.date,
      this.createdBy,
      this.description,
      this.amount
  );
  Map<String, dynamic> toJson() => {
    "date" : date,
    "created_by" : createdBy,
    "description" : description,
    "amount" : amount,
  };
}