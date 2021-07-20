import '../models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions,this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty?
    LayoutBuilder(
      builder: (cntx,constraints){
        return Column(
          children: <Widget>[
            Text('No Transactions added yet!!!',
            style: Theme.of(context).textTheme.title
            ),
            Container(
              height: constraints.maxHeight * 0.7,
              child: Image.asset('lib/assets/images/no_data_found.png',
              fit: BoxFit.cover)
              ),
          ],

        );
      },
    ) 
    : ListView.builder(
      itemBuilder: (ctx,index){
        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
                leading: CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      child: Text('\$${transactions[index].amount.toStringAsFixed(2)}')),
                  ),
                  radius: 30,
                ),
                title: Text('${transactions[index].title}',
                  style: Theme.of(context).textTheme.title
                ),
                subtitle: Text(DateFormat('yyyy/MM/dd').format(transactions[index].date),
                  style:TextStyle(color: Colors.grey)
                ),

                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteTransaction(transactions[index].id),
                  color: Theme.of(context).errorColor,
                  ),

              )
            );
      },
      itemCount: transactions.length,
    );
  }
}