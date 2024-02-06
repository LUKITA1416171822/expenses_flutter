import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpenseItem extends StatelessWidget{
 const ExpenseItem(this.expense,{super.key});
final Expense expense;
  @override
  Widget build(BuildContext context) {
   final width=MediaQuery.of(context).size.width;
    return   Card(
      margin: EdgeInsets.all(8.0), // add some margin around the card
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(children: [
              const SizedBox(width: 15),
              Text(
                expense.title,
                style: Theme.of(context).textTheme.titleLarge,
              )
            ]),
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(width: 15),
                SizedBox(
                  width: 80, // add a fixed width for the amount text
                  child: Text('\$${expense.amount.toStringAsFixed(2)}'),
                ),
                 SizedBox(width: width<600?150:128),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 4),
                    Text(expense.formattedDate,textAlign: TextAlign.right)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );

  }
  
}