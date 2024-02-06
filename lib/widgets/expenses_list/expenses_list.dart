import 'package:expenses/widgets/expenses_list/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpensesList extends StatelessWidget{
  const ExpensesList(this.onRemoveExpense,{super.key,
  required this.expenses
  });
 final List<Expense> expenses;
 final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: expenses.length,
      itemBuilder: (ctx,int) {
        return Dismissible(key: ValueKey(expenses[int]),
            background: Container(color:Theme.of(context).colorScheme.error,
            margin: EdgeInsets.symmetric(horizontal: 28)),
            onDismissed:(direction) {
          onRemoveExpense(expenses[int]);} ,
            child: ExpenseItem(expenses[int])) ;
      },
    );
  }

}