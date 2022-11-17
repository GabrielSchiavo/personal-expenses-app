import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  // DateTime? _selectedDate;
  TextEditingController _selectedDate = TextEditingController();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: ColorScheme.dark(
            primary: Theme.of(context).colorScheme.primary,
            onPrimary: Theme.of(context).colorScheme.onPrimary,
            surface: Theme.of(context).colorScheme.primaryContainer,
          ),
          dialogBackgroundColor: Theme.of(context).colorScheme.background,
        ),
        child: child!,
      ),
    ).then((pickedDate) {
      // if (pickedDate == null) {
      //   return;
      // }

      // setState(() {
      //   _selectedDate = pickedDate;
      // });

      if (pickedDate != null) {
        setState(() {
          _selectedDate.text = DateFormat('dd/MM/y').format(pickedDate);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Theme.of(context).colorScheme.background,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 18, 0, 18),
              child: TextField(
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.title_rounded,
                    color: Color(0xFFE5E1E6),
                  ),
                  labelText: 'Título',
                  labelStyle: TextStyle(
                    color: Color(0xFFE5E1E6),
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE5E1E6),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE5E1E6),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
              child: TextField(
                controller: _valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.attach_money_rounded,
                    color: Color(0xFFE5E1E6),
                  ),
                  labelText: 'Valor',
                  hintText: '0.00',
                  hintStyle: TextStyle(
                    color: Color(0xFF938F99),
                  ),
                  labelStyle: TextStyle(
                    color: Color(0xFFE5E1E6),
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE5E1E6),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE5E1E6),
                    ),
                  ),
                ),
              ),
            ),
            TextField(
              controller: _selectedDate,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              readOnly: true,
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.calendar_today_rounded,
                  color: Color(0xFFE5E1E6),
                ),
                labelText: 'Data',
                hintText: 'dd/mm/aaaa',
                hintStyle: TextStyle(
                  color: Color(0xFF938F99),
                ),
                labelStyle: TextStyle(
                  color: Color(0xFFE5E1E6),
                  fontWeight: FontWeight.normal,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFE5E1E6),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFE5E1E6),
                  ),
                ),
              ),
              onTap: _showDatePicker,
            ),
            // SizedBox(
            //   height: 80,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Text(
            //           _selectedDate == null
            //               ? 'Nenhuma data selecionada!'
            //               : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate!)}',
            //           style: const TextStyle(
            //             color: Color(0xFFE5E1E6),
            //           ),
            //         ),
            //       ),
            //       TextButton.icon(
            //         style: TextButton.styleFrom(
            //           // side: const BorderSide(
            //           //   width: 1.3,
            //           //   color: Color(0xFFE5E1E6),
            //           // ),
            //           backgroundColor: Theme.of(context).colorScheme.background,
            //         ),
            //         icon: const Icon(
            //           Icons.calendar_today_rounded,
            //           color: Color(0xFFE5E1E6),
            //         ),
            //         onPressed: _showDatePicker,
            //         label: const Padding(
            //           padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            //           // child: Text(
            //           //   'Selecionar Data',
            //           //   style: TextStyle(
            //           //     color: Color(0xFFE5E1E6),
            //           //   ),
            //           // ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      // side: const BorderSide(
                      //   width: 1,
                      //   color: Colors.deepPurple,
                      // ),
                    ),
                    onPressed: _submitForm,
                    child: const Text(
                      'Nova Transação',
                      style: TextStyle(
                        color: Color(0xFF312075),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
