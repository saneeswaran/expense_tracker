import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseHistory extends StatelessWidget {
  const ExpenseHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ExpenseProvider>(
        builder: (context, value, child) {
          final expense =
              value.filteredExpenses
                  .where((expense) => expense.type == "Expense")
                  .toList();
          return ListView.builder(
            itemCount: expense.length,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Icon(value.filteredExpenses[index].icon),
                ),
                title: Text(value.filteredExpenses[index].name),
                subtitle: Text("${value.filteredExpenses[index].createdAt}"),
                trailing: Text(
                  value.filteredExpenses[index].amount.toString(),
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
