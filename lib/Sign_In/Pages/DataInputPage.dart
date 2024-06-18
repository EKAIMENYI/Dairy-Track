import 'package:flutter/material.dart';
import '../Pages/DailyData.dart';

class DataInputPage extends StatefulWidget {
  final String title;
  final Function(DailyData) onSubmit;

  DataInputPage({required this.title, required this.onSubmit});

  @override
  _DataInputPageState createState() => _DataInputPageState();
}

class _DataInputPageState extends State<DataInputPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildTextField('day', 'Day', TextInputType.text),
              _buildDatePicker('date', 'Date'),
              _buildTextField('milkProduction', 'Milk Production (L)',
                  TextInputType.number),
              _buildTextField(
                  'healthyCows', 'Healthy Cows (%)', TextInputType.number),
              _buildTextField(
                  'sickCows', 'Sick Cows (%)', TextInputType.number),
              _buildTextField('amount', 'Amount', TextInputType.number),
              _buildTextField('description', 'Description', TextInputType.text),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String key, String label, TextInputType inputType) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: inputType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      onSaved: (value) {
        _formData[key] = value!;
      },
    );
  }

  Widget _buildDatePicker(String key, String label) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            _formData[key] != null ? _formData[key].toString() : label,
          ),
        ),
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              setState(() {
                _formData[key] = pickedDate;
              });
            }
          },
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      DailyData newData = DailyData(
        day: _formData['day']!,
        date: _formData['date']!,
        milkProduction: int.parse(_formData['milkProduction']!),
        healthyCows: int.parse(_formData['healthyCows']!),
        sickCows: _formData['sickCows'] != null
            ? int.parse(_formData['sickCows']!)
            : null,
        amount: _formData['amount'] != null
            ? double.parse(_formData['amount']!)
            : null,
        description: _formData['description'],
      );
      widget.onSubmit(newData);
      Navigator.pop(context);
    }
  }
}
