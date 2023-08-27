import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class TransactionForm extends StatefulWidget {
  final void Function(String, double, double, double, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _kmInicialController = TextEditingController();
  final _kmFinalController = TextEditingController();
  final _litrosController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();



  _submitForm() {
    final title = _titleController.text;
    final kmInicial = double.tryParse(_kmInicialController.text.replaceAll(",", ".")) ?? 0.0;
    final kmFinal = double.tryParse(_kmFinalController.text.replaceAll(",", ".")) ?? 0.0;
    final litros = double.tryParse(_litrosController.text.replaceAll(",", ".")) ?? 0.0;
    final valorAbt = double.tryParse(_valueController.text.replaceAll(",", ".")) ?? 0.0;

    if (title.isEmpty || valorAbt <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, kmInicial, kmFinal,  litros, valorAbt, _selectedDate!);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }
  //calculos


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.fire_truck),
                  labelText: 'Placa',
                ),inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter,
                PlacaVeiculoInputFormatter()
              ],
              ),
              TextField(
                controller: _kmInicialController,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.gps_fixed),
                  labelText: 'Km Inicial',
                ),
              ),
              TextField(
                controller: _kmFinalController,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.route),
                  labelText: 'Km Final',
                ),
              ),
              TextField(
                controller: _litrosController,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.local_gas_station),
                  labelText: 'Litros Abastecido',
                ),
              ),
              TextField(
                controller: _valueController,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
                  labelText: 'Valor (R\$)',
                ),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Nenhuma data selecionada!'
                            : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate!)}',
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        'Selecionar Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _showDatePicker,
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                     ElevatedButton(
                    child:  Text(
                      'Nova Transação',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.button?.color,
                      ),
                    ),
                    onPressed: _submitForm,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
