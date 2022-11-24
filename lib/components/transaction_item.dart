import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.tr,
    required this.onRemove,
  }) : super(key: key);

  final Transaction tr;
  final void Function(String p1) onRemove;

  @override
  Widget build(BuildContext context) {
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
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
          style: Theme.of(context).textTheme.headline1,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(tr.date),
          style: TextStyle(
            color: Theme.of(context).colorScheme.outline,
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
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete_forever_rounded),
                color: Theme.of(context).colorScheme.error,
                onPressed: (() => onRemove(tr.id)),
              ),
      ),
    );
  }
}
