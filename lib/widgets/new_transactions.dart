import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  late DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredamount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredamount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredamount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            decoration: const InputDecoration(labelText: 'title'),
            // onChanged: (value) => titleInput = value,
            controller: _titleController,
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'amount'),
            // onChanged: (value) => amountInput = value,
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No data Chosen'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                  ),
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: _presentDatePicker,
                  child: const Text(
                    'Choosen Data',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
            child: const Text('Add Transaction'),
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).textTheme.button?.color,
            onPressed: _submitData,
          ),
        ]),
      ),
    );
  }
}
