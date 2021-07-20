import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {

  final Function saveNewTransaction;

  NewTransaction(this.saveNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = new TextEditingController();

  final TextEditingController amountController = new TextEditingController();
  DateTime _pickedDate;


  void submitData()
  {
    final enteredTitle = this.titleController.text;
    final enteredAmount = double.parse(this.amountController.text);


    if(enteredTitle.isEmpty || enteredAmount <=0)
    {
      return;
    }

    this.widget.saveNewTransaction(
      enteredTitle,
      enteredAmount,
      _pickedDate==null? DateTime.now():_pickedDate
      );
    Navigator.of(context).pop();  
  }

  void _pickDate()
  {
    showDatePicker(context: context ,
     initialDate: DateTime.now(),
     firstDate: DateTime(2021),
     lastDate: DateTime.now()
     ).then((pickedDate){
       if(pickedDate == null)
       {
         return;
       }
       setState(() {
        this._pickedDate = pickedDate; 
       });

     });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                   controller: titleController,
  //                  onSubmitted: (_) => submit_Data(),

                    ),
                  TextField(decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  keyboardType: TextInputType.number,
   //               onSubmitted: (_) => submit_Data(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Text(_pickedDate==null?
                      'No Date Chosen'
                      :'Date : ${DateFormat.yMd().format(_pickedDate)}'),

                      FlatButton(
                        child: Icon(Icons.date_range,color: Theme.of(context).primaryColorLight,),
                        onPressed: _pickDate,
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      color: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Add Transaction',
                        style: TextStyle(color: Colors.black)
                        ,),
                        onPressed: submitData,
                    )
                  ),
                ]
              ),
            );
  }
}