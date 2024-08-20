import 'package:flutter/material.dart';

void main() {
  runApp(ConversorValores());
}

class ConversorValores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Valores',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      home: Index(),
    );
  }
}

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final TextEditingController _controller = TextEditingController();
  double? _resultado;
  String _moedaEntrada = 'BRL';
  String _moedaSaida = 'USD';

  // Atualize as taxas de conversão para valores mais realistas
  Map<String, double> taxasConversao = {
    'BRL': 1.0,
    'USD': 0.20,      // 1 BRL = 0.20 USD (valor aproximado)
    'GBP': 0.16,      // 1 BRL = 0.16 GBP (valor aproximado)
    'EUR': 0.19,      // 1 BRL = 0.19 EUR (valor aproximado)
    'AOA': 162.0,     // 1 BRL = 162 AOA (valor aproximado)
    'PYG': 1450.0,    // 1 BRL = 1450 PYG (valor aproximado)
  };

  void _converter() {
    setState(() {
      double valor = double.tryParse(_controller.text) ?? 0;
      double taxaEntrada = taxasConversao[_moedaEntrada] ?? 0;
      double taxaSaida = taxasConversao[_moedaSaida] ?? 0;
      _resultado = valor / taxaEntrada * taxaSaida;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor de Valores'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Insira um valor',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text('Moeda de entrada:', style: Theme.of(context).textTheme.headlineSmall),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent, width: 1.5),
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _moedaEntrada,
                              onChanged: (String? novaMoeda) {
                                setState(() {
                                  _moedaEntrada = novaMoeda!;
                                });
                              },
                              items: taxasConversao.keys.map<DropdownMenuItem<String>>((String moeda) {
                                return DropdownMenuItem<String>(
                                  value: moeda,
                                  child: Center(child: Text(moeda)),  // Centraliza o texto do item
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        children: [
                          Text('Moeda de saída:', style: Theme.of(context).textTheme.headlineSmall),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent, width: 1.5),
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _moedaSaida,
                              onChanged: (String? novaMoeda) {
                                setState(() {
                                  _moedaSaida = novaMoeda!;
                                });
                              },
                              items: taxasConversao.keys.map<DropdownMenuItem<String>>((String moeda) {
                                return DropdownMenuItem<String>(
                                  value: moeda,
                                  child: Center(child: Text(moeda)),  // Centraliza o texto do item
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _converter,
                  child: Text('Converter valores'),
                ),
                SizedBox(height: 20),
                if (_resultado != null)
                  Text(
                    'Resultado: ${_resultado!.toStringAsFixed(2)} $_moedaSaida',
                    style: TextStyle(fontSize: 20),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}