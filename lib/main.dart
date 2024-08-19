import 'package:flutter/material.dart';

void main() {
  runApp(conversorValores());
}

class conversorValores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: index(),
    );
  }
}

class index extends StatefulWidget {
  @override
  _indexState createState() => _indexState();
}

class _indexState extends State<index> {
  final TextEditingController _controller = TextEditingController();
  double? _dolar;
  double? _libra;
  double? _euro;
  double? _kwanzas;
  double? _guaranis;

  void _somarUm() {
    setState(() {
      double valor = double.tryParse(_controller.text) ?? 0;
      _dolar = valor * 0.18;
      _libra = valor * 0.14;
      _euro = valor * 0.17;
      _kwanzas = valor * 164.51;
      _guaranis = valor * 1402.25;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Converter valores'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Insira um valor em reais'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _somarUm,
              child: Text('Converter valores'),
            ),
            SizedBox(height: 20),
            if (_dolar != null)
              Text(
                'Dolar: $_dolar \nLibra: $_libra \nEuro: $_euro \nkwanzas $_kwanzas\nGuaranis: $_guaranis',
                style: TextStyle(fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}

