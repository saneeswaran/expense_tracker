import 'package:expense_tracker/constants/constants.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/screens/dashboard/component/update_expense.dart';
import 'package:expense_tracker/util/transitions_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseProvider>(
      context,
      listen: false,
    ).fetchAllExpenses(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _card(size: size)),
          Consumer<ExpenseProvider>(
            builder: (context, value, child) {
              final expense = value.filteredExpenses;
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final data = expense[index];
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            value.deleteExpense(
                              context: context,
                              expenseId: data.id,
                            );
                          },
                          label: "delete",
                          icon: Icons.delete,
                        ),
                        SlidableAction(
                          onPressed:
                              (context) =>
                                  TransitionsAnimation.moveToNextPageWithDowntoUp(
                                    context,
                                    route: UpdateExpense(
                                      expenseId: data.id,
                                      title: data.name,
                                      amount: data.amount.toString(),
                                      icon: data.icon,
                                      selectedCategory: data.category,
                                      type: data.type,
                                    ),
                                  ),
                          label: "update",
                          icon: Icons.edit,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(data.name),
                      subtitle: Text("${data.createdAt}"),
                      leading: CircleAvatar(child: Icon(data.icon)),
                      trailing: Text(
                        data.type == "Income"
                            ? "+${data.amount}"
                            : "-${data.amount}",
                        style: TextStyle(
                          color:
                              data.type == "Income" ? Colors.green : Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                }, childCount: expense.length),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _card({required Size size}) {
    return SizedBox(
      height: size.height * 0.5,
      width: size.width,
      child: Stack(
        children: [
          Container(
            height: size.height * 0.4,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Constants.backgroundRectangle),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.08),
              child: ListTile(
                title: const Text(
                  "Hello,",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                subtitle: const Text(
                  "User name",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications, color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.2,
            left: size.width * 0.10,
            child: Container(
              padding: EdgeInsets.all(size.width * 0.03),
              height: size.height * 0.3,
              width: size.width * 0.80,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(46, 124, 119, 1),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade700,
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: _expenses(size: size),
            ),
          ),
        ],
      ),
    );
  }

  Widget _expenses({required Size size}) {
    return Consumer<ExpenseProvider>(
      builder: (context, value, child) {
        final totalAmount = value.formatMoney(value.totalAmount);
        final totalIncome = value.formatMoney(value.totalIncome);
        final totalExpenses = value.formatMoney(value.totalExpense);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text(
                "Total Balance",
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
              subtitle: Text(
                totalAmount,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _customRow(icon: Icons.arrow_downward_outlined, text: "Income"),
                _customRow(icon: Icons.arrow_upward_outlined, text: "Expenses"),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    totalIncome,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    totalExpenses,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _customRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 26),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
