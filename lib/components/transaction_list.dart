import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1080,
      child: transactions.isEmpty
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text(
                    'Nenhuma Despesa Cadastrada!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              //Renderiza somente os itens que estiveremm aparecendo na tela
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Card(
                  clipBehavior: Clip.none,
                  color: Theme.of(context).colorScheme.background,
                  shadowColor: Theme.of(context).colorScheme.shadow,
                  surfaceTintColor: Theme.of(context).colorScheme.primary,
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            'R\$${tr.value.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: const TextStyle(
                        fontFamily: 'RobotoFlex',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFFE5E1E6),
                      ),
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.date),
                      style: const TextStyle(
                        color: Color(0xFF938F99),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_forever_rounded),
                      color: Theme.of(context).colorScheme.error,
                      onPressed: (() => onRemove(tr.id)),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
