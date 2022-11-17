import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses/components/chart.dart';
import 'dart:math';
import './components/transaction_form.dart';
import './components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: const MyHomePage(),
      theme: tema.copyWith(
        useMaterial3: true,
        colorScheme: tema.colorScheme.copyWith(
          primary: const Color(0xFFC9BEFF),
          onPrimary: const Color(0xFF312075),
          primaryContainer: const Color(0xFF48398D),
          onPrimaryContainer: const Color(0xFFE6DEFF),
          secondary: const Color(0xFFC9C3DC),
          background: const Color(0xFF1C1B1F),
          onBackground: const Color(0xFFE5E1E6),
          outline: const Color(0xFF938F99),
          shadow: const Color(0xFF000000),
          surface: const Color(0xFFC9BEFF),
        ),
        textTheme: tema.textTheme.copyWith(
          headlineSmall: const TextStyle(
            fontFamily: 'RobotoFlex',
            color: Color(0xFFE5E1E6),
          ),
          titleLarge: const TextStyle(
            fontFamily: 'RobotoFlex',
            color: Color(0xFFE5E1E6),
          ),
          titleMedium: const TextStyle(
            fontFamily: 'RobotoFlex',
            color: Color(0xFFE5E1E6),
          ),
          labelLarge: const TextStyle(
            fontFamily: 'RobotoFlex',
            fontSize: 12,
            color: Color(0xFFE5E1E6),
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'RobotoFlex',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    //Fecha o modal após a adição de uma nova transação
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          'Despesas Pessoais',
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () => _openTransactionFormModal(context),
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ],

        //Altera a cor e os icones da statusBar
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF1C1B1F),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(_recentTransactions),
              TransactionList(_transactions, _removeTransaction),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        onPressed: () => _openTransactionFormModal(context),
        elevation: 5,
        child: const Icon(Icons.add_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
