import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/components/adaptative_button.dart';
import 'package:personal_expenses/components/adaptative_date_picker.dart';
import 'package:personal_expenses/components/adaptative_text_field.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  final TextEditingController _selectedDate = TextEditingController();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    final stringDate = _selectedDate.text;
    // Transforma a data no formato String em DateTime novamente:
    DateTime date = DateFormat('dd/MM/y').parse(stringDate);

    if (title.isEmpty || value <= 0 /*|| _selectedDate == null*/) {
      return;
    }

    widget.onSubmit(title, value, date);
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
      if (pickedDate != null) {
        setState(() {
          _selectedDate.text = DateFormat('dd/MM/y').format(pickedDate);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Card(
          margin: EdgeInsets.fromLTRB(
              0, 0, 0, 0 + MediaQuery.of(context).viewInsets.bottom),
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
                  child: AdaptativeTextField(
                    controller: _titleController,
                    onSubmitted: (_) => _submitForm(),
                    label: 'Título',
                    suffixIcon: const Icon(
                      Icons.title_rounded,
                      color: Color(0xFF938F99),
                    ),
                    hintText: 'Digite um título',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 18,
                  ),
                  child: AdaptativeTextField(
                    controller: _valueController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    onSubmitted: (_) => _submitForm(),
                    label: 'Valor',
                    suffixIcon: const Icon(
                      Icons.attach_money_rounded,
                      color: Color(0xFF938F99),
                    ),
                    hintText: '000.00',
                  ),
                ),
                // AdaptativeTextField(
                //     controller: _selectedDate,
                //     keyboardType: const TextInputType.numberWithOptions(decimal: true),
                //     onSubmitted: (_) => _submitForm(),
                //     label: 'Data',
                //     suffixIcon: const Icon(
                //       Icons.calendar_today_rounded,
                //       color: Color(0xFF938F99),
                //     ),
                //     hintText: 'dd/mm/aaaa',
                //   ),

                //Novo Date Picker
                // AdaptativeDatePicker(
                //   selectedDate: _selectedDate,
                //   onDateChanged: (newDate) {
                //     setState(() {
                //       _selectedDate = newDate;
                //     });
                //   },
                // ),

                TextField(
                  controller: _selectedDate,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_) => _submitForm(),
                  readOnly: true,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.calendar_today_rounded,
                      color: Color(0xFF938F99),
                    ),
                    labelText: 'Data',
                    labelStyle: TextStyle(
                      color: Color(0xFFE5E1E6),
                      fontWeight: FontWeight.normal,
                    ),
                    hintText: 'dd/mm/aaaa',
                    hintStyle: TextStyle(
                      color: Color(0xFF938F99),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF938F99),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFC9BEFF),
                      ),
                    ),
                    focusColor: Color(0xFFC9BEFF),
                  ),
                  onTap: _showDatePicker,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: AdaptativeButton(
                        'Nova Transação',
                        _submitForm,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
