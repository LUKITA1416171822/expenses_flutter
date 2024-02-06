import 'package:flutter/material.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/expenses.dart';
import 'package:flutter/cupertino.dart';
class NewExpense extends StatefulWidget {


  const NewExpense(this.onAddExpense,{super.key});
final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selecetd_Category=Category.leisure;
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    //final lastDate=DateTime(now.year-1,now.month,now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }
void _submitExpenseDate(){
  final enteredAmount= double.tryParse(_amountController.text);
   final amountIsInvalid= enteredAmount==null || enteredAmount<=0;
    if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate==null)
    {showCupertinoDialog(context: context, builder: (ctx)=>CupertinoAlertDialog(
      title:const Text('Invalid input') ,
      content: const Text('Please make sure a valid title, amount,date and category was entered.'),
      actions: [
        TextButton(onPressed:() =>Navigator.pop(ctx), child:
        const Text('Okay'))
      ],
    )
    );
       // showDialog(context: context, builder: (ctx)=> AlertDialog(
       //   title:const Text('Invalid input') ,
       //   content: const Text('Please make sure a valid title, amount,date and category was entered.'),
       // actions: [
       //   TextButton(onPressed:() =>Navigator.pop(ctx), child:
       //   const Text('Okay'))
       // ],
       // )
       // );
       return;
    }
widget.onAddExpense(Expense(title: _titleController.text, amount: enteredAmount, date: _selectedDate!, category: _selecetd_Category));
Navigator.pop(context);
  }
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Keyboardspace=MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width=constraints.maxWidth;

      return SizedBox(height: double.infinity,child:  SingleChildScrollView( child: Padding(
        padding:  EdgeInsets.fromLTRB(16, 48, 16,Keyboardspace+16),
        child: Column(children: [
          if(width>=600)
            Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: TextField(
                  controller: _titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(label: Text('Title')),
                ),),
                const SizedBox(width: 24),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    maxLength: 50,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        prefixText: '\$', label: Text('Amount')),
                  ),
                ),
              ],
            )
          else
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          if(width>=600)
            Row(
              children: [
                DropdownButton(
                    value:_selecetd_Category,
                    items: Category.values
                        .map((category) => DropdownMenuItem(
                      value: category,
                      child: Text(category.name.toUpperCase()),
                    ))
                        .toList(),
                    onChanged: (value) {
                      if(value==null) {
                        return;
                      }
                      setState(() {
                        _selecetd_Category=value;
                      });

                    }),
                const SizedBox(width: 25,),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate == null
                          ? 'No date seleceted'
                          : formatter.format(_selectedDate!)),
                      IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(Icons.calendar_month))
                    ],
                  ),
                )
              ],
            )
          else
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 50,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefixText: '\$', label: Text('Amount')),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No date seleceted'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 18),
          if(width>=600)
            Row(children: [const Spacer(),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
          ElevatedButton(onPressed:_submitExpenseDate, child: const Text('Save Expense'))
      ])
      else
          Row(
            children: [
              DropdownButton(
                  value:_selecetd_Category,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toUpperCase()),
                  ))
                      .toList(),
                  onChanged: (value) {
                    if(value==null) {
                      return;
                    }
                    setState(() {
                      _selecetd_Category=value;
                    });

                  }),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(onPressed:_submitExpenseDate, child: const Text('Save Expense'))
            ],
          )
        ]),
      ),),
      );
    });

  }
}
