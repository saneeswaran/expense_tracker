import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ExpenseProvider extends ChangeNotifier {
  List<ExpenseModel> _allExpenses = [];
  List<ExpenseModel> _filteredExpenses = [];

  List<ExpenseModel> get allExpenses => _allExpenses;
  List<ExpenseModel> get filteredExpenses => _filteredExpenses;

  double get totalAmount {
    double total = 0;
    for (var expense in _allExpenses) {
      total += expense.amount;
    }
    return total;
  }

  double get totalIncome {
    double total = 0;
    for (var expense in _allExpenses) {
      if (expense.type == "Income") {
        total += expense.amount;
      }
    }
    return total;
  }

  double get totalExpense {
    double total = 0;
    for (var expense in _allExpenses) {
      if (expense.type == "Expense") {
        total += expense.amount;
      }
    }
    return total;
  }

  double get availableBalance {
    double available = 0;
    available = totalIncome - totalExpense;
    return available;
  }

  String formatMoney(num amount) {
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(1)}Cr';
    } else if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(1)}L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return amount.toStringAsFixed(0);
    }
  }

  Future<bool> addExpense({
    required BuildContext context,
    required String name,
    required double amount,
    required IconData icon,
    required String type,
    required String category,
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final CollectionReference collection = FirebaseFirestore.instance
          .collection("expenses");
      final date = DateTime.now();
      final formattedDate = DateFormat('dd-mm-yyyy').format(date);
      final ExpenseModel data = ExpenseModel(
        id: '',
        name: name,
        amount: amount,
        iconCode: icon.codePoint,
        category: category,
        userId: userId,
        createdAt: formattedDate,
        type: type,
      );

      final docRef = await collection.add(data.toMap());

      final newExpense = data.copyWith(id: docRef.id);
      _allExpenses.add(newExpense);
      _filteredExpenses = _allExpenses;

      if (context.mounted) {
        successSnackBar("Expense added successfully", context);
      }
      notifyListeners();
      return true;
    } catch (e) {
      if (context.mounted) {
        warningSnackBar(e.toString(), context);
      }
      return false;
    }
  }

  Future<List<ExpenseModel>> fetchAllExpenses({
    required BuildContext context,
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final collection = FirebaseFirestore.instance.collection("expenses");

      final querySnapshot =
          await collection.where('userId', isEqualTo: userId).get();

      final List<ExpenseModel> expenses =
          querySnapshot.docs.map((doc) {
            final data = doc.data();
            return ExpenseModel(
              id: doc.id,
              name: data['name'],
              amount: data['amount'],
              iconCode: data['iconCode'],
              category: data['category'],
              userId: data['userId'],
              createdAt: data['createdAt'],
              type: data['type'],
            );
          }).toList();

      _allExpenses = expenses;
      _filteredExpenses = _allExpenses;
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        warningSnackBar(e.toString(), context);
      }
    }
    return _allExpenses;
  }

  Future<bool> deleteExpense({
    required BuildContext context,
    required String expenseId,
  }) async {
    try {
      final collection = FirebaseFirestore.instance.collection("expenses");
      await collection.doc(expenseId).delete();

      _allExpenses.removeWhere((element) => element.id == expenseId);
      _filteredExpenses = _allExpenses;
      notifyListeners();
      return true;
    } catch (e) {
      if (context.mounted) {
        warningSnackBar("Error deleting expense", context);
      }
      return false;
    }
  }

  Future<bool> updateExpense({
    required BuildContext context,
    required String id,
    required String name,
    required int iconCode,
    required double amount,
    required String createdAt,
    required String type,
    required String category,
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final CollectionReference collection = FirebaseFirestore.instance
          .collection("expenses");
      final newData = ExpenseModel(
        id: id,
        name: name,
        iconCode: iconCode,
        userId: userId,
        category: category,
        amount: amount,
        createdAt: createdAt,
        type: type,
      );
      await collection.doc(id).update(newData.toMap());
      if (context.mounted) fetchAllExpenses(context: context);
      notifyListeners();
      return true;
    } on FirebaseException catch (e) {
      if (context.mounted) {
        warningSnackBar(e.toString(), context);
      }
      return false;
    }
  }
}
