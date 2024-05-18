import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dairy Track App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFECEBEE), // Light blue base color
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Dairy Track App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  String _cowName = '';
  String _cowTag = '';
  double _cowWeight = 0.0; // Assuming weight is a double
  DateTime? _dateOfBirth; // Date of birth as a DateTime object

  // Function to handle form submission (add logic for storing data)
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Implement logic to store cow information (e.g., database, local storage)
      print('Cow information: $_cowName, $_cowTag, $_cowWeight, $_dateOfBirth');
      // Optionally, clear the form after successful submission
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        // Allow scrolling for long forms
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Assign the form key
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Cow Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name for the cow.';
                    }
                    return null;
                  },
                  onSaved: (value) => setState(() => _cowName = value!),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Cow Tag',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the cow\'s tag number.';
                    }
                    return null;
                  },
                  onSaved: (value) => setState(() => _cowTag = value!),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Weight (kg)',
                  ),
                  keyboardType: TextInputType.number, // For numeric input
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the cow\'s weight.';
                    }
                    try {
                      double.parse(value);
                      return null; // Valid input
                    } catch (e) {
                      return 'Please enter a valid weight.';
                    }
                  },
                  onSaved: (value) =>
                      setState(() => _cowWeight = double.parse(value!)),
                ),
                Row(
                  children: [
                    Text('Date of Birth:'),
                    TextButton(
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000, 1),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          setState(() => _dateOfBirth = pickedDate);
                        }
                      },
                      child: Text(_dateOfBirth?.toString() ?? 'Select Date'),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit Cow Information'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
