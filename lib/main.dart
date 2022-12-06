import 'dart:math';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/components/chart.dart';
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
      debugShowCheckedModeBanner: false,
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
          bodyLarge: const TextStyle(
            fontSize: 16,
            fontFamily: 'RobotoFlex',
            color: Color(0xFFE5E1E6),
            fontWeight: FontWeight.bold,
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
  bool _showChart = false;

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

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(
            icon: Icon(icon),
            onPressed: fn,
            color: Theme.of(context).colorScheme.onBackground,
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList =
        Platform.isIOS ? CupertinoIcons.list_bullet : Icons.list_rounded;
    final iconChart = Platform.isIOS
        ? CupertinoIcons.chart_bar_alt_fill
        : Icons.bar_chart_rounded;

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(
          _showChart ? iconList : iconChart,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add_rounded,
        () => _openTransactionFormModal(context),
      ),
    ];

    final PreferredSizeWidget appBar = AppBar(
      title: const Text('Despesas Pessoais'),
      actions: actions,
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // if (isLandscape)
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       const Text(
              //         'Exibir Gráfico',
              //         style: TextStyle(color: Color(0xFFE5E1E6)),
              //       ),
              //       Switch.adaptive(
              //         value: _showChart,
              //         onChanged: ((value) {
              //           setState(() {
              //             _showChart = value;
              //           });
              //         }),
              //         activeColor: Theme.of(context).colorScheme.primary,
              //         inactiveTrackColor: Theme.of(context).colorScheme.outline,
              //       ),
              //     ],
              //   ),
              if (_showChart || !isLandscape)
                SizedBox(
                  height: availableHeight * (isLandscape ? 0.65 : 0.22),
                  child: Chart(_recentTransactions),
                ),
              if (!_showChart || !isLandscape)
                SizedBox(
                  height: availableHeight * (isLandscape ? 1 : 0.73),
                  child: TransactionList(_transactions, _removeTransaction),
                ),
            ],
          ),
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              title: const Text(
                'Despesas Pessoais',
              ),
              backgroundColor: Theme.of(context).colorScheme.background,
              foregroundColor: Theme.of(context).colorScheme.onBackground,
              actions: actions,

              //Altera a cor e os icones da statusBar
              // systemOverlayStyle: const SystemUiOverlayStyle(
              //   statusBarColor: Color(0xFF1C1B1F),
              //   statusBarIconBrightness: Brightness.light,
              //   statusBarBrightness: Brightness.dark,
              // ),
            ),
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    onPressed: () => _openTransactionFormModal(context),
                    elevation: 5,
                    child: const Icon(Icons.add_rounded),
                  ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
  }
}
