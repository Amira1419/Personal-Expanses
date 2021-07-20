import 'package:assignment_2/widgets/chart.dart';
import 'package:assignment_2/widgets/new_transaction.dart';
import 'package:assignment_2/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './models/Transaction.dart';

void main()  
{
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]);
  runApp(
  MaterialApp(
    title: 'the Chart App',
    home:MyApp(),
    theme: ThemeData(
      primarySwatch: Colors.pink,
      accentColor: Colors.blueGrey,
      errorColor: Colors.red,
      textTheme: ThemeData.light().textTheme.copyWith(title: 
        TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 18,
          fontWeight: FontWeight.bold,

        )
      ),
      fontFamily: 'Quicksand',
      appBarTheme: AppBarTheme(
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold
          )

        )
      ),
    ),

    
    )
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
    final List<Transaction> transactions =[];


    void _saveNewTansaction(String title,double amount,DateTime dateTime)
    {
      Transaction newTX=new Transaction(id: new DateTime.now().toString(),title: title,amount: amount,date: dateTime);
      setState(() {
        transactions.add(newTX);
      });
    }


  startAddNewTransaction(BuildContext cntxt)
  {
    showModalBottomSheet(context: cntxt , builder:(_){
        return 
          NewTransaction(this._saveNewTansaction);

    } );
  }

  void _deleteTransaction(String id)
  {

    setState(() {
      transactions.removeWhere((tx){
      return tx.id == id;
    });
      
    });
  }

  bool _showChart = false;


  List<Transaction> get _recentTransaction{
    return transactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))
      );

    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
          title: Text('The Chart App'),
        );
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    
    return 
       Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if(isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(value: _showChart,
                  onChanged: (value){
                    setState(() {
                     _showChart = value; 
                    });
                  },

                  ),
                ],
              ),
              isLandscape?
              (_showChart?chartWidget(isLandscape , appBar):listWidget(appBar))
              :
              Column(
                children: <Widget>[
                  chartWidget(isLandscape, appBar),
                  listWidget(appBar)
                ],
              )


             ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child:Icon(Icons.add),
          onPressed: () => startAddNewTransaction(context),
          ),

      );

  }

  Widget chartWidget(bool isLanscape, AppBar appBar)
  {
    return Container(
            height: (MediaQuery.of(context).size.height 
            - appBar.preferredSize.height 
            - MediaQuery.of(context).padding.top) * (isLanscape ? 0.7 : 0.3) ,
            child: Chart(_recentTransaction)
    );
  }
  Widget listWidget(AppBar appBar)
  {
    return Container(
            height: (MediaQuery.of(context).size.height 
            - appBar.preferredSize.height 
            - MediaQuery.of(context).padding.top) * 0.7,
            child: TransactionList(transactions,this._deleteTransaction)
    ); 

  }
}

