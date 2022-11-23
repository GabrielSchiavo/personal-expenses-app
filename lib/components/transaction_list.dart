import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                    child: Text(
                      'Nenhuma Despesa Cadastrada!',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
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
                  trailing: MediaQuery.of(context).size.width > 480
                      ? TextButton.icon(
                          onPressed: () => onRemove(tr.id),
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          label: Text(
                            'Excluir',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.error),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete_forever_rounded),
                          color: Theme.of(context).colorScheme.error,
                          onPressed: (() => onRemove(tr.id)),
                        ),
                ),
              );
            },
          );
  }
}
