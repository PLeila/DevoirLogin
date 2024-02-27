import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('loginForm '),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black, Colors.blue],
                ),
              ),
            )),
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  bool _termsChecked = false;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'first name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Non obligatwa';
                } else if (value.length < 2) {
                  return 'Non dwe gen omwen 2 karakter';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'last name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Prenon obligatwa';
                } else if (value.length < 2) {
                  return 'Prenon dwe gen omwen 2 karakter';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email obligatwa';
                } else if (!_isValidEmail(value)) {
                  return 'Email pa valide';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'password'),
              obscureText: true,
              onChanged: (value) {
                _password = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'password mandatory';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'confirm password'),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'for confirm password mandatory';
                } else if (value != _password) {
                  return 'your confirmation does not match';
                }
                return null;
              },
            ),
            CheckboxListTile(
              title: Text("I totally agree."),
              value: _termsChecked,
              onChanged: (bool? value) {
                setState(() {
                  _termsChecked = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            ElevatedButton(
              onPressed: () {
                if (!_termsChecked) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'you must check theses conditions before submitting.')),
                  );
                } else {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Submitting Form')),
                    );
                    _formKey.currentState!.reset();
                    _termsChecked = false;
                  }
                }
              },
              child: Text('ok'),
            ),
          ],
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email);
  }
}
